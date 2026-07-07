
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
            (unless (or (string-match-p "\\`[ \t]*\\'" line) (string-match "https?://github\\.com/[^/]+/[^/]+/pull/[0-9]+" line))
              (throw 'done nil))
            (progn
              (push (cons (line-beginning-position)
                          (min (point-max) (1+ (line-end-position))))
                    line-bounds))
            (if (string-match "https?://github\\.com/[^/]+/[^/]+/pull/[0-9]+" line)
              (push (cons (match-string 0 line) line) urls)) ())
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

(defconst excluded-review-authors "\"gemini-code-assist\"")

(defun get-last-interesting-review-time (author review-authors-and-dates)
  (let* ((parsedJson (json-parse-string review-authors-and-dates))
         (relevant-reviews (seq-filter (lambda (review) (and (not (member (gethash "author" review) excluded-review-authors)) (not (and (equal author github-username) (equal (gethash "author" review) github-username))))) parsedJson))
        (last-relevant-review (car (last relevant-reviews)))
        (last-relevant-review-date (if last-relevant-review (gethash "date" last-relevant-review) "1970-00-00T00:00:01"))
         )
    (date-to-time last-relevant-review-date)))

(defconst jq-filter-last-review-or-commit-author (format "([[.reviews | .[] | { date: .submittedAt, login: .author.login }],[.commits | .[] | {date: .authoredDate, login: .authors | first | .login } ]] | add | [.[] |select(.login | IN(%s) | not)] | sort_by(.date) | last | .login)" excluded-review-authors))

(defun get-github-pr-state (url)
  "Fetch the title and state of the GitHub PR at URL using the `gh' CLI.
Returns an alist with keys `url', `title', and `state'."
  (unless (executable-find "gh")
    (user-error "The `gh' CLI is not installed or not on PATH"))
  (let* ((stats
          (split-string
           (shell-command-to-string
            (format "gh pr view %s --json title,state,author,reviews,commits -q '.title,.state,.author.login,%s,([.labels | select(.name == \"waiting-for-risk-review\")] | first)'"
                    (shell-quote-argument url)
                    jq-filter-last-review-or-commit-author
                    ))
           "\n"))
         (data stats)
         (title (nth 0 data))
         (state (nth 1 data))
         (author (nth 2 data))
         (last-relevant-person (nth 3 data))
         (waiting-for-risk-review-label (nth 4 data))
         )
    (unless data
      (user-error "Could not fetch PR state for %s" url))
    (list (cons 'url url)
          (cons 'title title)
          (cons 'state state)
          (cons 'author author)
          (cons 'last-relevant-person last-relevant-person)
          (cons 'waiting-for-risk-review-label (not (equal "" waiting-for-risk-review-label))))))

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



(defun notif (last-relevant-person waiting-for-risk-review-label state)
  (if (or waiting-for-risk-review-label
          (or (equal last-relevant-person github-username)
              (equal state "MERGED"))) "" "⚠️"))


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
       (format "%s %s %s  -  %s\n\n"
               (notif (alist-get 'last-relevant-person pr)
                      (alist-get 'waiting-for-risk-review-label pr)
                      (alist-get 'state pr))
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
