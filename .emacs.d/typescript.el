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
  (local-set-key (kbd "M-p") 'tide-references)
  (local-set-key (kbd "M-r") 'tide-rename-symbol)
  (local-set-key (kbd "M-f") 'tide-rename-file)
  (setq-default typescript-indent-level 2)
  (setq tide-server-max-response-length 102400000)
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  (setq auto-save-default nil)
  (setq create-lockfiles nil)
  ;; (load-file "~/.emacs.d/eslint-fix.el")
  ;; (add-hook 'after-save-hook 'eslint-fix nil t)
  )

(setq tide-node-executable "/home/haakon/.nvm/versions/node/v16.15.1/bin/node")

(require 'prettier)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'typescript-mode-hook 'prettier-mode)

;; (add-hook 'tsx-ts-mode-hook #'setup-tide-mode)
;; (add-hook 'tsx-ts-mode-hook 'prettier-mode)

(setq js-indent-level 2)
