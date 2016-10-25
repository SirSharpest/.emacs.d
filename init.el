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
    flycheck-pyflakes
    flyspell
    sr-speedbar
    flycheck
    yasnippet
    magit
    platformio-mode
    projectile
    flycheck-irony
    python-pep8
    python-pylint
    helm
    w3m
    latex-preview-pane
    zone-rainbow
    ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;;Actually load packages required! 
(package-initialize)

;; GENERAL SETUP
;; --------------------------------------

;; enable helm being loaded
;; to get rid of unassigned errors 
(require 'helm)



;; Set the default font size to stop different DE's  changing size
(set-face-attribute 'default nil :height 110) 


;;(shell) ;; I like to turn on the shell when I startup!
;; Just aside note, eshell isn't great for completion
;; Applications such as Vi still don't work great and I've no idea how to fix just yet 

;;Turn on some flycheck checking
(global-flycheck-mode)
;;Jump to the beginning/end of buffer
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)
(global-set-key [C-tab] 'company-complete)
(global-set-key (kbd "C-<down>") 'forward-sexp)
(global-set-key (kbd "C-<up>") 'backward-sexp)
(global-set-key (kbd "C-=") 'magit-status)

;;Helm-projectile to jump across to other files!
(global-set-key (kbd "M-o") 'helm-projectile-find-other-file)


;;Adding some keybinds that
;;1. I don't use, and
;;2. would be useful for smaller keyboards w/o arrows
					;(global-set-key (kbd "C-[") 'previous-line)
					;(global-set-key (kbd "C-'") 'next-line)
					;(global-set-key (kbd "C-;") 'backward-char)
					;(global-set-key (kbd "C-#") 'forward-char)


;;Show the column numbers 
(column-number-mode 1)

;;Always always have this paren on
(show-paren-mode 1)

;;Open terminal
					;(global-set-key (kbd "C-=") 'ansi-term)
;;jump to errors
(global-set-key (kbd "C-.") 'next-error)
(global-set-key (kbd "C-,") 'previous-error)
;;Compile command!
(global-set-key (kbd "C-c C-a") 'compile)

;;Enable cookies in web browser
(setq w3m-use-cookies t)
;;change w3m user-agent to android
(setq w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; zh-tw; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.")

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

(defun dear-diary ()
  "This function can be used to create an org file with today as it's file name."
  (interactive)
  (find-file  (concat "~/.emacs.d/org/daily/" (format-time-string "%Y-%m-%d.org" ))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(flycheck-c/c++-gcc-executable nil)
 '(org-agenda-files (list org-directory))
 '(org-directory "~/.emacs.d/org/daily")
 '(package-selected-packages
   (quote
    (flycheck-clangcheck zone-rainbow magit puml-mode sr-speedbar flycheck-pyflakes py-autopep8 jedi company-jedi company-ycm company-web company-auctex company-arduino auctex markdown-mode golden-ratio alect-themes nyan-mode elpy)))
 '(python-check-command "flake8")
 '(python-shell-interpreter "python3"))

;;Helm SETUP;;
;;-------------------------------------------
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-s") 'helm-imenu)

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

;;keep a list of recently opened files
;;REMEMBER ME
(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")

;; These are some keybinds that affect everything but are defined by helm

(global-set-key (kbd "C-f") 'helm-projectile)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x A") 'helm-for-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-b") 'helm-mini)

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
;;Use jedi as the backend for company
(setq flycheck-python-pylint-executable "pylint3")
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi)
  (setq flycheck-checker 'python-pylint))

(add-hook 'python-mode-hook 'my/python-mode-hook)
(with-eval-after-load 'elpy
  (remove-hook 'elpy-modules 'elpy-module-flymake))

;; Nice indent keybinds
(define-key elpy-mode-map (kbd "C-c C-l") 'elpy-nav-indent-shift-left)
(define-key elpy-mode-map (kbd "C-c C-r") 'elpy-nav-indent-shift-right)


;;EMMS

;;** EMMS
;; Autoload the id3-browser and bind it to F7.
;; You can change this to your favorite EMMS interface.
(autoload 'emms-smart-browse "emms-browser.el" "Browse with EMMS" t)
(global-set-key [(f7)] 'emms-smart-browse)

(with-eval-after-load 'emms
  (emms-standard) ;; or (emms-devel) if you want all features
  (setq emms-source-file-default-directory "~/Music"
	emms-info-asynchronously t
	emms-show-format "♪ %s")

  ;; Might want to check `emms-info-functions',
  ;; `emms-info-libtag-program-name',
  ;; `emms-source-file-directory-tree-function'
  ;; as well.

  ;; Determine which player to use.
  ;; If you don't have strong preferences or don't have
  ;; exotic files from the past (wma) `emms-default-players`
  ;; is probably all you need.
  (if (executable-find "mplayer")
      (setq emms-player-list '(emms-player-mplayer))
    (emms-default-players))

  ;; For libre.fm see `emms-librefm-scrobbler-username' and
  ;; `emms-librefm-scrobbler-password'.
  ;; Future versions will use .authoinfo.gpg.
  )


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


;; This makes fly check work with irony 
(add-hook 'flycheck-mode-hook 'flycheck-irony-setup)

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


;;For some c++ stuff
(add-hook 'c++-mode-hook 'irony-mode
          (lambda ()
	    (setq flycheck-clang-include-path
		  (list (expand-file-name "~/local/include/")))
	    (setq flycheck-checker 'c/c++-gcc)
	    (setq flycheck-gcc-language-standard "c++14")
	    (setq flycheck-clang-standard-library "libc++")
	    (setq check-clang-standard-library "libc++")
	    (setq flycheck-gcc-warnings '("pedantic" "all" "extra"
					  "conversion" "effc++" "strict-null-sentinel"
					  "old-style-cast" "noexcept" "ctor-dtor-privacy"
					  "overloaded-virtual" "sign-promo"
					  "zero-as-null-pointer-constant"
					  "suggest-final-types" "suggest-final-methods"
					  "suggest-override" "strict-prototypes"))))


(add-hook 'c-mode-hook
	  (lambda ()
	    (setq flycheck-select-checker 'c/c++-gcc)
	    (setq flycheck-gcc-language-standard "c99")
	    (setq flycheck-gcc-warnings '("pedantic" "all" "extra"))))



;; Custom comment function for C/C++
(defun insert-doc-comment () (interactive)
       (insert "/**\n * @brief  \n *\n * LongerDescription \n *\n * @param \n * @return \n */"))

(define-key global-map [(S-f1)] 'insert-doc-comment)

(eval-after-load "cc-mode"
  '(progn
     (define-key c-mode-map (kbd "C-c C-a") nil)
     ))

;; BASH;;
;; -------------------------------------------------------------------------
(eval-after-load "term"
  '(progn
     (yas-global-mode 0)
     ))



;; interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)

;; make completion buffers disappear after 3 seconds.
(add-hook 'completion-setup-hook
	  (lambda () (run-at-time 3 nil
				  (lambda () (delete-windows-on "*Completions*")))))


;; Octave setup (THIS SHOULD BE DEFAULT PLEASE FIX IN EMACS 25>)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
	  (lambda ()
	    (abbrev-mode 1)
	    (auto-fill-mode 1)
	    (if (eq window-system 'x)
		(font-lock-mode 1))))
(setq-default octave-auto-indent t)
(setq-default octave-auto-newline t)
(setq-default octave-blink-matching-block t)
(setq-default octave-block-offset 4)
(setq-default octave-continuation-offset 4)
(setq-default octave-continuation-string "\\")
(setq-default octave-mode-startup-message t)
(setq-default octave-send-echo-input t)
(setq-default octave-send-line-auto-forward t)
(setq-default octave-send-show-buffer t)


;; Window manager settings
(set-frame-parameter nil 'fullscreen 'fullboth)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
