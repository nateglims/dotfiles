(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org"   . "https://orgmode.org/elpa/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'use-package-ensure)
(setq use-package-always-ensure t)

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

(ido-mode)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(show-paren-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq ring-bell-function 'ignore)

(blink-cursor-mode 0)

(setq create-lockfiles nil)

(setq-default frame-title-format "%b (%f)")
;;; Font

(set-face-attribute 'default nil :height 140)

;;; Clipboard

(setq
  x-select-enable-clipboard t
  x-select-enable-primary t)

(setq
  save-interprogram-paste-before-kill t
  apropos-do-all t
  mouse-yank-at-point t)

(global-set-key (kbd "C-x C-b") 'ibuffer)
;; Formerly Navigation

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward))

(use-package recentf
  :config
  (setq recentf-save-file (concat user-emacs-directory ".recentf"))
  (recentf-mode 1)
  (setq recentf-max-menu-items 40))

;; MacOS Specific

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-envs '("PATH"))))

;; The theme

(use-package zenburn-theme)

;; General Packages

(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)))

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

;;; Clojure

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

;;; Shell
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (clj-refactor clojure-mode-extra-font-locking clojure-mode smex uniquify exec-path-from-shell slime company projectile paredit helm zenburn-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
