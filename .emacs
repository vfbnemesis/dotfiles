(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(org-agenda-files
   (quote
    ("d:/users/bercut/Dropbox/Public/_notes/_org/TODO.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; package
(load "package")
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;;---оригинал https://gist.github.com/anonymous/2471669b376de09adc44-----------

;; Крестовина
;;

;; Вверх
(global-unset-key (kbd "M-i"))
(global-set-key (kbd "M-i") 'previous-line)

;; Вниз
(global-unset-key (kbd "M-k"))
(global-set-key (kbd "M-k") 'next-line)

;; Влево
(global-unset-key (kbd "M-j"))
(global-set-key (kbd "M-j") 'backward-char)

;; Вправо
(global-unset-key (kbd "M-l"))
(global-set-key (kbd "M-l") 'forward-char)

;; Page Up
(global-unset-key (kbd "M-I"))
(global-set-key (kbd "M-I") 'scroll-down-command)

;; Page Down
(global-unset-key (kbd "M-K"))
(global-set-key (kbd "M-K") 'scroll-up-command)

;; Forward word
(global-unset-key (kbd "M-o"))
(global-set-key (kbd "M-o") 'forward-word)

;; Backward word
(global-unset-key (kbd "M-u"))
(global-set-key (kbd "M-u") 'backward-word)

;; Beginnning of line
(global-unset-key (kbd "M-h"))
(global-set-key (kbd "M-h") 'move-end-of-line)

;; End of line
(global-unset-key (kbd "M-H"))
(global-set-key (kbd "M-H") 'move-beginning-of-line)

;; End of buffer
(global-unset-key (kbd "M-L"))
(global-set-key (kbd "M-L") 'end-of-buffer)

;; Beginning of buffer
(global-unset-key (kbd "M-J"))
(global-set-key (kbd "M-J") 'beginning-of-buffer)


;; Редактирование
;;

;; Delete
(global-unset-key (kbd "M-f"))
(global-set-key (kbd "M-f") 'delete-forward-char)

;; Backspace
(global-unset-key (kbd "M-d"))
(global-set-key (kbd "M-d") 'delete-backward-char)

;; Enter
(global-unset-key (kbd "M-n"))
(global-set-key (kbd "M-n") 'reindent-then-newline-and-indent)
(global-unset-key (kbd "M-m"))
(global-set-key (kbd "M-m") 'reindent-then-newline-and-indent)

;; Выделение
(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; Копирование
(global-unset-key (kbd "M-c"))
(global-set-key (kbd "M-c") 'kill-ring-save)

;; Вырезание
(global-unset-key (kbd "M-x"))
(global-set-key (kbd "M-x") 'kill-region)

;; Вставка
(global-unset-key (kbd "M-v"))
(global-set-key (kbd "M-v") 'yank)

;; Отмена
(global-unset-key (kbd "M-z"))
(global-set-key (kbd "M-z") 'undo)

;; Сохранение
(global-unset-key (kbd "M-s"))
(global-set-key (kbd "M-s") 'save-buffer)

;; Открытие
(global-unset-key (kbd "C-o"))
(global-set-key (kbd "C-o") 'find-file)

;;---оригинал https://gist.github.com/dbushenko/6045709------------------------

;;убираем меню и тулбар
;;(menu-bar-mode -1)
(tool-bar-mode -1)

;;отключаем различные варианты автосохранений
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

(add-to-list 'load-path "~/.emacs.d/plugins")

;; номера строк (слева)
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/linum%2B.el
(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)

;; помогает выбирать
;; built-in
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; buffer show файлы + scratch
;; built-in
(require 'bs)
(setq bs-configurations
'(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(global-set-key (kbd "<f2>") 'bs-show)

;; http://www.emacswiki.org/emacs/AutoComplete
;;(add-to-list 'load-path "~/.emacs.d/auto-complete")
;;(require 'auto-complete)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
;;(require 'auto-complete-config)
;;(ac-config-default)

;; браузер по файловой системе
;; http://www.emacswiki.org/emacs/SrSpeedbar
(require 'sr-speedbar)
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

(custom-set-variables
 '(speedbar-show-unknown-files t) ;; отображение всех файлов
)

;; http://www.emacswiki.org/emacs/Yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")

;;---org-mode config-----------------------------------------------------------

;;для выполнения питоновых команд из org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; подсветка языка в блоках begin_src/end_src как в режиме для работы с языком
(setq org-src-fontify-natively 't)

;;ВременнАя метка при закрытии задания
(setq org-log-done t)

;;---python-mode---------------------------------------------------------------

;;(setq python-shell-interpreter "C:/Python34/python.exe"
;;      python-shell-interpreter-args "-i")

;; ergo-emacs
;;(add-to-list 'load-path "~/.emacs.d/ergoemacs-mode")
;;(require 'ergoemacs-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;---verilog-mode------------------------------------------------

(custom-set-variables
 '(verilog-align-ifelse t)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-inst-param-value t)
 '(verilog-auto-inst-vector nil)
 '(verilog-auto-lineup (quote all))
 '(verilog-auto-newline nil)
 '(verilog-auto-save-policy nil)
 '(verilog-auto-template-warn-unused t)
 '(verilog-case-indent 2)
 '(verilog-cexp-indent 2)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-highlight-modules t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-module 2)
 '(verilog-tab-to-comment t))


;;---------------------------------------------------------------

;;(setq py-install-directory "~/.emacs.d/python-mode/")
;;(add-to-list 'load-path py-install-directory)
;;(require 'python-mode)

; use IPython
;;(setq-default py-shell-name "C:/Python34/Scripts/ipython.exe")
;;(setq-default py-which-bufname "IPython")

;;(require 'projectile)
;;(toggle-truncate-lines -1)
;;(projectile-mode)
