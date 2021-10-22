
(require 'csharp-mode)

(defun custom-csharp-mode-hook ()
  (electric-pair-local-mode 1)

  ;; DAP stuff
  (require 'dap-netcore)
  (dap-auto-configure-mode 1)
  )

(add-hook 'csharp-mode-hook 'custom-csharp-mode-hook)
