;; --- оригинал https://gist.github.com/dbushenko/6045709 ---------------------
;; --- оригинал https://habrahabr.ru/post/248663/ -----------------------------
;; --- оригинал https://habrahabr.ru/post/39564/ ------------------------------

(setq user-full-name   "vfbnemesis")
(setq user-mail-adress "vfbnemesis_mail")

(add-to-list 'load-path "~/.emacs.d/plugins")

;; my minor mode
;; в основном для клавиаттурных сочетаний
(require 'my-mode)

;; Disable GUI components
;;убираем меню и тулбар и прокрутку
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера

;; Inhibit startup/splash screen
;;(setq inhibit-splash-screen   t)
;; экран приветствия можно вызвать комбинацией C-h C-a
;;(setq ingibit-startup-message t)

;; включить выделение выражений между {},[],()
(show-paren-mode t)
;; выделить цветом выражения между {},[],()
(setq show-paren-style 'mixed)

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
;; (cua-mode t)

;; перемещение между окнами
;;(windmove-default-keybindings)

;; сохранять сессию перед выходом
;;  desktop-save-mode t)

(setq-default indent-tabs-mode nil)

;; удаляем пробелы и т.д.
;; http://batsov.com/articles/2011/11/25/emacs-tip-number-3-whitespace-cleanup/
(add-hook 'before-save-hook 'whitespace-cleanup)

(defalias 'yes-or-no-p 'y-or-n-p) ; y or n is enough

(setq save-interprogram-paste-before-kill t)

(global-auto-revert-mode 1) ;; you might not want this
(setq auto-revert-verbose nil) ;; or this
(define-key my-mode-map (kbd "<f6>") 'revert-buffer)

;; --- scrolling --------------------------------------------------------------
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed 'nil)
(setq mouse-wheel-follow-mouse 't)
;;(setq scroll-preserve-screen-position 1) ; keep cursor at same position when scrolling
(setq scroll-step 1)
;; (setq scroll-conservatively 10000) чего делает эта переменная ?

(define-key my-mode-map (kbd "M-<up>") (lambda () (interactive) (scroll-down 1)))
(define-key my-mode-map (kbd "M-<down>") (lambda () (interactive) (scroll-up 1)))

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

(define-key my-mode-map (kbd "C-c q") 'auto-fill-mode-on)

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
;; сайт с темами: https://emacsthemes.com/

(add-to-list 'custom-theme-load-path "~/.emacs.d/plugins")

(setq my-color-themes (list 'deeper-blue
                            'wheatgrass
                            'dark-laptop))

(defun my-theme-set-default () ; Set the first row
      (interactive)
      (setq theme-current my-color-themes)
      (load-theme (car theme-current) t))

(defun my-describe-theme () ; Show the current theme
  (interactive)
  (message "%s" (car theme-current)))

; Set the next theme (fixed by Chris Webber - thanks)
(defun my-theme-cycle ()
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (load-theme (car theme-current) t)
  (message "%S" (car theme-current)))

(setq theme-current my-color-themes)
(my-theme-set-default)

(global-set-key (kbd "<f7>") 'my-theme-cycle)

;; --- hide/show C block ------------------------------------------------------
(defvar hs-special-modes-alist
  (mapcar 'purecopy
          '((c-mode "{" "}" "/[*/]" nil nil)
            (c++-mode "{" "}" "/[*/]" nil nil)
            (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
            (java-mode "{" "}" "/[*/]" nil nil)
            (js-mode "{" "}" "/[*/]" nil)
            (emacs-lisp- "(" ")" nil))))

(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

;; --- быстрый доступ к файлам (C-x r j)---------------------------------------
;; http://pages.sachachua.com/.emacs.d/Sacha.html#org9750649

(defvar my/refile-map (make-sparse-keymap))

(defmacro my/defshortcut (key file)
  `(progn
     (set-register ,key (cons 'file ,file))
     (define-key my/refile-map
       (char-to-string ,key)
       (lambda (prefix)
         (interactive "p")
         (let ((org-refile-targets '(((,file) :maxlevel . 6)))
               (current-prefix-arg (or current-prefix-arg '(4))))
           (call-interactively 'org-refile))))))

(my/defshortcut ?b "~/org/gtd/binp.org")
(my/defshortcut ?p "~/org/gtd/personal.org")
(my/defshortcut ?e "~/org/text/emacs/emacs.org")
(my/defshortcut ?s "~/.emacs.d/settings/settings.el")
(my/defshortcut ?l "~/org/text/bookmarks.org")
(my/defshortcut ?o "~/org")

(setq default-input-method 'russian-computer)
;; --- Ввод командных комбинаций без переключения русской раскладки -----------
;; --- http://ru-emacs.livejournal.com/82428.html
(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

(reverse-input-method 'russian-computer)

;; --- my func ---------------------------------------------------------------
;; System-type definition
(defun system-is-linux ()
  (string-equal system-type "gnu/linux"))

(defun system-is-windows ()
  (string-equal system-type "windows-nt"))

;; --- python.el --------------------------------------------------------------
(setq python-shell-interpreter "ipython3"
      python-shell-interpreter-args "-i")

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

;; номера строк (слева)
;; http://code.google.com/p/dea/source/browse/trunk/my-lisps/linum%2B.el
(require 'linum+)
(setq linum-format "%d ")
;; (global-linum-mode 1)


;; buffer show файлы + scratch
;; built-in
(require 'bs)
(setq bs-configurations
'(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))

(define-key my-mode-map (kbd "<f2>") 'bs-show)

;; --- use-packages -----------------------------------------------------------
;; https://github.com/jwiegley/use-package
;; :init - execute code before a package is loaded
;; :commands - autoload command
;; :config - execute code after a package is loaded
;; :defer - (отложенная загрузка)
;; :ensure - causes the package(s) to be installed automatically
;; if not already present on your system

(use-package sr-speedbar
  ;; браузер по файловой системе
  :ensure t
  :bind (("<f12>" . sr-speedbar-toggle))
  :config
  (progn
    (custom-set-variables
     '(speedbar-show-unknown-files t)) ;; отображение всех файлов
    (setq speedbar-use-images nil)
    ))

(use-package recentf
  :ensure t
  :bind (:map my-mode-map
              ("C-x C-r" . recentf-open-files))
  :config
  (progn
    (setq recent-max-saved-items 200
          recent-max-menu-items 15)
    (recentf-mode t)
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
  :bind (("C-=" . er/expand-region))
  )

(use-package ido
  ;; ido (built-in) помогает выбирать
  ;; помогает выбирать
  ;; :defer t
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
  :bind (("M-x" . smex)
         ("C-c C-c M-x" . execute-extended-command))
  :config
  (progn
    (smex-initialize)
    ))

(use-package counsel
  :ensure t
  :bind (("M-y" . counsel-yank-pop))
  :bind (:map ivy-minibuffer-map
              ("M-y" . ivy-next-line))
  )

(use-package ivy
  :ensure t
  ;; :diminish (ivy-mode)
  ;; :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :bind (:map my-mode-map
              ("C-s" . swiper)
              ("C-c u" . swiper-all))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    ;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
    ;; (global-set-key (kbd "<f6>") 'ivy-resume)
    ;; (global-set-key (kbd "M-x") 'counsel-M-x)
    ;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    ;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    ;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    ;; (global-set-key (kbd "<f1> l") 'counsel-load-library)
    ;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    ;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    ;; (global-set-key (kbd "C-c g") 'counsel-git)
    ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
    ;; (global-set-key (kbd "C-c k") 'counsel-ag)
    ;; (global-set-key (kbd "C-x l") 'counsel-locate)
    ;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    ;; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package whitespace
  :ensure t
  )

(use-package hydra
  :ensure t
  ;; :bind (:map my-mode-map
  ;;             ("<f5>" . my/window-movement/body)
  ;;             ("<f6>" . my/hydra-toggle/body))
  :config
  (progn
    ;; --------------------------------------------------------------------------
    (defhydra my/window-movement (:color blue
                                  :hint nil)
      "
^Winmovie^       ^ace-window^             ^Split^                  ^text size^
^^^^^^-----------------------------------------------------------------------
 _<left>_        _a_: ace-window          _2_: split-window-below  _j_: in
 _<right>_       _s_: swap ace-window     _3_: split-window-right  _k_: out
 _<up>_          _d_: delete ace window   ^ ^                      _0_: reset
 _<down>_        _i_: ace maximize        ^ ^                      ^ ^
"
      ("<left>" windmove-left)
      ("<right>" windmove-right)
      ("<down>" windmove-down)
      ("<up>" windmove-up)

      ("a" ace-window)
      ("s" ace-swap-window)
      ("d" ace-delete-window)
      ("i" ace-maximize-window)

      ("2" split-window-below nil)
      ("3" split-window-right nil)

      ("j" text-scale-increase :color red)
      ("k" text-scale-decrease :color red)
      ("0" (text-scale-set 0))

      ("q" nil "quit" :color blue))

    (defhydra my/hydra-toggle (:hint nil)
      "
_a_: abbrev-mode        %`abbrev-mode
_f_: auto-fill-mode     %`auto-fill-function
_t_: truncate-lines     %`truncate-lines
_w_: whitespace-mode    %`whitespace-mode
_v_: visual-line-mode   %`visual-line-mode
"
      ("a" abbrev-mode nil)
      ("w" whitespace-mode nil)
      ("f" auto-fill-mode nil)
      ("t" toggle-truncate-lines nil)
      ("v" visual-line-mode)
      ("q" nil "quit" :color blue))

    (defhydra my/hydra-bookmark (:color blue
                                 :hint nil)
      "
_s_: set bookmark
_j_: jump bookmark
_l_: list bookmark
_w_: write bookmark to file
"
      ("s" bookmark-set)
      ("j" bookmark-jump)
      ("l" list-bookmarks)
      ("w" bookmark-write)
      ("q" nil "quit"))
    ))

(use-package key-chord
  :ensure t
  :init
  (progn
    ;; (fset 'key-chord-define 'my/key-chord-define)
    (setq key-chord-one-key-delay 0.16)
    (key-chord-mode 1)
    (key-chord-define-global "yy" 'my/window-movement/body)
    (key-chord-define-global "tt" 'my/hydra-toggle/body)
    (key-chord-define-global "bb" 'my/hydra-bookmark/body)
    ))

(use-package ace-window
  :ensure t
  :bind (:map my-mode-map
              ("C-c w" . ace-window))
  :config
  (progn
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    (setq aw-dispatch-always t)

    (defvar aw-dispatch-alist
      '((?x aw-delete-window " Ace - Delete Window")
        (?m aw-swap-window " Ace - Swap Window")
        (?n aw-flip-window)
        (?v aw-split-window-vert " Ace - Split Vert Window")
        (?b aw-split-window-horz " Ace - Split Horz Window")
        (?i delete-other-windows " Ace - Maximize Window")
        (?o delete-other-windows))
      "List of actions for `aw-dispatch-default'.")
    ))

(use-package avy
  :ensure t
  :bind (:map my-mode-map
              ("C-c SPC" . avy-goto-word-or-subword-1)
              ("C-c l" . avy-goto-line))
  )

;; https://github.com/magnars/multiple-cursors.el
(use-package multiple-cursors
  :ensure t
  :bind (:map my-mode-map
              ("C-S-c C-S-c" . mc/edit-lines)
              ("C->" . mc/mark-next-like-this)
              ("C-<" . mc/mark-previous-like-this)
              ("C-c C-<" . mc/mark-all-like-this)
              ("C-S-<mouse-1>" . mc/add-cursor-on-click))
  :bind (:map region-bindings-mode-map
              ("a" . mc/mark-all-like-this)
              ("p" . mc/mark-previous-like-this)
              ("n" . mc/mark-next-like-this)
              ("P" . mc/unmark-previous-like-this)
              ("N" . mc/unmark-next-like-this)
              ("[" . mc/cycle-backward)
              ("]" . mc/cycle-forward)
              ("m" . mc/mark-more-like-this-extended)
              ("h" . mc-hide-unmatched-lines-mode)
              ("\\" . mc/vertical-align-with-space)
              ("#" . mc/insert-numbers) ; use num prefix to set the starting number
              ("^" . mc/edit-beginnings-of-lines)
              ("$" . mc/edit-ends-of-lines))
  :init
  (progn
    ;; (setq mc/list-file (locate-user-emacs-file "mc-lists"))

    ;; Disable the annoying sluggish matching paren blinks for all cursors
    ;; when you happen to type a ")" or "}" at all cursor locations.
    (defvar modi/mc-blink-matching-paren--store nil
      "Internal variable used to restore the value of `blink-matching-paren'
after `multiple-cursors-mode' is quit.")

    ;; The `multiple-cursors-mode-enabled-hook' and
    ;; `multiple-cursors-mode-disabled-hook' are run in the
    ;; `multiple-cursors-mode' minor mode definition, but they are not declared
    ;; (not `defvar'd). So do that first before using `add-hook'.
    (defvar multiple-cursors-mode-enabled-hook nil
      "Hook that is run after `multiple-cursors-mode' is enabled.")
    (defvar multiple-cursors-mode-disabled-hook nil
      "Hook that is run after `multiple-cursors-mode' is disabled.")

    (defun modi/mc-when-enabled ()
      "Function to be added to `multiple-cursors-mode-enabled-hook'."
      (setq modi/mc-blink-matching-paren--store blink-matching-paren)
      (setq blink-matching-paren nil))

    (defun modi/mc-when-disabled ()
      "Function to be added to `multiple-cursors-mode-disabled-hook'."
      (setq blink-matching-paren modi/mc-blink-matching-paren--store))

    (add-hook 'multiple-cursors-mode-enabled-hook #'modi/mc-when-enabled)
    (add-hook 'multiple-cursors-mode-disabled-hook #'modi/mc-when-disabled)
    ))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package powerline
  :ensure t
  :config
  (progn
    (powerline-default-theme)
    (setq powerline-arrow-shape 'arrow)   ;; the default
    ;; (setq powerline-arrow-shape 'curve)   ;; give your mode-line curves
    ;; (setq powerline-arrow-shape 'arrow14) ;; best for small fonts
    (setq powerline-color1 "grey22")
    (setq powerline-color2 "grey40")
    (custom-set-faces
     '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
     '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))
  ))

(use-package iedit
  :ensure t
  :bind (:map my-mode-map
              ("C-c ;" . iedit-mode))
  )

;; if you're windened, narrow to the region, if you're narrowed, widen
;; bound to C-x n
(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing command.
         ;; Remove this first conditional if you don't want it.
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((org-at-block-p)
                (org-narrow-to-block))
               (t (org-narrow-to-subtree))))
        (t (narrow-to-defun))))

;; (define-key ctl-x-map "n" #'narrow-or-widen-dwim)

;; deletes all the whitespace when you hit backspace or delete
(use-package hungry-delete
  :ensure t
  :config
  (progn
    (setq hungry-delete-chars-to-skip " \t\r\f\v")

    (defun modi/turn-off-hungry-delete-mode ()
      "Turn off hungry delete mode."
      (hungry-delete-mode -1))

    ;; Enable `hungry-delete-mode' everywhere ..
    (global-hungry-delete-mode)

    ;; Except ..
    ;; `hungry-delete-mode'-loaded backspace does not work in `wdired-mode',
    ;; i.e. when editing file names in the *Dired* buffer.
    ;; (add-hook 'wdired-mode-hook #'modi/turn-off-hungry-delete-mode)
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

    ;; (add-hook 'verilog-mode-hook (lambda () (abbrev-mode t)))
    ))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode)
  :mode (("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode))
  :init (setq markdown-command "markdown")
  )

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  )

(use-package projectile
  :ensure t
  )

(use-package highlight-symbol
  :ensure t
  :bind (:map my-mode-map
              ("<f5>" . highlight-symbol)
              ("C-<f5>" . highlight-symbol-next)
              ("S-<f5>" . highlight-symbol-prev)
              ("M-<f5>" . highlight-symbol-query-replace))
  )

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t))

;; (use-package fill-column-indicator
;;   :ensure t
;;   :config
;;   (define-globalized-minor-mode
;;     global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;   (global-fci-mode t))

(use-package flycheck
  :ensure t
  :if (system-is-linux)
  :init
  (setq flycheck-python-pylint-executable "pylint3")
  (global-flycheck-mode t))

;; https://zhimingwang.org/blog/2015-04-26-using-python-3-with-emacs-jedi.html
;; > mkdir -p ~/.emacs.d/.python-environments
;; > virtualenv -p /usr/bin/python3 ~/.emacs.d/.python-environments/jedi
;; If you feel like installing the server with 'M-x jedi:install-server', also do the following
;; > ~/.emacs.d/.python-environments/jedi/bin/pip install --upgrade ~/.emacs.d/elpa/jedi-core-20160709.722/

(use-package jedi
  :ensure t
  :if (system-is-linux)
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup)
  (setq jedi:complete-on-dot t)
  (setq jedi:environment-root "jedi"))

;; https://github.com/antonj/Highlight-Indentation-for-Emacs
;; Provides two minor modes `highlight-indentation-mode' and
;; `highlight-indentation-current-column-mode'.
;;     * `highlight-indentation-mode' displays guidelines
;;       indentation (space indentation only).
;;     * `highlight-indentation-current-column-mode' displays guidelines
;;       for the current-point indentation (space indentation only).
;; (use-package highlight-indentation
;;   :ensure t
;;   :config
;;   (set-face-background 'highlight-indentation-face "#454945")
;;   ;; (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")
;;   (add-hook 'python-mode-hook 'highlight-indentation-mode))

(use-package indent-guide
  :ensure t
  :config
  (set-face-foreground 'indent-guide-face "cyan")
  (add-hook 'python-mode-hook 'indent-guide-mode))

;; (use-package smartparens
;;   :ensure t

;;   )

;;; bm
;; https://github.com/joodland/bm
(use-package bm
         :ensure t
         :init
         ;; restore on load (even before you require bm)
         (setq bm-restore-repository-on-load t)
         :bind (:map my-mode-map
                     ("C-c b" . hydra-bm/body))
         :config
         ;; Allow cross-buffer 'next'
         (setq bm-cycle-all-buffers t)
         ;; where to store persistant files
         (setq bm-repository-file "~/.emacs.d/bm-repository")
         ;; save bookmarks
         (setq-default bm-buffer-persistence t)
         ;; Loading the repository from file when on start up.
         (add-hook' after-init-hook 'bm-repository-load)
         ;; Restoring bookmarks when on file find.
         (add-hook 'find-file-hooks 'bm-buffer-restore)
         ;; Saving bookmarks
         (add-hook 'kill-buffer-hook #'bm-buffer-save)
         ;; Saving the repository to file when on exit.
         ;; kill-buffer-hook is not called when Emacs is killed, so we
         ;; must save all bookmarks first.
         (add-hook 'kill-emacs-hook #'(lambda nil
                                          (bm-buffer-save-all)
                                          (bm-repository-save)))
         ;; The `after-save-hook' is not necessary to use to achieve persistence,
         ;; but it makes the bookmark data in repository more in sync with the file
         ;; state.
         (add-hook 'after-save-hook #'bm-buffer-save)
         ;; Restoring bookmarks
         (add-hook 'find-file-hooks   #'bm-buffer-restore)
         (add-hook 'after-revert-hook #'bm-buffer-restore)
         ;; The `after-revert-hook' is not necessary to use to achieve persistence,
         ;; but it makes the bookmark data in repository more in sync with the file
         ;; state. This hook might cause trouble when using packages
         ;; that automatically reverts the buffer (like vc after a check-in).
         ;; This can easily be avoided if the package provides a hook that is
         ;; called before the buffer is reverted (like `vc-before-checkin-hook').
         ;; Then new bookmarks can be saved before the buffer is reverted.
         ;; Make sure bookmarks is saved before check-in (and revert-buffer)
         (add-hook 'vc-before-checkin-hook #'bm-buffer-save)
         (defhydra hydra-bm (:color pink
                             :hint nil
                             :body-pre (when (not (use-region-p)) (push-mark)))
           "
Bookmark _n_ext (_N_ in lifo order)            toggle book_m_ark        ^^_/_ bm lines matching regexp                          toggle per_s_istence
         _p_revious (_P_ in lifo order)        _a_nnotate               _x_/_X_ remove all bm from current/all buffer(s)        _r_eturn to from where you started
    "
           ("m"   bm-toggle)
           ("M"   bm-toggle :color blue)
           ("a"   bm-bookmark-annotate :color blue)
           ("n"   bm-common-next)
           ("N"   bm-lifo-next)
           ("p"   bm-common-previous)
           ("P"   bm-lifo-previous)
           ("/"   modi/bm-bookmark-regexp :color blue)
           ("s"   bm-toggle-buffer-persistence)
           ("x"   bm-remove-all-current-buffer :color blue)
           ("X"   bm-remove-all-all-buffers :color blue)
           ("r"   pop-to-mark-command :color blue)
           ("RET" nil "cancel" :color blue)
           ("q" nil "cancel" :color blue))
         )

;; https://github.com/rejeep/wrap-region.el Wrap Region is a minor mode for
;; Emacs that wraps a region with punctuations. For "tagged" markup modes, such
;; as HTML and XML, it wraps with tags. Select a region and press any of the
;; following keys: ", ', (, {, [.
(use-package wrap-region
  :ensure t
  :config
  (progn
    ;; Enable `wrap-region' in the following major modes
    (dolist (hook '(emacs-lisp-mode-hook
                    org-mode-hook
                    text-mode-hook
                    markdown-mode-hook))
      (add-hook hook #'wrap-region-mode))

    ;; Override the default `wrap-region-define-wrappers' function so that it
    ;; does not bind the "[", "{", "<" keys each time `wrap-region-mode' is
    ;; enabled in a buffer.
    (defun wrap-region-define-wrappers ()
      "Defines defaults wrappers."
      (mapc
       (lambda (pair)
         (apply 'wrap-region-add-wrapper pair))
       '(("\"" "\"")
         ("'"  "'")
         ("("  ")")))
      ;; Unbind the wrap region pairs which I am very unlikely to us.
      ;; Doing so allows me to bind those to more useful functions in
      ;; `region-bindings-mode-map'. See `setup-multiple-cursors.el' file
      ;; for examples.
      (wrap-region-unset-key "[")
      (wrap-region-unset-key "{")
      (wrap-region-unset-key "<"))

    (wrap-region-add-wrapper "`" "'" nil 'emacs-lisp-mode)

    (wrap-region-add-wrapper "`" "`"   nil '(text-mode markdown-mode))
    (wrap-region-add-wrapper "**" "**" "*" '(text-mode markdown-mode))
    (wrap-region-add-wrapper "*" "*"   "/" '(text-mode markdown-mode))
    (wrap-region-add-wrapper "~~" "~~" "+" '(text-mode markdown-mode))

    (wrap-region-add-wrapper "=" "=" nil 'org-mode)
    (wrap-region-add-wrapper "*" "*" nil 'org-mode)
    (wrap-region-add-wrapper "/" "/" nil 'org-mode)
    (wrap-region-add-wrapper "_" "_" nil 'org-mode)
    (wrap-region-add-wrapper "+" "+" nil 'org-mode)))
;; ----------------------------------------------------------------------------
