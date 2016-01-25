;; Some bindings and things for org mode

(setq org-default-notes-file (expand-file-name "~/.capture/notes.org"))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(add-hook 'org-mode-hook
  (lambda ()
    (local-set-key "\C-\M-j" 'org-insert-todo-heading)
    (local-set-key "\C-j" 'org-insert-heading)))

