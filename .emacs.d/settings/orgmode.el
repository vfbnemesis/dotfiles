;;---org-mode config-----------------------------------------------------------

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-use-fast-todo-selection t)

(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-agenda-files (quote ("~/org/gtd"
                               "~/org/journal.org")))

;;для выполнения питоновых команд из org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; подсветка языка в блоках begin_src/end_src как в режиме для работы с языком
(setq org-src-fontify-natively 't)

;;ВременнАя метка при закрытии задания
(setq org-log-done t)

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer 1)

;; C-c c is for capture
(define-key global-map "\C-cc" 'org-capture)
;; force UTF-8
(setq org-export-coding-system 'utf-8)

(setq org-capture-templates
      '(;;other entries
	("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "**** %U %^{Title} %^g\n%?")
	;;other entries
	))



