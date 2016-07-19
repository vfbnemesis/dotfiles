;;---оригинал https://gist.github.com/dbushenko/6045709------------------------

;;убираем меню и тулбар и прокрутку
;;(menu-bar-mode -1)
(tool-bar-mode -1)
;;(scroll-bar-mode -1)

;;отключаем различные варианты автосохранений
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

;; package manager
(load "package")
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

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

;;-----------------------------------------------------------------------------

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; cua-mode
(cua-mode t)


