;;---оригинал https://gist.github.com/dbushenko/6045709------------------------
;;---оригинал https://habrahabr.ru/post/248663/--------------------------------
;;---оригинал https://habrahabr.ru/post/39564/---------------------------------

(setq user-full-name   "vfbnemesis")
(setq user-mail-adress "vfbnemesis_mail")

;; Disable GUI components
;;убираем меню и тулбар и прокрутку
;;(menu-bar-mode -1)
(tool-bar-mode -1)
;;(scroll-bar-mode -1)
(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера

;; Inhibit startup/splash screen
;;(setq inhibit-splash-screen   t)
;; экран приветствия можно вызвать комбинацией C-h C-a
;;(setq ingibit-startup-message t)

;; включить выделение выражений между {},[],()
(show-paren-mode t)
;; выделить цветом выражения между {},[],()
(setq show-paren-style 'expression)

;; подсветка текущей строки
(global-hl-line-mode t)

;; Delete selection
(delete-selection-mode t)

;; отключаем различные варианты автосохранений
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

;; 24-часовой временной формат в mode-line
(setq display-time-24hr-format t)
;; показывать часы в mode-line
(display-time-mode             t) 

;; показать номер строки в mode-line
(line-number-mode t)
;; показать номер столбца в mode-line
(column-number-mode t) 

;; cua-mode
(cua-mode t)

;; перемещение между окнами
;;(windmove-default-keybindings)

;; сохранять сессию перед выходом
;;  desktop-save-mode t)

;; auto-fill-mode
;; 
(setq-default fill-column 80)

(defun auto-fill-mode-on()
  (interactive)
  (auto-fill-mode 1))

(defun comment-auto-fill-only-mode-on()
  (interactive)
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))

(global-set-key (kbd "C-c q") 'auto-fill-mode-on)

;; auto-fill mode for comment only
(add-hook 'emacs-lisp-mode-hook 'comment-auto-fill-only-mode-on)

;; auto-fill mode for text
(add-hook 'text-mode-hook 'auto-fill-mode-on)
(add-hook 'tex-mode-hook 'auto-fill-mode-on)
(add-hook 'latex-mode-hook 'auto-fill-mode-on)

;;manager-------------------------------------------------------------o

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;;---load plugins--------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.d/plugins")

;; номера строк (слева)
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/linum%2B.el
(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)


;; buffer show файлы + scratch
;; built-in
(require 'bs)
(setq bs-configurations
'(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(global-set-key (kbd "<f2>") 'bs-show)


;; recent files
;; build-in
(require 'recentf)
(setq recent-max-saved-items 200
      recent-max-menu-items 15)
(recentf-mode)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;---use-packages--------------------------------------------------------------

(use-package sr-speedbar
  ;; браузер по файловой системе
  :ensure t
  :config
  (progn
    (global-set-key (kbd "<f12>") 'sr-speedbar-toggle)
    (custom-set-variables
     '(speedbar-show-unknown-files t)) ;; отображение всех файлов
    (setq speedbar-use-images nil)
    ))


(use-package yasnippet
  :ensure t
  :config
  ;;(yas/load-directory "~/.emacs.d/yasnippet/snippets")
  (yas-global-mode 1))  


(use-package auto-complete
  :ensure t
  :config
  (progn
  ;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
    (ac-config-default)
    (global-auto-complete-mode t)
    ))


(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))


(use-package flx-ido
  ;; ido (built-in) помогает выбирать
  ;; flx-ido
  ;; помогает выбирать
  :ensure t
  :config
  (progn
    (ido-mode 1)
    (ido-everywhere 1)
    (flx-ido-mode 1)
    ;; disable ido faces to see flx highlights.
    (setq ido-enable-flex-matching t)
    ;; (setq ido-use-faces nil)
    ))


(use-package ido-vertical-mode
  :ensure t
  :config
  (progn
    (ido-vertical-mode 1)
    (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
    ))

(use-package smex
  :ensure t
  :config
  (progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    ;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
    ))
  
;;-----------------------------------------------------------------------------

;; markdown mode
;;(autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Markdown files" t)
;;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


