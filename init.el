;;Adding the required repos for the package manager 
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;;Actually load packages required! 
(package-initialize)

;;loading theme stuff
;;(load-theme 'zenburn t)
(load-theme 'alect-dark t)      

;;Turning on ido-mode as it seems to be needed by a few things 
;;(require 'ido)
;;(ido-mode t)

;;Load paren display
(setq show-paren-delay 0)

;;Helm stuff with some gtags
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse) 

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
;;End of helm stuff 

;;turn on some saving data
(savehist-mode 1)

;;Indent mode
;;(add-hook 'highlight-indentation-mode-hook 'python-mode)
;;(set-face-background 'highlight-indentation-face "#e3e3d3")
;;(set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

;;Fill column indicator
;;(require 'fill-column-indicator)
;;(define-globalized-minor-mode
 ;;global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode t)

;;Enable tree browser
(require 'sr-speedbar)
(global-set-key [f8] 'sr-speedbar-toggle)
(setq sr-speedbar-right-side nil)  
(setq sr-speedbar-max-width 5)   
(setq sr-speedbar-default-width 10)
(setq speedbar-show-unknown-files t)

;;Enable line numbers 
(add-hook 'prog-mode-hook 'linum-mode)

;;Adding some company auto complete stuff
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;;Most important of all
(nyan-mode 1)
(nyan-start-animation)   ;; this line makes nyan cat do an animation

;;Activate flycheck 
(require 'flycheck)
(global-flycheck-mode)

;;Adding more python stuff
(elpy-enable)
(elpy-use-ipython)
(setq python-shell-completion-native-enable nil)

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'electric-pair-mode)

;;Turn on the golden ratio addon
(require 'golden-ratio)
;;Added next line to try and avoid resizing the speedbar 
(setq golden-ratio-exclude-buffer-names '("*SPEEDBAR*"))




(golden-ratio-mode 1)

;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)


;;Turn on my markdown plugin
(require 'markdown-mode)

;;Turn on latex stuff
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;;(setq TeX-PDF-mode t)

;;Adding some flymake stuff 
(require 'flymake)

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(add-hook 'LaTeX-mode-hook 'flymake-mode)

;;Adding spelling
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;;Adding outline mode defs
(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else


;;Enable all that org mode goodness
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;Adding a split window function
(defun window-toggle-split-direction ()
  "Switch window split from horizontally to vertically, or vice versa.

i.e. change right window to bottom, or change bottom window to right."
  (interactive)
  (require 'windmove)
  (let ((done))
    (dolist (dirs '((right . down) (down . right)))
      (unless done
        (let* ((win (selected-window))
               (nextdir (car dirs))
               (neighbour-dir (cdr dirs))
               (next-win (windmove-find-other-window nextdir win))
               (neighbour1 (windmove-find-other-window neighbour-dir win))
               (neighbour2 (if next-win (with-selected-window next-win
                                          (windmove-find-other-window neighbour-dir next-win)))))
          ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
          (setq done (and (eq neighbour1 neighbour2)
                          (not (eq (minibuffer-window) next-win))))
          (if done
              (let* ((other-buf (window-buffer next-win)))
                (delete-window next-win)
                (if (eq nextdir 'right)
                    (split-window-vertically)
                  (split-window-horizontally))
                (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))



;;Adding links to my org lists
(setq org-agenda-files (list "~/.emacs.d/org/NPPC.org"
                             "~/.emacs.d/org/personal.org"))

;;Adding some custom keybinds

;;Change the buffer list to be helm
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;;Autocomplete
(global-set-key (kbd "C-'") 'company-complete)


;;Custom C function
;; Run C programs directly from within emacs
(defun execute-c-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat "gcc " (buffer-name) " && ./a.out" ))
  (shell-command foo))

;;Jump across errors 
(global-set-key [C-f1] 'execute-c-program)
(global-set-key (kbd "C-.") 'next-error)
(global-set-key (kbd "C-,") 'previous-error)
(global-set-key (kbd "C-#") 'ansi-term)


;;Custom function for expanding all of speedbars


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes
   (quote
    ("a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "1dd4a70e719e4ad7b3581dbe18b50fd9b7147447ba87f59dc47627bf4856be8c" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" default)))
 '(fci-rule-color "#383838")
 '(hl-sexp-background-color "#efebe9")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (alect-themes sr-speedbar nyan-mode magit neotree tabbar zenburn material-theme elpy github-theme highlight-indentation fill-column-indicator ## auctex zenburn-theme python-mode markdown-mode leuven-theme helm-projectile helm-gtags golden-ratio flyspell-correct company-jedi auto-complete)))
 '(python-shell-interpreter "python3")
 '(sr-speedbar-right-side nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(put 'upcase-region 'disabled nil)
