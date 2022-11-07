

;; Toggle term line mode


(defun toggle-term-line-mode ()
  "Toggle term line mode on or off"
  (interactive)
  (if (get 'custom-toggle-line-mode 'state)
      (progn
        (term-char-mode)
        (message "Toggled line mode off")
        (put 'custom-toggle-line-mode 'state nil)
        )
    (progn
      (term-line-mode)
      (message "Toggled line mode on")
      (put 'custom-toggle-line-mode 'state t)
      )))


(add-hook 'term-mode-hook
          (lambda ()
            (defun expose-global-binding-in-term (binding)
              (define-key term-raw-map binding
                          (lookup-key (current-global-map) binding)))

            (defun expose-local-binding-in-term (binding)
              (define-key term-raw-map binding
                          (lookup-key (current-local-map) binding)))

            (expose-global-binding-in-term (kbd "C-q"))
            (expose-global-binding-in-term (kbd "M-x"))
            (expose-global-binding-in-term (kbd "M-1"))

            (expose-global-binding-in-term (kbd "C-n"))
            (expose-global-binding-in-term (kbd "C-t"))

            (define-key term-raw-map (kbd "C-c") 'term-interrupt-subjob)

            (local-set-key (kbd "C-,") 'toggle-term-line-mode)
            (local-set-key (kbd "M-.") 'multi-term-prev)
            (local-set-key (kbd "M-p") 'multi-term-next)

            (expose-local-binding-in-term (kbd "C-,"))
            (expose-local-binding-in-term (kbd "M-."))
            (expose-local-binding-in-term (kbd "M-p"))
            ))
