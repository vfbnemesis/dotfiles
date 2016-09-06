;; --- оригинал https://gist.github.com/dbushenko/6045709 ---------------------
;; --- оригинал https://habrahabr.ru/post/248663/ -----------------------------
;; --- оригинал https://habrahabr.ru/post/39564/ ------------------------------

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

;; Do NOT show average system load time
(setq display-time-default-load-average nil)

;; cua-mode
(cua-mode t)

;; перемещение между окнами
;;(windmove-default-keybindings)

;; сохранять сессию перед выходом
;;  desktop-save-mode t)

;; --- Mode line configuration ------------------------------------------------
(line-number-mode t) ; показать номер строки в mode-line
(column-number-mode t) ; показать номер столбца в mode-line
(setq display-time-24hr-format t) ; 24-часовой временной формат в mode-line
(display-time-mode t) ; показывать часы в mode-line

;; --- auto-fill-mode ---------------------------------------------------------
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

;; --- calendar mode localization ---------------------------------------------
(setq calendar-week-start-day 1
      calendar-day-name-array ["Вс" "Пн" "Вт" "Ср" "Чт" "Пт" "Сб"]
      calendar-month-name-array ["Январь" "Февраль" "Март" "Апрель"
				 "Май" "Июнь" "Июль" "Август"
				 "Сентябрь" "Октябрь" "Ноябрь" "Декабрь"])

;; --- move lines -------------------------------------------------------------

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

;; (global-set-key (kbd "M-<up>") 'move-line-up)
;; (global-set-key (kbd "M-<down>") 'move-line-down)

;; --- Cycling of Color Themes ------------------------------------------------

(setq my-color-themes (list 'deeper-blue
			    'wheatgrass))
 
(defun my-theme-set-default () ; Set the first row
      (interactive)
      (setq theme-current my-color-themes)
      (load-theme (car theme-current)))
 
(defun my-describe-theme () ; Show the current theme
  (interactive)
  (message "%s" (car theme-current)))

; Set the next theme (fixed by Chris Webber - thanks)
(defun my-theme-cycle ()
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (load-theme (car theme-current))
  (message "%S" (car theme-current)))

(setq theme-current my-color-themes)
(my-theme-set-default)

(global-set-key [f7] 'my-theme-cycle)

;; --- hide/show C block ------------------------------------------------------

;; (add-hook 'c-mode-common-hook
;;   (lambda()
;;     (local-set-key (kbd "C-c <right>") 'hs-show-block)
;;     (local-set-key (kbd "C-c <left>")  'hs-hide-block)
;;     (local-set-key (kbd "C-c <up>")    'hs-hide-all)
;;     (local-set-key (kbd "C-c <down>")  'hs-show-all)
;;     (hs-minor-mode t)))

;; --- KEYBINDINGS ------------------------------------------------------------
;; оригинал https://gist.github.com/anonymous/2471669b376de09adc44
;; http://ergoemacs.org/emacs/emacs_kill-ring.html

(global-unset-key (kbd "M-j"))
(global-unset-key (kbd "M-l"))
(global-unset-key (kbd "M-i"))
(global-unset-key (kbd "M-k"))

(global-unset-key (kbd "M-u"))
(global-unset-key (kbd "M-o"))

(global-unset-key (kbd "M-H"))
(global-unset-key (kbd "M-h"))

(global-unset-key (kbd "M-I"))
(global-unset-key (kbd "M-K"))

(global-unset-key (kbd "M-J"))
(global-unset-key (kbd "M-L"))

(global-unset-key (kbd "M-f"))
(global-unset-key (kbd "M-d"))

(global-unset-key (kbd "M-e"))
(global-unset-key (kbd "M-r"))

(global-unset-key (kbd "M-n"))
(global-unset-key (kbd "M-m"))

(global-unset-key (kbd "M-s"))
(global-unset-key (kbd "C-o"))


;; Крестовина
(global-set-key (kbd "M-j") 'backward-char) ; Влево
(global-set-key (kbd "M-l") 'forward-char) ; Вправо
(global-set-key (kbd "M-i") 'previous-line) ; Вверх
(global-set-key (kbd "M-k") 'next-line) ; Вниз

;; Move by word
(global-set-key (kbd "M-u") 'backward-word)
(global-set-key (kbd "M-o") 'forward-word)

;; Move by paragraph
(global-set-key (kbd "M-U") 'backward-paragraph)
(global-set-key (kbd "M-O") 'forward-paragraph)

;; Move to beginning/ending of line
(global-set-key (kbd "M-H") 'move-beginning-of-line)
(global-set-key (kbd "M-h") 'move-end-of-line)

;; Move by screen (page up/down)
(global-set-key (kbd "M-I") 'scroll-down-command)
(global-set-key (kbd "M-K") 'scroll-up-command)

;; Move to beginning/ending of file
(global-set-key (kbd "M-J") 'beginning-of-buffer)
(global-set-key (kbd "M-L") 'end-of-buffer)


;; Редактирование
;;

;; Delete previous/next char.
(global-set-key (kbd "M-f") 'delete-forward-char)
(global-set-key (kbd "M-d") 'delete-backward-char)

;; Delete previous/next word.
(global-set-key (kbd "M-e") 'backward-kill-word)
(global-set-key (kbd "M-r") 'kill-word)

;; Delete (whole) line
(global-set-key (kbd "C-S-k") 'kill-whole-line)

;; Enter
(global-set-key (kbd "M-n") 'reindent-then-newline-and-indent)
(global-set-key (kbd "M-m") 'reindent-then-newline-and-indent)

(global-set-key (kbd "M-s") 'save-buffer) ; Сохранение
(global-set-key (kbd "C-o") 'find-file) ; Открытие

;; define key sequence
;;

(global-set-key (kbd "<f6>") 'visual-line-mode)
(global-set-key (kbd "<f8>") 'whitespace-mode)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; --- package manager --------------------------------------------------------

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

;; --- load plugins -----------------------------------------------------------

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

;; --- use-packages -----------------------------------------------------------
;; :init - execute code before a package is loaded
;; :config - execute code after a package is loaded
;; :defer - (отложенная загрузка)
;; :ensure - causes the package(s) to be installed automatically
;; if not already present on your system

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


(use-package ido
  ;; ido (built-in) помогает выбирать
  ;; помогает выбирать
  :defer t
  :init
  (progn
    (setq ido-enable-flex-matching  t) ; enable fuzzy search
    (setq ido-everywhere            t)
    (setq ido-create-new-buffer 'always) ; create a new buffer if no buffer matches substring
    (setq org-completion-use-ido t) ; use ido with org-mode
    
    ;; customize the order in which files are sorted when Ido displays them in
    ;; the minibuffer. There are certain file extensions I use more than others,
    ;; so I tell Ido to emphasize those
    (setq ido-file-extensions-order '(".sv" ".v" ".svh" ".tv" ".m" ".c" ".cpp" ".el"))

    (setq ido-use-filename-at-point 'guess) ; find file at point using ido

    ;; look into other directories if the entered filename doesn't exist
    ;; in current directory ido-auto-merge-work-directories-length -1
    ;; do NOT look into other directories if the entered filename doesn't
    ;; exist in current directory
    (setq ido-auto-merge-work-directories-length 0))
  :config
  (progn
    (ido-mode 1)

    (use-package flx-ido
      ;; flx-ido for better flex matching between words
      :ensure t
      :config
      (progn
	;; disable ido faces to see flx highlights.
	;; (setq ido-use-faces nil)
	(flx-ido-mode 1)
	))

    (use-package ido-vertical-mode
      ;; flx-ido looks better with ido-vertical-mode
      :ensure t
      :config
      (progn
	(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)	
	(ido-vertical-mode 1)
	))
    
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


(use-package verilog-mode
  :config
  (progn
    (setq verilog-align-ifelse t)
    (setq verilog-auto-delete-trailing-whitespace t)
    (setq verilog-auto-inst-param-value t)
    (setq verilog-auto-inst-vector nil)
    (setq verilog-auto-lineup (quote all))
    (setq verilog-auto-newline nil)
    (setq verilog-auto-save-policy nil)
    (setq verilog-auto-template-warn-unused t)
    (setq verilog-case-indent 2)
    (setq verilog-cexp-indent 2)
    (setq verilog-highlight-grouping-keywords t)
    (setq verilog-highlight-modules t)
    (setq verilog-indent-level 2)
    (setq verilog-indent-level-behavioral 2)
    (setq verilog-indent-level-declaration 2)
    (setq verilog-indent-level-module 2)
    (setq verilog-tab-to-comment t)
    ))

;; ----------------------------------------------------------------------------

;; markdown mode
;;(autoload 'markdown-mode "markdown-mode"
;;   "Major mode for editing Markdown files" t)
;;(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


