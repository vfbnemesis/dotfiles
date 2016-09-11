;;---org-mode config-----------------------------------------------------------

;; default directory
(setq org-directory "~/org")

;; скрыть все звездочик в заголовках кроме последней
(setq org-hide-leading-stars t)

;; effect of TAB in a code block is as in the language major mode buffer
(setq org-src-tab-acts-natively t)

;; to hide the *,=, or / markers
(setq org-hide-emphasis-markers t) 

;; Additional shortcuts for navigating through org-mode documents
;; (global-set-key (kbd "C-c <up>") 'outline-up-heading)
;; (global-set-key (kbd "C-c <left>") 'outline-previous-visible-heading)
;; (global-set-key (kbd "C-c <right>") 'outline-next-visible-heading)

;; Set up a keyboard shortcut to go to GTD and ORG file
;; (global-set-key (kbd "C-c w") 
;;                 (lambda () (interactive) (find-file "~/org/gtd/binp.org")))
;; (global-set-key (kbd "C-c p") 
;;                 (lambda () (interactive) (find-file "~/org/gtd/personal.org")))
;; (global-set-key (kbd "C-c e") 
;;                 (lambda () (interactive) (find-file "~/org/text/emacs/emacs.org")))
;; (global-set-key (kbd "C-c s") 
;;                 (lambda () (interactive) (find-file "~/.emacs.d/settings/settings.el")))

(setq org-todo-keywords
      '((sequence "TODO(t)" ;; задача/проект требует выполнения
		  "NEXT(n)" ;; следующее действие (можно брать и делать)
		  "IN-PROGRESS(p)" ;; проект в работе и требует активного внимания
		  "WAITING(w)" ;; проект в работе, в данный момент ждем
		  ;; завершения действия другим человеком
		  "|" "DONE(d)")
	
	(sequence "SOMETIMES(s)" ;; сделать может быть когда-нибудь 
		  "|" "CANCELLED(c)")
	
	(sequence "LEARN" "TRY" "|" "COMPLETE(x)"))) 

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
(setq org-log-done 'time)

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer 1)

(setq org-default-notes-file "~/org/gtd/refile.org")

;; C-c c is for capture
(define-key global-map (kbd "C-c c") 'org-capture)
;; force UTF-8
(setq org-export-coding-system 'utf-8)

(setq org-capture-templates
      '(;;other entries
	("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "**** %U %^{Title} %^g\n%?")
	;;other entries
	("t" "Todo task" entry (file "~/org/gtd/refile.org")
	 "* TODO %^{Task} %^g\nEntered on: %U\n%?")
	))



