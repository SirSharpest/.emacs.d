;; SETUP packages
;; --------------------------------------
(setq warning-minimum-level :emergency) ;; to fix annoying start up
(require 'package)
  ;;; Code:
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))


(package-initialize)


(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))
