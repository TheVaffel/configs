;; Misc setup

;; NB: This should not depend on any non-builtin packages

;; Disable backup files (with the reason that I save every other key stroke)
(setq make-backup-files nil)

;; Disable tabs
(setq-default indent-tabs-mode nil)

;; Use MELPA package repository
(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://stable.melpa.org/packages/")
 t)


;; Kill scratch buffer
(kill-buffer "*scratch*")

;; Prevent automatic splitting of windows
(setq split-height-threshold nil
      split-width-threshold nil)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode t)
