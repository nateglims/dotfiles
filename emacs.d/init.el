;;; init.el --- Emacs configuration and initialization.

;;; Commentary:

;; This is just my dotfile stuff.

;;; Code:

;; Setup a custom file so it doesn't get added here.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" "" custom-file))
(load custom-file)

;; Package management
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(setq backup-directory-alist `(("." . "~/.backups")))

;; UI stuff
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (and (not (eq system-type 'darwin)) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(global-linum-mode t)

(show-paren-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore)

(blink-cursor-mode 0)

(setq create-lockfiles nil)

(setq-default frame-title-format "%b (%f)")

;; Font
(let ((height (if (eq system-type 'darwin) 200 160)))
  (set-face-attribute 'default nil :height height)
  (set-face-attribute 'mode-line nil :height height))

(let ((font-list '("Inconsolata" "MesloLGL Nerd Font Mono")))
  (dolist (font font-list)
    (if (find-font (font-spec :name font))
	(set-frame-font "MesloLGL Nerd Font Mono" nil t)
      (message "%s not found." font))))

;; Clipboard
(setq
  select-enable-clipboard t
  select-enable-primary t)

(setq
  save-interprogram-paste-before-kill t
  mouse-yank-at-point t)

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; MacOS Specific

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs '("PATH"))))

;; The theme
(use-package base16-theme
  :config
  (load-theme 'base16-tokyo-night-dark))

;; Remote

(defun my-vc-off-if-remote ()
  (if (file-remote-p (buffer-file-name))
      (setq-local vc-handled-backends nil)))
(add-hook 'find-file-hook 'my-vc-off-if-remote)

;; General Packages

;;; Slightly better buffer names
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward))

;;; Key-bindings Setup

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package evil
  :after (undo-tree)
  :config
  (setq evil-search-module 'evil-search)
  (setq evil-undo-system 'undo-tree)
  (define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line))

(use-package evil-paredit
  :after (evil))

(evil-mode +1)

;;; TODO: Find non-lsp providers for flymake:
;;; 1. Clippy
;;; 2. elisp

;;; Completion

(use-package prescient)
(use-package selectrum-prescient)
(use-package company-prescient)

(use-package company
  :config (global-company-mode +1)
  :hook (company-mode . company-prescient-mode))

(use-package selectrum
  :config (progn
	    (selectrum-mode +1)
	    (selectrum-prescient-mode +1)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

;; Tramp

(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(use-package docker-tramp)

;; Project.el

(if (version< (number-to-string emacs-major-version) "28")
    (use-package project))

;; Lisps
(use-package paredit
  :config
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'ielm-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package slime
  :config
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy))
  (add-hook 'slime-mode-hook 'start-slime))

;; Clojure
(use-package clojure-mode
  :config
  (add-hook 'clojure-mode-hook 'enable-paredit-mode)
  (add-hook 'clojure-mode-hook 'subword-mode))

(use-package clojure-mode-extra-font-locking)

(use-package clj-refactor)

(use-package cider
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (setq cider-repl-pop-to-buffer-on-connect t)
  (setq cider-show-error-buffer t)
  (setq cider-auto-select-error-buffer t)
  (add-hook 'cider-repl-mode-hook 'paredit-mode))

;; Shell
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Fancy New Toys

;;; LSP
(use-package eglot
  :hook (eglot--managed-mode-hook . (lambda () (flymake-mode -1))))

;;; Tree Sitter
(use-package tree-sitter
  :init (global-tree-sitter-mode))
(use-package tree-sitter-langs)


;; Rust
(use-package rustic
  :config (progn
	    (setq rustic-lsp-client 'eglot)
	    (add-hook 'rustic-mode (lambda () (flymake-mode -1))))
  :hook ((rustic-mode . tree-sitter-hl-mode)
	 (rustic-mode . company-mode)))


;; Typescript

(use-package typescript-mode
  :hook ((typescript-mode . eglot-ensure)
	 (typescript-mode . company-mode)
	 (typescript-mode . tree-sitter-hl-mode)
	 (typescript-mode . flycheck-mode)
	 (typescript-mode . (lambda () (flymake-mode -1)))))

;; C

;; Python

;;; TODO: Setup pyright

;; Yocto

;; Org Mode

(use-package org
  :bind
  (("C-c C-o l" . org-store-link)
   ("C-c C-o a" . org-agenda)
   ("C-c C-o c" . org-capture))
  :config
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/.org/tasks.org" "Tasks")
	   "* TODO %?\n %i\n %a")
	  ("j" "Journal" entry (file+datetree "~/.org/journal.org")
	   "* %?\nEntered on %U\n %i\n %a")
	  ("m" "Meeting" entry (file+headline "~/.org/notes/work.org" "Meetings")
	   "* MEETING: with %?\n" :clock-in t :clock-resume t :empty-lines 1))))

;;; init.el ends here
