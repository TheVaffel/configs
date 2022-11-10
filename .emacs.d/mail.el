
(require 'auth-source)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp-mail.outlook.com"
      smtpmai-smtp-server          "smtp-mail.outlook.com"
      smtpmail-local-domain "hotmail.com"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587)

;;; Replies

(setq message-citation-line-function 'message-insert-formatted-citation-line)
(setq message-citation-line-format "On %a, %b %d %Y, %f wrote:\n")


(require 'mu4e)
(setq
 mu4e-sent-folder   "/Sent"
 mu4e-refile-folder "/Archive")

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 120)

;; Rely on remote server to store sent messages
(setq mu4e-sent-messages-behavior 'delete)

(setq user-mail-address "hkon20@hotmail.com")
(setq user-full-name "Håkon Flatval")

(set-language-environment "UTF-8")
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

(defun decode-utf8 ()
    "Opens a new buffer with the current buffer content decoded as UTF-8"
  (set 'bname (generate-new-buffer-name "decutf"))
  (generate-new-buffer bname)
  (set 'tempcont (buffer-string))
  (switch-to-buffer bname)
  (insert tempcont)
  (mark-whole-buffer)
  (decode-coding-region (region-beginning) (region-end) 'utf-8))

(setq mu4e-compose-dont-reply-to-self t)

(setq mu4e-confirm-quit nil)
