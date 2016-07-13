;;---org-mode config-----------------------------------------------------------

;;для выполнения питоновых команд из org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; подсветка языка в блоках begin_src/end_src как в режиме для работы с языком
(setq org-src-fontify-natively 't)

;;ВременнАя метка при закрытии задания
(setq org-log-done t)


