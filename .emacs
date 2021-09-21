
(package-initialize)

;; Call keybindings early so that we can use them even if the rest goes wrong
(load-file "~/.emacs.d/keybindings.el")

(load-file "~/.emacs.d/ui-config.el")
(load-file "~/.emacs.d/misc.el")

(load-file "~/.emacs.d/shader-modes.el")
(load-file "~/.emacs.d/cplusplus.el")
(load-file "~/.emacs.d/typescript.el")

;; Call again to re-override bindings from different modes
(load-file "~/.emacs.d/keybindings.el")
