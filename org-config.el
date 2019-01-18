(add-to-list 'org-latex-classes
             '("classyreport" "\\documentclass{classyreport}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-subtitle-separate t
      org-latex-subtitle-format "\\subtitle{%s}")

(setq org-confirm-babel-evaluate (lambda (l b) nil))
(setq org-latex-listings 'minted
      org-latex-custom-lang-environments '()
      org-latex-minted-options '(("frame" "leftline")
                                 ("fontsize" "\\scriptsize")
                                 ("linenos" ""))
      org-latex-to-pdf-process '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                 "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                 "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-latex-text-markup-alist '((bold . "\\textbf{%s}")
                                    (code . protectedcode)
                                    (italic . "\\emph{%s}")
                                    (strike-through . "\\sout{%s}")
                                    (underline . "\\uline{%s}")
                                    (verbatim . protectedtexttt)))

(defun org-latex--text-markup (text markup info)
  "Format TEXT depending on MARKUP text markup.
  INFO is a plist used as a communication channel.  See
  `org-latex-text-markup-alist' for details."
  (let ((fmt (cdr (assq markup (plist-get info :latex-text-markup-alist)))))
    (cl-case fmt
      ;; No format string: Return raw text.
      ((nil) text)
      ;; Handle the `verb' special case: Find an appropriate separator
      ;; and use "\\verb" command.
      (verb
       (let ((separator (org-latex--find-verb-separator text)))
         (concat "\\verb"
                 separator
                 (replace-regexp-in-string "\n" " " text)
                 separator)))
      ;; Handle the `protectedtexttt' special case: Protect some
      ;; special chars and use "\texttt{%s}" format string.
      (protectedtexttt
       (format "\\texttt{%s}"
               (replace-regexp-in-string
                "--\\|[\\{}$%&_#~^]"
                (lambda (m)
                  (cond ((equal m "--") "-{}-")
                        ((equal m "\\") "\\textbackslash{}")
                        ((equal m "~") "\\textasciitilde{}")
                        ((equal m "^") "\\textasciicircum{}")
                        (t (org-latex--protect-text m))))
                text nil t)))
      (protectedcode
       (format "\\code{%s}"
               (replace-regexp-in-string
                "--\\|[\\{}$%&_#~^]"
                (lambda (m)
                  (cond ((equal m "--") "-{}-")
                        ((equal m "\\") "\\textbackslash{}")
                        ((equal m "~") "\\textasciitilde{}")
                        ((equal m "^") "\\textasciicircum{}")
                        (t (org-latex--protect-text m))))
                text nil t)))
      ;; Else use format string.
      (t (format fmt text)))))

(defun org-latex-horizontal-rule (horizontal-rule _contents info)
  "Transcode an HORIZONTAL-RULE object from Org to LaTeX.
  CONTENTS is nil.  INFO is a plist holding contextual information."
  (let ((attr (org-export-read-attribute :attr_latex horizontal-rule))
        (prev (org-export-get-previous-element horizontal-rule info)))
    (concat
     ;; Make sure the rule doesn't start at the end of the current
     ;; line by separating it with a blank line from previous element.
     (when (and prev
                (let ((prev-blank (org-element-property :post-blank prev)))
                  (or (not prev-blank) (zerop prev-blank))))
       "\n")
     ;; NOTE not authorising rules inside labels (whereas org seems to accept it)
     ;; 3 stars in a row asterism
     "\\asterism")))

(setf org-latex-custom-lang-environments nil)
(defun org-latex-add-custom-lang-environment (name env)
  (setf org-latex-custom-lang-environments
        (cons (list name env)
              org-latex-custom-lang-environments)))
(let ((default-minted '(text html shell ocaml javascript)))
  (dolist (name default-minted)
    (org-latex-add-custom-lang-environment name
                                           (concat (symbol-name name)
                                                   "code"))))
