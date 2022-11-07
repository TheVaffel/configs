

;; Toggle term line mode


(defun toggle-term-line-mode ()
  "Toggle term line mode on or off"
  (interactive)
  (if (get 'custom-toggle-line-mode 'state)
      (progn
        (term-line-mode)
        (message "Toggled line mode off")
        (put 'custom-toggle-line-mode 'state nil)
        )
    (progn
      (term-char-mode)
      (message "Toggled line mode on")
      (put 'custom-toggle-line-mode 'state t)
      )))


(add-hook 'term-mode-hook
          (lambda ()
            (defun expose-global-binding-in-term (binding)
              (define-key term-raw-map binding
                          (lookup-key (current-global-map) binding)))

            (expose-global-binding-in-term (kbd "C-q"))
            (expose-global-binding-in-term (kbd "M-x"))
            (expose-global-binding-in-term (kbd "M-1"))

            (define-key term-raw-map (kbd "C-n") 'scroll-down)
            (define-key term-raw-map (kbd "C-t") 'scroll-up)

            (expose-global-binding-in-term (kbd "C-n"))
            (expose-global-binding-in-term (kbd "C-t"))

            (define-key term-raw-map (kbd "C-c") 'term-interrupt-subjob)

            (define-key term-raw-map (kbd "M-.") 'multi-term-prev)
            (define-key term-raw-map (kbd "M-p") 'multi-term-next)
            ))
