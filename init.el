;; SETUP packages
;; --------------------------------------
(setq warning-minimum-level :emergency) ;; to fix annoying start up
(require 'package)
  ;;; Code:
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))


(package-initialize)


(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(package-selected-packages
   (quote
    (dap-mode zone-rainbow yasnippet-snippets winum vlf use-package undo-tree treemacs-projectile transpose-frame symbol-overlay swiper-helm smooth-scrolling smart-tabs-mode ranger rainbow-mode rainbow-delimiters pylint py-autopep8 posframe peek-mode org-ref org-plus-contrib org-bullets org openwith ob-ipython nyan-mode nord-theme multiple-cursors magit-popup magit langtool jupyter ivy-xref iedit highlight-indent-guides helm-swoop helm-spotify helm-projectile helm-c-yasnippet helm-ag guide-key golden-ratio flycheck eyebrowse expand-region ess-view ess-smart-equals ess-R-object-popup ess-R-data-view elpy eldoc-eval ein doom-themes doom-modeline dired-imenu cyberpunk-theme company-quickhelp company-box company-anaconda centered-window buffer-move better-defaults auctex all-the-icons-dired alect-themes ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
