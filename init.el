;;Adding the required repos for the package manager

;;; Code:
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
    company-inf-ruby
    helm-projectile
    helm-swoop
    py-autopep8
    flycheck-pyflakes
    flyspell
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
    org-bullets
    smyx-theme
    neotree
    doom-themes
    openwith
    org-ref
    telephone-line
    all-the-icons
    dracula-theme
    ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;;Actually load packages required!
(package-initialize)

;; GENERAL SETUP
;; --------------------------------------

;; white space
;;(add-hook 'prog-mode-hook 'whitespace-mode)

;; Icons setup
(require 'all-the-icons)

;; Turn on neotree
(add-hook 'after-init-hook #'neotree-toggle)

;; Org mode convert stuff
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process (quote ("texi2dvi --pdf %f
pdflatex --shell-escape %f 
texi2dvi --pdf %f --shell-escape
latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f")))

;; Turn on languages for org mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)
   (plantuml .t)))

(setq org-confirm-babel-evaluate nil)

;; For ruby
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))

(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml.jar"))

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; auto close bracket insertion. New in emacs 24
(electric-pair-mode 1)


;; Turn on org-mode syntax highlighting for src blocks
(setq org-src-fontify-natively t)

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

;; Neotree
(require 'neotree)
(setq neo-smart-open t)
 (global-set-key [f8] 'neotree-toggle)

;; Open with external application 
(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))))

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

;;; load doom theme
(require 'doom-themes)

;; Brighter files 
;;(add-hook 'find-file-hook #'doom-buffer-mode-maybe)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

(load-theme 'dracula t) ;; load  theme

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(global-linum-mode t) ;; enable line numbers globally
(ido-mode 0) ;; turn off ido because its annoying

;;turn on some saving data
(savehist-mode 1)

;;
(require 'org-ref)

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

(defun diss-summary ()
  "This function can be used to create an org file with today as it's file name."
  (interactive)
  (find-file  (concat "~/Dropbox/Dissertation/Documents/Notes/" (format-time-string "%Y-%m-%d.org" ))))

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
 '(custom-safe-themes
   (quote
    ("ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "31e64af34ba56d5a3e85e4bebefe2fb8d9d431d4244c6e6d95369a643786a40e" "4b207752aa69c0b182c6c3b8e810bbf3afa429ff06f274c8ca52f8df7623eb60" "60668f4b17b8b8780d50976c0788abed190353d21d3371b8f244dd44c103b0ea" "759416a7a5f5cb6b8cb26e6db2cf70026aa2324083a888015ee2cad0320f7f19" "d2c61aa11872e2977a07969f92630a49e30975220a079cd39bec361b773b4eb3" "10e3d04d524c42b71496e6c2e770c8e18b153fcfcc838947094dad8e5aa02cef" "9f569b5e066dd6ca90b3578ff46659bc09a8764e81adf6265626d7dc0fac2a64" "611e38c2deae6dcda8c5ac9dd903a356c5de5b62477469133c89b2785eb7a14d" "4182c491b5cc235ba5f27d3c1804fc9f11f51bf56fb6d961f94788be034179ad" "5900bec889f57284356b8216a68580bfa6ece73a6767dfd60196e56d050619bc" "365d9553de0e0d658af60cff7b8f891ca185a2d7ba3fc6d29aadba69f5194c7f" "b81bfd85aed18e4341dbf4d461ed42d75ec78820a60ce86730fc17fc949389b2" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "ad9747dc51ca23d1c1382fa9bd5d76e958a5bfe179784989a6a666fe801aadf2" "8288b9b453cdd2398339a9fd0cec94105bc5ca79b86695bd7bf0381b1fbe8147" "d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "86c1c3872d471c399c753855479b33fdf19d427a6bcb1d3b3dee38a6d84f63a0" default)))
 '(flycheck-c/c++-gcc-executable nil)
 '(org-agenda-files
   (quote
    ("~/Dropbox/University-Documents/2017-2018/Ruby/Assignment2/writeup.org" "~/Dropbox/University Documents/2017-2018/Ruby/Assignment1/writeup/writeup.org" "~/org")))
 '(org-directory "~/.emacs.d/org/daily")
 '(package-selected-packages
   (quote
    (ox-twbs csv-mode csv-nav ein ipython dracula-theme sass-mode haml-mode web-mode scss-mode org-ref neotree helm-swoop smartparens smyx-theme blackboard-theme sublime-themes htmlize edit-server-htmlize excorporate flycheck-clangcheck zone-rainbow magit puml-mode flycheck-pyflakes py-autopep8 jedi company-jedi company-ycm company-web company-auctex company-arduino auctex markdown-mode golden-ratio alect-themes nyan-mode elpy)))
 '(python-check-command "flake8")
 '(python-shell-interpreter "python"))

;;Helm SETUP;;
;;-------------------------------------------
(require 'helm)
(require 'helm-config)
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

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
(global-set-key (kbd "C-b") 'helm-buffers-list)
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
;; IF ON A NEWER OS WILL USE PYTHON RATHER THAN PYTHON3 FOR THIS
(elpy-enable)
;;(setq elpy-rpc-backend "jedi")
(setq python-shell-completion-native-enable nil)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-python-command "python")
(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)                 ; optional
(setq elpy-rpc-python-command "python")
;;Use jedi as the backend for company
(setq flycheck-python-pylint-executable "pylint")
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi)
  (setq flycheck-checker 'python-pylint))

(add-hook 'python-mode-hook 'my/python-mode-hook)
(with-eval-after-load 'elpy
  (remove-hook 'elpy-modules 'elpy-module-flymake))

;; Nice indent keybinds
(define-key elpy-mode-map (kbd "C-c C-l") 'elpy-nav-indent-shift-left)
(define-key elpy-mode-map (kbd "C-c C-r") 'elpy-nav-indent-shift-right)


;; Line mode
(require 'telephone-line)
(telephone-line-mode 1)

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



;; Setup for webpage
(setq org-publish-project-alist
      `(("Dissertation"
         :base-directory "~/Dropbox/Website/"
         :recursive t
	 :auto-sitemap t
	 :sitemap-sort-files anti-chronologically	
	 :with-toc nil
	 :html-head-extra "<link rel=\"stylesheet\" href=\"./mycss.css\"/>"
         :publishing-directory "/ssh:nah26@central.aber.ac.uk:~/public_html"
         :publishing-function org-html-publish-to-html
	 )
	("images"
	 :base-directory "~/Dropbox/Website/images"
	 :base-extension "png\\|gif"
	 :publishing-directory "/ssh:nah26@central.aber.ac.uk:~/public_html/images"
	 :publishing-function org-publish-attachment
     )
	("DissertationWebsite" :components("Dissertation images"))
   )
) 


;; Window manager settings
;;(set-frame-parameter nil 'fullscreen 'fullboth)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

