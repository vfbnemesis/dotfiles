;;---org-mode config-----------------------------------------------------------
(use-package org
  :bind (:map my-mode-map
              ("C-c a" . org-agenda)
              ("C-c c" . org-capture)
              ("C-c t" . hydra-org-clock/body))
  :config
  (setq org-export-coding-system 'utf-8 ; force UTF-8
        org-directory "~/org" ; default directory
        org-hide-leading-stars t ; скрыть все звездочик в заголовках кроме последней
        org-src-tab-acts-natively t ; effect of TAB in a code block is as in the language major mode buffer
        org-hide-emphasis-markers t ; to hide the *,=, or / markers
        org-use-fast-todo-selection t
        org-src-fontify-natively 't ; подсветка языка в блоках begin_src/end_src
        org-log-done 'time ; ВременнАя метка при закрытии задания
        org-log-into-drawer "LOGBOOK"
        org-clock-into-drawer 1
        org-default-notes-file "~/org/gtd/refile.org"
        )
  (setq org-agenda-files (quote ("~/org/gtd/binp.org"
                                 "~/org/gtd/personal.org")))

  ;;для выполнения питоновых команд из org-mode
  (org-babel-do-load-languages 'org-babel-load-languages
                               '((python . t))
                               )

  (setq org-todo-keywords
        '((sequence "TODO(t)" ;; задача/проект требует выполнения
                    "NEXT(n)" ;; следующее действие (можно брать и делать)
                    "IN-PROGRESS(p)" ;; проект в работе и требует активного внимания
                    "WAITING(w)" ;; проект в работе, в данный момент ждем
                    ;; завершения действия другим человеком
                    "|" "DONE(d)")

          (sequence "SOMETIMES(s)" ;; сделать может быть когда-нибудь
                    "|" "CANCELLED(c)")

          (sequence "LEARN" "TRY" "|" "COMPLETE(x)")
          ))

  (setq org-todo-keyword-faces
        (quote (
                ("TODO"
                 :background "red"
                 :foreground "black"
                 :weight bold
                 :box (:line-width 2 :style released-button))

                ("NEXT"
                 :background "IndianRed1"
                 :foreground "black"
                 :weight bold
                 :box (:line-width 2 :style released-button))

                ("IN-PROGRESS"
                 :background "orange"
                 :foreground "black"
                 :weight bold
                 :box (:line-width 2 :style released-button))

                ("WAITING"
                 :background "yellow"
                 :foreground "black"
                 :weight bold
                 :box (:line-width 2 :style released-button))

                ("DONE"
                 :background "forest green"
                 :foreground "black"
                 :weight bold
                 :box (:line-width 2 :style released-button))
                )))

  (set-face-attribute 'org-priority nil
                      :inherit font-lock-keyword-face
                      :inverse-video t
                      :box '(:line-width 2 :color "grey75" :style released-button))

  (setq org-capture-templates
        '(;; journal entries
          ("j" "Journal" entry (file+datetree "~/org/journal.org")
           "**** %U %^{Title} %^g\n%?")
          ;; task entries
          ("t" "Todo task" entry (file "~/org/gtd/refile.org")
           "* TODO %^{Task} %^g\nEntered on: %U\n%?")
          ;; link entries
          ("l" "Link" entry (file+headline "~/org/text/bookmarks.org" "Inbox")
           "* [[%^{Link}][%^{description}]] %^g\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?")
          ))

  (defhydra hydra-org-clock (:color blue :hint nil)
    "
^Clock:^ ^In/out^     ^Edit^   ^Summary^    | ^Timers:^ ^Run^           ^Insert
-^-^-----^-^----------^-^------^-^----------|--^-^------^-^-------------^------
(_?_)    _i_n         _e_dit   _g_oto entry | (_z_)     _r_elative      ti_m_e
^ ^      _c_ontinue   _q_uit   _d_isplay    |  ^ ^      cou_n_tdown     i_t_em
^ ^      _o_ut        ^ ^      _r_eport     |  ^ ^      _p_ause toggle
^ ^      ^ ^          ^ ^      ^ ^          |  ^ ^      _s_top
"
   ("i" org-clock-in)
   ("c" org-clock-in-last)
   ("o" org-clock-out)

   ("e" org-clock-modify-effort-estimate)
   ("q" org-clock-cancel)

   ("g" org-clock-goto)
   ("d" org-clock-display)
   ("r" org-clock-report)
   ("?" (org-info "Clocking commands"))

  ("r" org-timer-start)
  ("n" org-timer-set-timer)
  ("p" org-timer-pause-or-continue)
  ("s" org-timer-stop)

  ("m" org-timer)
  ("t" org-timer-item)
  ("z" (org-info "Timers")))
  )
