;; Main use is to have my key bindings have the highest priority
;; https://github.com/kaushalmodi/.emacs.d/blob/master/elisp/modi-mode.el

(defvar my-mode-map (make-sparse-keymap)
  "Keymap for `my-mode'.")

;;;###autoload
(define-minor-mode my-mode
  "A minor mode so that my key settings override annoying major modes."
  ;; If init-value is not set to t, this mode does not get enabled in
  ;; `fundamental-mode' buffers even after doing \"(global-my-mode 1)\".
  ;; More info: http://emacs.stackexchange.com/q/16693/115
  :init-value t
  :lighter " my-mode"
  :keymap my-mode-map)

;;;###autoload
(define-globalized-minor-mode global-my-mode my-mode my-mode)

;; https://github.com/jwiegley/use-package/blob/master/bind-key.el
;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists `((my-mode . ,my-mode-map)))

;; Turn off the minor mode in the minibuffer
(defun turn-off-my-mode ()
  "Turn off my-mode."
  (my-mode -1))
(add-hook 'minibuffer-setup-hook #'turn-off-my-mode)

(progn
  ;; --- KEYBINDINGS ------------------------------------------------------------
  ;; оригинал https://gist.github.com/anonymous/2471669b376de09adc44
  ;; http://ergoemacs.org/emacs/emacs_kill-ring.html

  ;; Крестовина
  (define-key my-mode-map (kbd "M-j") 'backward-char) ; Влево
  (define-key my-mode-map (kbd "M-l") 'forward-char) ; Вправо
  (define-key my-mode-map (kbd "M-i") 'previous-line) ; Вверх
  (define-key my-mode-map (kbd "M-k") 'next-line) ; Вниз

  ;; Move by word
  (define-key my-mode-map (kbd "M-u") 'backward-word)
  (define-key my-mode-map (kbd "M-o") 'forward-word)

  ;; Move by paragraph
  (define-key my-mode-map (kbd "M-U") 'backward-paragraph)
  (define-key my-mode-map (kbd "M-O") 'forward-paragraph)

  ;; Move to beginning/ending of line
  (define-key my-mode-map (kbd "M-H") 'move-beginning-of-line)
  (define-key my-mode-map (kbd "M-h") 'move-end-of-line)

  ;; Move by screen (page up/down)
  (define-key my-mode-map (kbd "M-I") 'scroll-down-command)
  (define-key my-mode-map (kbd "M-K") 'scroll-up-command)

  ;; Move to beginning/ending of file
  (define-key my-mode-map (kbd "M-J") 'beginning-of-buffer)
  (define-key my-mode-map (kbd "M-L") 'end-of-buffer)

  ;; Delete previous/next char.
  (define-key my-mode-map (kbd "M-f") 'delete-forward-char)
  (define-key my-mode-map (kbd "M-d") 'delete-backward-char)

  ;; Delete previous/next word.
  (define-key my-mode-map (kbd "M-e") 'backward-kill-word)
  (define-key my-mode-map (kbd "M-r") 'kill-word)

  ;; Delete (whole) line
  (define-key my-mode-map (kbd "C-S-k") 'kill-whole-line)

  ;; Enter
  (define-key my-mode-map (kbd "M-n") 'reindent-then-newline-and-indent)
  (define-key my-mode-map (kbd "M-m") 'reindent-then-newline-and-indent)

  (define-key my-mode-map (kbd "M-s") 'save-buffer) ; Сохранение
  (define-key my-mode-map (kbd "C-o") 'find-file) ; Открытие

  ;; define key sequence
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  )

(provide 'my-mode)

;; Minor mode tutorial: http://nullprogram.com/blog/2013/02/06/
