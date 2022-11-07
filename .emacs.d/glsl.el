(load-file "~/.emacs.d/glsl-mode.el")

(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

(add-hook 'glsl-mode-hook (lambda ()
                            (setq auto-save-default nil)
                            (setq create-lockfiles nil)))
