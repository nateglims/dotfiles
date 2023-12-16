;;; init.el --- Emacs configuration and initialization.

;;; Commentary:

;; This is just my dotfile stuff.

;;; Code:

;; Setup a custom file so it doesn't get added here.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" "" custom-file))
(load custom-file)

(setq use-package-always-ensure t)

;; Package management
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/") t)

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

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

(show-paren-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore)

(blink-cursor-mode 0)

(setq create-lockfiles nil)

(setq-default frame-title-format "%b (%f)")

(setq-default fill-column 80
              indent-tabs-mode nil
              tab-always-indent 'complete
              require-final-newline t)

(display-line-numbers-mode)

;; Font
(let ((height (if (eq system-type 'darwin) 200 200)))
  (set-face-attribute 'default nil :height height)
  (set-face-attribute 'mode-line nil :height height))

(let ((font-list '("Inconsolata" "MesloLGL Nerd Font Mono" "Cascadia Code")))
  (dolist (font font-list)
    (if (find-font (font-spec :name font))
        (set-frame-font font nil t)
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

(defun set-vterm-theme (theme)
  "Set vterm colors so they look more normal."
  (custom-theme-set-faces
   theme
   '(vterm-color-red ((t (:foreground "#db4b4b" :background "#24283b"))))
   '(vterm-color-green ((t (:foreground "#9ece6a" :background "#24283b"))))
   '(vterm-color-blue ((t (:foreground "#7aa2f7" :background "#24283b"))))
   '(vterm-color-cyan ((t (:foreground "#7dcfff" :background "#24283b"))))
   '(vterm-color-yellow ((t (:foreground "#e0af68" :background "#24283b"))))
   '(vterm-color-magenta ((t (:foreground "#bb9af7" :background "#24283b"))))
   '(vterm-color-black ((t (:foreground "#41486" :background "#c0caf5"))))
   '(vterm-color-white ((t (:foreground "#ffffff" :background "#24283b"))))))

;; The theme
(use-package base16-theme
  :config
  (progn
    (with-eval-after-load "base16-tokyo-night-dark-theme"
      (custom-theme-set-faces
       'base16-tokyo-night-dark
       '(vertico-current ((t (:background "#48384c" :weight bold :foreground "#c678dd")))))
      (set-vterm-theme 'base16-tokyo-night-dark))
    (load-theme 'base16-tokyo-night-dark t)))

(defun my-vc-off-if-remote ()
  (if (file-remote-p (buffer-file-name))
      (setq-local vc-handled-backends nil)))
(add-hook 'find-file-hook 'my-vc-off-if-remote)

;; General Packages

(use-package vterm)

;;; Key-bindings Setup

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package meow
  :config
  (load-file (expand-file-name "meow.el" user-emacs-directory))
  (meow-setup)
  (meow-global-mode))

;;; Completion etc

;;; Consult?

(use-package orderless
  :ensure t
  :config
  (add-to-list 'completion-styles 'orderless))

(use-package marginalia
  :ensure t
  :config (marginalia-mode))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode)
  :bind (:map corfu-map ("Tab" . corfu-popupinfo-scroll-down)))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))

(use-package vertico
  :ensure t
  :bind (:map vertico-map
              ("TAB" . minibuffer-complete)
              ("C-n" . vertico-next)
              ("C-p" . vertico-previous)
              ;:map minibuffer-local-map
              ;("C-w" . backward-kill-word)
              )
  :init  (vertico-mode)
  :custom (vertico-cycle t))

(use-package vertico-directory
  :after vertico
  :ensure nil
  :bind (:map vertico-map
              ("TAB" . vertico-directory-enter)
              ("C-j" . vertico-directory-enter)
              ("C-l" . vertico-directory-delete-word)
              ("C-w" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package consult
  :ensure t)

;; Tramp

(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

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

;; Set JAVA_HOME
(let ((home (getenv "HOME")))
  (if (not (null home))
      (let ((sdkdir (concat (file-name-as-directory (getenv "HOME"))
                            ".sdkman/candidates/java/current")))
        (if (file-directory-p sdkdir)
            (setenv "JAVA_HOME" sdkdir)
          (message "SDKMAN Dir Not Found.")))
    (message "$HOME is null.")))

;; Shell

(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;;; LSP, etc.
(setq-default eglot-workspace-configuration
    '((:gopls .
        ((staticcheck . t)
         (matcher . "CaseSensitive")))))

(defun eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))

(add-hook 'flymake-diagnostic-functions #'eglot-flymake-backend)

;;; Tree Sitter
(require 'treesit)

(setq treesit-language-source-alist
      '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (rust "https://github.com/tree-sitter/tree-sitter-rust" "master" "src")
        (toml "https://github.com/ikatyang/tree-sitter-toml" "master" "src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml" "master" "src")
        (python "https://github.com/tree-sitter/tree-sitter-python" "master" "src")
        (bash "https://github.com/tree-sitter/tree-sitter-bash" "master" "src")))

(defun install-treesit-grammars ()
  (interactive)
  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist)))

;; 1) try treesit-language-available-p (maybe)
;; 2) add more langs: Go

;;; Python

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)))
(add-hook 'python-ts-mode-hook #'eglot-ensure)

;; Rust

(require 'rust-ts-mode)

(use-package cargo
  :config
  (add-hook 'rust-ts-mode-hook #'cargo-minor-mode))

(add-hook 'rust-ts-mode-hook #'eglot-ensure)


;; Typescript
(use-package apheleia)

(require 'typescript-ts-mode)
(add-hook 'typescript-ts-mode-hook #'eglot-ensure)

;; Go
(use-package go-mode)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(add-hook 'go-mode-hook 'eglot-ensure)

(add-hook 'go-mode-hook #'eglot-format-buffer-on-save)

 ;; Zig

(use-package zig-mode)

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
