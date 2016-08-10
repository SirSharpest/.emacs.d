;;Adding the required repos for the package manager
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    nyan-mode
    alect-themes
    golden-ratio
    markdown-mode
    auctex
    company-arduino
    company-auctex
    company-c-headers
    company-web
    company-ycm
    company-jedi
    jedi
    py-autopep8
    flycheck-pyflakes
    flyspell
    sr-speedbar
    flycheck
    yasnippet
    magit))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;;Actually load packages required! 
(package-initialize)

;; GENERAL SETUP
;; --------------------------------------

;;Turn on some flycheck checking
(global-flycheck-mode)
;;Jump to the beginning/end of buffer
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)

;;Open terminal
(global-set-key (kbd "C-#") 'ansi-term)
;;jump to errors
(global-set-key (kbd "C-,") 'next-error)
(global-set-key (kbd "C-.") 'previous-error)
;;Compile command!
(global-set-key (kbd "C-c C-a") 'compile)


;;Load paren display
(setq show-paren-delay 0)
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'alect-dark t) ;; load  theme
(global-linum-mode t) ;; enable line numbers globally
(ido-mode 0) ;; turn off ido because its annoying

;;turn on some saving data
(savehist-mode 1)

(require 'sr-speedbar)
(global-set-key [f8] 'sr-speedbar-toggle)
(setq sr-speedbar-right-side nil)  
(setq sr-speedbar-max-width 5)   
(setq sr-speedbar-default-width 10)
(setq speedbar-show-unknown-files t)

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;Most important of all
(nyan-mode 1)
(nyan-start-animation)   ;; this line makes nyan cat do an animation

;; Activate golden ratio
(golden-ratio-mode 1)

;;Turn on my markdown plugin
(require 'markdown-mode)

(add-hook 'after-init-hook 'global-company-mode)

;; Spell check activate
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(eval-after-load "flyspell"
  '(progn
    (define-key flyspell-mode-map (kbd "C-.") nil)
    (define-key flyspell-mode-map (kbd "C-,") nil)
    (define-key flyspell-mode-map (kbd "C-<") 'company-ispell)
    (define-key flyspell-mode-map (kbd "C->") 'flyspell-goto-next-error)
    ))
(setq ispell-dictionary "british")

;;PYTHON SETUP;; 
;;-------------------------------------------
;; pip install jedi
;; # flake8 for code checks
;; pip install flake8
;; apt install pyflakes <-- this is needed for syntax to be checked
;; # importmagic for automatic imports
;; pip install importmagic
;; # and autopep8 for automatic PEP8 formatting
;; pip install autopep8
;; # and yapf for code formatting
;; pip install yapf
;; apt install virtualenv
;; pip install pylint for syntax checks
(elpy-enable)
;;(setq elpy-rpc-backend "jedi")
(setq python-shell-completion-native-enable nil)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-python-command "python3")
(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)                 ; optional
(setq elpy-rpc-python-command "python3")
;;'(python-shell-interpreter "python3")
(define-key elpy-mode-map [C-tab] 'company-complete)
;;Use jedi as the backend for company
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)
;; Nice indent keybinds
(define-key elpy-mode-map (kbd "C-c C-l") 'elpy-nav-indent-shift-left)
(define-key elpy-mode-map (kbd "C-c C-r") 'elpy-nav-indent-shift-right)

;; LATEX SETUP;;
;;-------------------------------------------

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else


;; C/C++ SETUP;;
;; -------------------------------------------------------------------------

;;apt install cppchecker


;; BASH;;
;; -------------------------------------------------------------------------
(eval-after-load "term"
  '(progn
    (yas-global-mode 0)
    ))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(python-shell-interpreter "python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
