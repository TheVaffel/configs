(add-hook 'rust-mode-hook
           (lambda ()
             (lsp-deferred)
             (bind-keys*
              ("M-." . lsp-find-definition)
              ("M-p" . lsp-find-references)
              )
            ))
(setq rust-format-on-save t)
;; (use-package rustic
;;  :ensure
;;  :bind (:map rustic-mode-map
;;              ("M-." . lsp-find-definition)
;;              ("M-p" . lsp-find-references))
;;  :config
;;  (rustic-flycheck-setup)
;;  (rustic-com
;;  (setq rustic-format-on-save t))
