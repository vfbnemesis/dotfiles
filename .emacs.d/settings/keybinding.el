;; --- оригинал https://gist.github.com/anonymous/2471669b376de09adc44 --------
;; --- http://ergoemacs.org/emacs/emacs_kill-ring.html ------------------------

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

;; other

(global-set-key (kbd "C-x C-b") 'ibuffer)
