(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$" "" (shell-command-to-string
					  "$SHELL --login -c 'echo $PATH'"
						    ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(defun set-environment-variables (&rest names)
  (interactive)
  (let (set-env-with-name)
    (mapc (lambda
            (name)
            "Set environment variable with this name"
            (let ((command-name (concat "bash --login -c 'echo $" name "'")))
              (let ((env-content (replace-regexp-in-string
			          "[ \t\n]*$" "" (shell-command-to-string
                                                  command-name))))
                (print env-content)
                (setenv name env-content))
              ))
          names)))

(set-exec-path-from-shell-PATH)

(set-environment-variables "LD_LIBRARY_PATH" "SSH_AUTH_SOCK" "GIT_EDITOR" "RUSTUP_HOME" "CARGO_HOME" "ARCH" "VULKAN_SDK" "VK_ADD_LAYER_PATH")
