(show-paren-mode)
;(load-file "~/.emacs.d/python.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-message 1)
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates")
(setq auto-insert-query nil)
(eval-after-load 'autoinsert
  '(define-auto-insert "test_.*\.py"   "test.template.py")
)



(defun render-template ()
	     (when (and (stringp buffer-file-name)
			(string-match "test_.*\.py" buffer-file-name))
	       (auto-insert)
	       (let ((assignment-name (read-from-minibuffer "Assignment Name: "))
		     (test-doc-string (read-from-minibuffer "Class DocString: " ))
		     (requirement (read-from-minibuffer "Add a requrirement: "))
		     (requirement-list ())
		     (index 0)
		     (test-def-temp 
"    def test_func(self):
        '''
        %s
        '''
        pass
"))
		 (while (not (equal "" requirement))
		   (add-to-list 'requirement-list requirement)
		   (setq requirement (read-from-minibuffer (format "Add a requrirement %d: " index)))
		   (setq index (+ index 1)))
		 (replace-string "<* assignment *>" assignment-name)
		 (replace-string "<* DocString *>" test-doc-string)
		 (end-of-buffer)
		 (mapc (lambda (item) (insert (format test-def-temp item))) requirement-list)
		 )))
(add-hook 'find-file-hook 'render-template)


(define-skeleton score-comment
  "Inserts script score comment"
  "#############################################################" \n
  "#############################################################" \n
  "#************************************************************" \n
  "#** Score and comments" \n
  "#** Possible: " (skeleton-read "Points Possible: ") \n
  "#** Received: "  (skeleton-read "Points Received: ") \n
  ("Comment: " "#** " str \n)
  "#************************************************************" \n
  "#############################################################" \n)

(global-set-key "\C-cc" 'score-comment)

(define-skeleton tex-list
  "Inserts list environment"
  -1 "\\begin{" (setq v1 (skeleton-read "List type: ")) "}" \n
  -1 ("Item: " " \\item " str \n )
  -1 "\\end{" v1 "}" \n
)

(global-set-key "\C-cl" 'tex-list)


(defun make-region-latex-list (list-type)
  "does something"
 (interactive "MList Type: ")
 (setq lines (split-string (buffer-substring-no-properties (mark) (point))))
 (delete-region (mark) (point))
 (insert (format "\\begin{%s}\n" list-type))
  (dolist (elt lines)
			   (insert (concat (concat "\\item " elt) "\n" )))
 (insert (format "\\end{%s}\n" list-type))
)

(global-set-key [f5] 'make-region-latex-list)

(defun make-region-latex-link (url)
  "makes an href"
  (interactive "MURL: ")
  (setq text  (buffer-substring-no-properties (mark) (point)))
  (delete-region (mark) (point))
  (insert (format "\\href{%s}{%s}" url text)))

(global-set-key [f6] 'make-region-latex-link)


(defun make-region-latex-minor-heading ()
  ""
  (interactive)
  (setq text  (buffer-substring-no-properties (mark) (point)))
  (delete-region (mark) (point))
  (insert (format "\\minor{%s}" text)))
  
(global-set-key [f7] 'make-region-latex-minor-heading)

(defun make-latex-topmatter ()
  ""
  (interactive)
  (setq lines (split-string (buffer-substring-no-properties (mark) (point)) "\n"))
  (delete-region (mark) (point))
  (setq subsection (concat (concat "\\subsubsection{" (nth 0 lines)) "}"))
  (setq indicator (concat "\\" (concat (replace-regexp-in-string "Indicator: "  "indicator{" (nth 1 lines)) "}")))
  (setq prompt (concat "\\" (concat (replace-regexp-in-string "Prompt: "  "prompt{" (nth 2 lines)) "}")))
  (insert (format "%s\n\n%s\n\n%s\n\n\\begin{findings}\n\\end{findings}" subsection indicator prompt )))
  
(global-set-key [f8] 'make-latex-topmatter)




;;Encouraging responsibility and discipline in learning behavior of students at wat ku sao school
