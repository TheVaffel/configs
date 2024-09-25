
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook (lambda ()
                             "Custom lsp bindings"
                             (bind-keys*
                              ("M-." . lsp-find-definition)
                              ("M-p" . lsp-find-references)
                              )
                             (setq c-basic-offset 4))))
