(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(package-selected-packages
   (quote
    (treemacs-projectile powerline treemacs winum undo-tree ob-ipython helm-c-yasnippet yasnippet-snippets auctex zone-rainbow rainbow-mode multiple-cursors eyebrowse pylint all-the-icons-dired ace-jump-mode expand-region company-quickhelp smooth-scrolling ace-window guide-key iedit use-package langtool telephone-line openwith org-bullets org-ref helm-ag helm-projectile helm golden-ratio magit projectile py-autopep8 flycheck company-anaconda anaconda-mode ein doom-themes better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
