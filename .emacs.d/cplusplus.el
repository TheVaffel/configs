
;; Custom C++ stuff

(require 'lsp)

(setq lsp-clients-clangd-args '("-background-index"))

(add-hook 'c++-mode-hook (lambda () ""
                           (lsp)
                           (with-eval-after-load 'lsp-mode
                             (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))
                           (setq c-default-style "linux"
                                 c-basic-offset 4)))
