
;; Custom delete forward- and backward-word
;; Main motivation is that these commands do not put the deleted text into the kill ring

(defun custom-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun custom-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (custom-delete-word (- arg)))



;; Toggle fullscreen

(defun hcon-toggle-fullscreen ()
  "Toggle fullscreen for a window on or off"
  (interactive)
  (if (get 'hcon-toggle-fullscreen 'state)
      (progn
        (jump-to-register 'c)
        (message "Restored saved window state")
        (put 'hcon-toggle-fullscreen 'state nil)
        )
    (progn
      (window-configuration-to-register 'c)
      (delete-other-windows)
      (message "Saved window state and enabled full screen")
      (put 'hcon-toggle-fullscreen 'state t)
      )))
