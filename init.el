;; SETUP packages
;; --------------------------------------
(setq warning-minimum-level :emergency) ;; to fix annoying start up
(require 'package)
  ;;; Code:
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(add-to-list 'load-path "~/org-mode/lisp/")
(add-to-list 'load-path "~/org-mode/contrib/lisp/" t)
(package-initialize)


(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))
