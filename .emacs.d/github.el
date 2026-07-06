
(defun get-github-pr-urls ()
  "Collect GitHub PR URLs starting from the line at point, removing
the matched lines from the buffer.
Scans forward line by line, collecting GitHub pull request URLs.
Empty lines are skipped without stopping the scan and are left in
the buffer. Scanning stops at the first non-empty line that does not
contain a GitHub PR URL, which is also left in the buffer. Every
other line, i.e. one that contains a URL, is deleted from the buffer.
Returns a list of (URL . LINE) pairs, where LINE is the entire line
the URL was found on, in the order encountered."
  (save-excursion
    (beginning-of-line)
    (let (urls line-bounds)
      (catch 'done
        (while t
          (let ((line (buffer-substring-no-properties
                       (line-beginning-position) (line-end-position))))
            (if (string-match "https?://github\\.com/[^/]+/[^/]+/pull/[0-9]+" line)
                (progn
                  (push (cons (match-string 0 line) line) urls)
                  (push (cons (line-beginning-position)
                              (min (point-max) (1+ (line-end-position))))
                        line-bounds))
              (unless (string-match-p "\\`[ \t]*\\'" line)
                (throw 'done nil))))
          (if (eobp)
              (throw 'done nil)
            (forward-line 1))))
      ;; line-bounds is in reverse (bottom-to-top) order, so deleting in
      ;; this order keeps the not-yet-deleted positions valid.
      (dolist (bounds line-bounds)
        (delete-region (car bounds) (cdr bounds)))
      (nreverse urls))))

(defconst github-username "haakonflatval-cognite")
(defconst review-author-exclusion (format "\"%s\", \"gemini-code-assist\"" github-username))

(defconst excluded-review-authors '("gemini-code-assist"))

(defun get-last-interesting-review-time (author review-authors-and-dates)
  (let* ((parsedJson (json-parse-string review-authors-and-dates))
         (relevant-reviews (seq-filter (lambda (review) (and (not (member (gethash "author" review) excluded-review-authors)) (not (and (equal author github-username) (equal (gethash "author" review) github-username))))) parsedJson))
        (last-relevant-review (car (last relevant-reviews)))
        (last-relevant-review-date (if last-relevant-review (gethash "date" last-relevant-review) "1970-00-00T00:00:01"))
         )
    (date-to-time last-relevant-review-date)))


(defun get-github-pr-state (url)
  "Fetch the title and state of the GitHub PR at URL using the `gh' CLI.
Returns an alist with keys `url', `title', and `state'."
  (unless (executable-find "gh")
    (user-error "The `gh' CLI is not installed or not on PATH"))
  (let* ((stats
          (split-string
           (shell-command-to-string
            (format "gh pr view %s --json title,state,author,reviews,commits -q '.title,.state,.author.login,[.commits | last | .authoredDate][], [.reviews | .[] | { date: .submittedAt, author: .author.login }],[.labels | select(.name == \"waiting-for-risk-review\")]'"
                    (shell-quote-argument url)
                    ))
           "\n"))
         (data stats)
         (title (nth 0 data))
         (state (nth 1 data))
         (author (nth 2 data))
         (last-commit-time (nth 3 data))
         (review-authors-and-dates (nth 4 data))
         (waiting-for-risk-review-label (nth 5 data))
         )
    (unless data
      (user-error "Could not fetch PR state for %s" url))
    (list (cons 'url url)
          (cons 'title title)
          (cons 'state state)
          (cons 'author author)
          (cons 'last-commit-time (date-to-time last-commit-time))
          (cons 'last-relevant-review-time (get-last-interesting-review-time author review-authors-and-dates))
          (cons 'waiting-for-risk-review-label waiting-for-risk-review-label))))

(defun get-github-pr-states (urls)
  "Fetch title and state for each GitHub PR URL in URLS.
Calls the `gh' CLI once per URL via `get-github-pr-state'.
Returns a list of alists, one per URL and in the same order as URLS,
each with keys `url', `title', and `state'."
  (mapcar #'get-github-pr-state urls))


(defun state-icon (state)
  (cond
   ((equal state "OPEN") '🟢)
   ((equal state "MERGED") '🟣)
   ((equal state "CLOSED") '🔴)))



(defun notif (author last-commit-time last-review-time waiting-for-risk-review-label)
  (format "%s -- %s, %s %s" last-commit-time last-review-time author github-username)
  (if (or (and (time-less-p last-commit-time last-review-time)
               (and (equal author github-username)
                    (not waiting-for-risk-review-label)))
          (and (time-less-p last-review-time last-commit-time)
               (not (equal author github-username))))  "⚠️" ""))


(defun refresh-github-prs ()
  "Refresh the block of GitHub PR URLs starting at point.
Reads the GitHub PR URLs from the lines at point, removing those
lines from the buffer (see `get-github-pr-urls'), fetches the
current title and state of each PR (see `get-github-pr-states'), and
inserts one line per PR of the form \"<title>-<url>\" at point, with
open PRs sorted to the top."
  (interactive)
  (let* ((url-lines (get-github-pr-urls))
         (urls (mapcar #'car url-lines))
         (states (get-github-pr-states urls))
         (sorted (sort states
                       (lambda (a b)
                         (and (equal (alist-get 'state a) "OPEN")
                              (not (equal (alist-get 'state b) "OPEN")))))))
    (dolist (pr sorted)
      (insert
       (format "%s %s %s  -  %s\n"
               (notif (alist-get 'author pr)
                      (alist-get 'last-commit-time pr)
                      (alist-get 'last-relevant-review-time pr)
                      (alist-get 'waiting-for-risk-review-label pr))
               (state-icon (alist-get 'state pr))
               (alist-get 'title pr)
               (alist-get 'url pr))))))

;; Filtering: gh pr view https://github.com/cognitedata/reveal/pull/5704 --json labels -q "[.labels[]][] | select(.name == \"waiting-for-team\")"
;;  🟢 feat(fdx): fetch direct children assets for CDM assets hierarchy  -  https://github.com/cognitedata/fusion/pull/25495
;;  🟢 feat(fdx): fetch root assets for CDM assets hierarchy  -  https://github.com/cognitedata/fusion/pull/25484
;;  🟣 chore(infield): Add tests for use activity filter location options and make CDM copies  -  https://github.com/cognitedata/fusion/pull/25490


;; Not a URL-line!!

;; https://github.com/cognitedata/fusion/pull/25470

;; Array concatenation
;; gh pr view https://github.com/cognitedata/fusion/pull/25493 --json reviews,commits -q '[[.reviews | .[] | .author],[.commits | .[] | .authors | first | {login: .login}]] | add'
