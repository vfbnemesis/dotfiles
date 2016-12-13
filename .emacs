;; my init.el
;; все настройки хранятся в settings.org

;; --- package manager --------------------------------------------------------
;; https://github.com/jwiegley/use-package
;; :init - execute code before a package is loaded
;; :commands - autoload command
;; :config - execute code after a package is loaded
;; :defer - (отложенная загрузка)
;; :ensure - causes the package(s) to be installed automatically
;; if not already present on your system
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

;; Moved the custom.el stuff into its own file called ~/.emacs.d/customize.el
(setq custom-file "~/.emacs.d/settings/customize.el")
(load custom-file)

;; The background color of my org source code blocks needs to be defined before
;; org is loaded.
(defface org-block-begin-line
  '((t (:foreground "#99968b" :background "#303030" :box (:style released-button))))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-end-line
  '((t (:foreground "#99968b" :background "#303030" :box (:style released-button))))
  "Face used for the line delimiting the end of source blocks.")

;; finally, call org-babel to load the real settings file -this is the most
;; important part
(org-babel-load-file "~/.emacs.d/settings/settings.org")
(put 'upcase-region 'disabled nil)
