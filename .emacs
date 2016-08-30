﻿(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(org-agenda-files
   (quote
    ("d:/users/bercut/home/org/gtd/finan.org" "d:/users/bercut/home/org/gtd/binp.org" "d:/users/bercut/home/org/gtd/personal.org" "d:/users/bercut/home/org/gtd/proj.org" "~/org/journal.org")))
 '(speedbar-show-unknown-files t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; System-type definition
(defun system-is-linux ()
  (string-equal system-type "gnu/linux"))
(defun system-is-windows ()
  (string-equal system-type "windows-nt"))

;; if windows system
;; (if (system-is-windows)
;;    ...  )

(load-file "~/.emacs.d/settings/settings.el")
(load-file "~/.emacs.d/settings/keybinding.el")
(load-file "~/.emacs.d/settings/orgmode.el")