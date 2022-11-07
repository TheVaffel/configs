(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)
  (bind-keys* ("M-p" . tide-references))
  (bind-keys* ("M-r" . tide-rename-symbol))
  (bind-keys* ("M-f" . tide-rename-file))
  (setq-default typescript-indent-level 2)
  (setq tide-server-max-response-length 102400000)
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  (setq auto-save-default nil)
  (setq create-lockfiles nil)
  ;; (load-file "~/.emacs.d/eslint-fix.el")
  ;; (add-hook 'after-save-hook 'eslint-fix nil t)
  )

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq js-indent-level 2)
