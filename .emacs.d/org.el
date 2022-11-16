
(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "BACKLOG(b!)" "TODO(t!)" "IN PROGRESS(p!)" "IN REVIEW(r!)" "|" "DONE(d)" "IRRELEVANT(i)")))

(setq org-jira-jira-status-to-org-keyword-alist
       '(
         ("Backlog" . "BACKLOG")
         ("Selected for Development" . "TODO")
         ("In progress" . "IN PROGRESS")
         ("Code review" . "IN REVIEW")
         ("Done" . "DONE")
         ("Won't do" . "IRRELEVANT"))
       )

(setq org-jira-done-states
      '("Done", "Won't do"))


(setq org-log-into-drawer "LOGBOOK")
(setq org-startup-truncated nil)

(setq jiralib-url "https://cognitedata.atlassian.net")

(setq org-agenda-files '("~/Documents/reveal/TODO.org"))

(defun insert-heading-with-timestamp ()
  (interactive)
  (org-insert-heading-after-current)
  (org-todo)
  (end-of-line))


;; Function for sorting top-level entries in a TODO tree
(defun sort-entries-according-to-creation-date ()
  (interactive)
  (org-sort-entries nil ?T))


(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "M-RET") 'insert-heading-with-timestamp)))
