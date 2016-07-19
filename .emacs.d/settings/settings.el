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

;; use-package
(add-to-list 'load-path "~/.emacs.d/plugins/use-package")
(require 'use-package)

;;---load plugins--------------------------------------------------------------

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

;; браузер по файловой системе
;; http://www.emacswiki.org/emacs/SrSpeedbar
(require 'sr-speedbar)
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

(custom-set-variables
 '(speedbar-show-unknown-files t) ;; отображение всех файлов
)

(use-package yasnippet
  :ensure t
  :config
  ;;(yas/load-directory "~/.emacs.d/yasnippet/snippets")
  (yas-global-mode 1))  


(use-package auto-complete
  :ensure t
  :config
  ;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
  (ac-config-default))


  
;; cua-mode
(cua-mode t)

;;-----------------------------------------------------------------------------

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


