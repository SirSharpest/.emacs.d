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
  '(elpy
    nyan-mode
    alect-themes
    leuven-theme
    golden-ratio
    markdown-mode
    auctex
    company-arduino
    company-auctex
    company-c-headers
    company-irony-c-headers
    company-cmake
    company-web
    company-ycm
    company-jedi
    helm-projectile
    py-autopep8
    ;;flycheck-pyflakes
    flyspell
    sr-speedbar
    flycheck
    yasnippet
    puml-mode
    magit
    platformio-mode
    projectile
    flycheck-irony
    python-pep8
    ;;python-pylint
    helm
    ))

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
(global-set-key [C-tab] 'company-complete)
;;Show the column numbers 
(column-number-mode 1)

;;Open terminal
(global-set-key (kbd "C-#") 'ansi-term)
;;jump to errors
(global-set-key (kbd "C-.") 'next-error)
(global-set-key (kbd "C-,") 'previous-error)
;;Compile command!
(global-set-key (kbd "C-c C-a") 'compile)


;;Hide some of the more annoying stuff
(menu-bar-mode -1)
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))


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
    (define-key flyspell-mode-map (kbd "C-<") 'flyspell-goto-next-error)
    (define-key flyspell-mode-map (kbd "C->") 'company-ispell)
    ))
(setq ispell-dictionary "british")

;; Open org mode on start up!
(find-file  (concat"~/.emacs.d/org/daily/" (format-time-string "%Y-%m-%d.org" )))

(custom-set-variables
 '(org-directory "~/.emacs.d/org/daily")
 '(org-agenda-files (list org-directory)))

;;Helm SETUP;;
;;-------------------------------------------
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;; These are some keybinds that affect everything but are defined by helm

(global-set-key (kbd "C-f") 'helm-projectile)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)


;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)

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
;;(define-key elpy-mode-map [C-tab] 'company-complete)
;;Use jedi as the backend for company
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi)
  (setq flycheck-checker 'python-pylint))

(add-hook 'python-mode-hook 'my/python-mode-hook)
(with-eval-after-load 'elpy
  (remove-hook 'elpy-modules 'elpy-module-flymake))

;; Nice indent keybinds
(define-key elpy-mode-map (kbd "C-c C-l") 'elpy-nav-indent-shift-left)
(define-key elpy-mode-map (kbd "C-c C-r") 'elpy-nav-indent-shift-right)

(setq flycheck-python-pylint-executable "pylint3")

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
;;apt install clang

;;Turn on the irony modes
;;(add-hook 'c++-mode-hook 'irony-mode)
;;(add-hook 'c-mode-hook 'irony-mode)


;;Not 100% about this section as it
;;messes up some of my indents 
;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map [remap completion-at-point]
;;     'irony-completion-at-point-async)
;;   (define-key irony-mode-map [remap complete-symbol]
;;     'irony-completion-at-point-async))
;;(add-hook 'irony-mode-hook 'my-irony-mode-hook)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(setq company-backends (delete 'company-semantic company-backends))

(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-irony))


(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;; This makes fly check work with irony 
(add-hook 'flycheck-mode-hook 'flycheck-irony-setup)

;;For some c/c++ stuff
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "~/local/include/")))))
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-standard-library "libc++")))
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-language-standard "c++1y")))


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
 '(flycheck-c/c++-gcc-executable nil)
 '(package-selected-packages
   (quote
    (magit puml-mode sr-speedbar flycheck-pyflakes py-autopep8 jedi company-jedi company-ycm company-web company-auctex company-arduino auctex markdown-mode golden-ratio alect-themes nyan-mode elpy)))
 '(python-check-command "flake8")
 '(python-shell-interpreter "python3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
