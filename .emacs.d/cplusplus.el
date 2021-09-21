

;; Custom C++ stuff

(require 'lsp)
(add-hook 'c++-mode-hook 'lsp)


(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

(setq c-default-style "linux"
      c-basic-offset 4)
