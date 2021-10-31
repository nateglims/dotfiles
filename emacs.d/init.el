;;; init.el --- Emacs configuration and initialization.

;;; Commentary:

;; This is just my dotfile stuff.

;;; Code:

;; Setup a custom file so it doesn't get added here.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Package stuff.
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

(use-package undo-tree)
(use-package evil
  :after (undo-tree))

;; Font

(set-face-attribute 'default nil :height 140)

;; Clipboard

(setq
  select-enable-clipboard t
  select-enable-primary t)

(setq
  save-interprogram-paste-before-kill t
  mouse-yank-at-point t)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward))

;; MacOS Specific

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs '("PATH"))))

;; The theme

;;(use-package zenburn-theme)
(use-package gruvbox-theme)

;; General Packages

(use-package helm
  :bind ("C-x C-f" . 'helm-find-files))

(use-package smex
  :config
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package company
  :config
  (global-company-mode))

(use-package flycheck
  :config
  (global-flycheck-mode))

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

;; Rust
(use-package lsp-mode
  :ensure
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy"))

(use-package rustic
  :config
  (add-hook 'rustic-mode-hook 'tree-sitter-hl-mode))

(use-package tree-sitter)
(use-package tree-sitter-langs)

;; C

;; Org Mode

(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture))
  :config
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/org/tasks.org" "Tasks")
	   "* TODO %?\n %i\n %a")
	  ("j" "Journal" entry (file+datetree "~org/journal.org")
	   "* %?\nEntered on %U\n %i\n %a")
	  ("m" "Meeting" entry (file+headline "~/org/notes/work.org" "Meetings")
	   "* MEETING: with %?\n" :clock-in t :clock-resume t :empty-lines 1))))

;;; init.el ends here
