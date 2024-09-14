
(load-file "~/.emacs.d/misc.el")

;; Call keybindings early so that we can use them even if the rest goes wrong
(load-file "~/.emacs.d/keybindings.el")

(load-file "~/.emacs.d/ui-config.el")

(load-file "~/.emacs.d/shader-modes.el")
(load-file "~/.emacs.d/c.el")
;; (load-file "~/.emacs.d/cplusplus.el")
;; (load-file "~/.emacs.d/typescript.el")
;; (load-file "~/.emacs.d/csharp.el")
(load-file "~/.emacs.d/environment.el")
(load-file "~/.emacs.d/glsl.el")
(load-file "~/.emacs.d/wgsl-mode.el")
(load-file "~/.emacs.d/term.el")
(load-file "~/.emacs.d/org.el")
(load-file "~/.emacs.d/rust.el")
(load-file "~/.emacs.d/haskell.el")
(load-file "~/.emacs.d/lsp-setup.el")
;; (load-file "~/.emacs.d/mail.el")
;; (load-file "~/.emacs.d/purescript.el")

;; Call again to re-override bindings from different modes
(load-file "~/.emacs.d/keybindings.el")
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
   '(flycheck compat multi-term yaml-mode purescript-mode citeproc-org magit-libgit rainbow-delimiters helm-ag fzf mood-line tide gnu-elpa-keyring-update meson-mode haskell-emacs wc-mode arduino-mode pinentry mu4e-views offlineimap))
 '(send-mail-function 'mailclient-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
