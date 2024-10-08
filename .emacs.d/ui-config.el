;; General (UI) config of emacs

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(set-face-attribute 'default (selected-frame) :height 130 :family "hack")

(setq-default completions-format 'vertical)

(custom-set-variables
  '(ansi-color-names-vector
   ["#242424" "#e5786d" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
  '(custom-enabled-themes '(wombat))
  '(inhibit-startup-screen t))

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Only available with experimental patch
(set-frame-parameter (selected-frame) 'alpha-background 80)

(add-hook 'after-make-frame-functions (lambda (frame)
                                        (set-frame-parameter frame 'alpha-background 80)
                                        (set-face-attribute 'default (selected-frame) :height 130 :family "hack")))
