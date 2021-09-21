;; Misc setup


;; Disable backup files (with the reason that I save every other key stroke
(setq make-backup-files nil)

;; Use MELPA package repository
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://stable.melpa.org/packages/")
 t)


;; Kill scratch buffer
(kill-buffer "*scratch*")
