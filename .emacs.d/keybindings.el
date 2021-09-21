

; Custom key bindings

(require 'bind-key)
(bind-keys* ("C-o" . backward-char)
	    ("M-o" . backward-word)
	    ("C-t" . previous-line)
	    ("M-t" .
		(lambda ()
		  (interactive)
		  (setq this-command 'previous-line)
		  (previous-line 10)))
	    ("C-n" . next-line)
	    ("M-n" . 
		(lambda ()
		  (interactive)
		  (setq this-command 'next-line)
		  (next-line 10)))
	    ("M-," . next-buffer)
	    ("M-'" . previous-buffer)
	    ("M-h" . backward-kill-word)
	    ("C-h" . delete-backward-char)
	    ("C-j" . forward-char)
	    ("M-j" . forward-word))


(global-set-key (kbd "C-q") (lookup-key global-map (kbd "C-x")))
