
;; Custom C stuff

(add-hook 'c-mode-hook (lambda () ""
                         (setq c-basic-offset 2)
                         (set-indent-tabs-mode nil)))
