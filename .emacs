(package-initialize)

(require 'use-package)
(require 'quelpa-use-package)

(load-file "~/.emacs.d/welcome.el")
(load-file "~/.emacs.d/misc.el")

;; Call keybindings early so that we can use them even if the rest goes wrong
(load-file "~/.emacs.d/keybindings.el")

(load-file "~/.emacs.d/ui-config.el")

(load-file "~/.emacs.d/shader-modes.el")
(load-file "~/.emacs.d/c.el")
(load-file "~/.emacs.d/cplusplus.el")
(load-file "~/.emacs.d/typescript.el")
(load-file "~/.emacs.d/csharp.el")
(load-file "~/.emacs.d/glsl.el")
(load-file "~/.emacs.d/wgsl-mode.el")
(load-file "~/.emacs.d/term.el")
(load-file "~/.emacs.d/lsp-setup.el")
(load-file "~/.emacs.d/environment.el")
(load-file "~/.emacs.d/git.el")
;; (load-file "~/.emacs.d/copilot.el")
;; (load-file "~/.emacs.d/mail.el")
(load-file "~/.emacs.d/org.el")
(load-file "~/.emacs.d/purescript.el")

;; (load-file "~/.emacs.d/extern/isearch+.el")
;; (load-file "~/.emacs.d/extern/isearch-prop.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wombat))
 '(dap-netcore-download-url
   "https://github.com/Samsung/netcoredbg/releases/download/1.2.0-825/netcoredbg-linux-amd64_fixed.tar.gz")
 '(inhibit-startup-screen t)
 '(org-agenda-files nil)
 '(package-selected-packages
   '(zones transient-cycles gh tide quelpa-use-package multi-term citeproc-org magit-libgit rainbow-delimiters helm-ag gnu-elpa-keyring-update meson-mode haskell-emacs wc-mode pinentry mu4e-views offlineimap))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Call again to re-override bindings from different modes
(load-file "~/.emacs.d/keybindings.el")
