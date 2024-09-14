
;; Custom C stuff

(setq c-basic-offset 4)
(add-hook 'c-mode-hook (lambda () ""
                         (setq c-basic-offset 2)
                         (set-indent-tabs-mode nil)))
