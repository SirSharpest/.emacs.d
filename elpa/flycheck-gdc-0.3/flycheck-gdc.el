;;; flycheck-gdc.el --- A flycheck handler for d-mode files using a non-proprietary compiler.
;; Copyright (C) 2015 Koz Ross

;; Author: Koz Ross <koz.ross@runbox.com>
;; Maintainer: Koz Ross <koz.ross@runbox.com>
;; URL: https://notabug.org/koz.ross/flycheck-gdc
;; Created: 27th July 2015
;; Version: 0.3
;; Keywords: flycheck, d-mode, d, gdc
;; Package-Requires: ((flycheck "0.23"))
;; Commentary:
;;
;; Activate this with:
;; (require 'flycheck) ;if you don't already have it
;; (require 'flycheck-gdc)

;; Copyright (C) 2015  Koz Ross

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'flycheck)

(flycheck-def-option-var flycheck-gdc-definitions nil d-gdc
  "Additional preprocessor definitions for GDC.
The value of this variable is a list of strings, where each
string is an additional definition to pass to GDC, via the `-D'
option."
  :type '(repeat (string :tag "Definition"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-gdc-include-path nil d-gdc
  "A list of include directories for GDC.
The value of this variable is a list of strings, where each
string is a directory to add to the include path of gdc.
Relative paths are relative to the file being checked."
  :type '(repeat (directory :tag "Include directory"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-gdc-string-include-path nil d-gdc
  "A list of include directories for GDC string includes.
The value of this variable is a list of strings, where each string is a directory to add to the string include path of gdc. Relative paths are relative to the file being checked."
  :type '(repeat (directory :tag "String include directory"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-gdc-includes nil d-gdc
  "A list of additional include files for GDC.
The value of this variable is a list of strings, where each
string is a file to include before syntax checking. Relative
paths are relative to the file being checked."
  :type '(repeat (file :tag "Include file"))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-gdc-warnings '("all") d-gdc
  "A list of additional warnings to enable in GDC.
The value of this variable is a list of strings, where each string
is the name of a warning category to enable. By default, all
recommended warnings are enabled (as by `-Wall').

Refer to the GDC wiki at URL `http://wiki.dlang.org/GDC/Using_GDC' for more information about warnings."
  :type '(choice (const :tag "No additional warnings" nil)
                 (repeat :tag "Additional warnings"
                         (string :tag "Warning name")))
  :safe #'flycheck-string-list-p
  :package-version '(flycheck . "0.20"))

(flycheck-def-option-var flycheck-gdc-unittests nil d-gdc
  "Whether to generate code for unit tests in the source code.

When non-nil, include unit test code in checking, via `-funittest'."
  :type 'boolean
  :safe #'booleanp
  :package-version '(flycheck . "0.20"))

(flycheck-define-checker d-gdc
  "A D syntax checker using the GDC compiler. Requires GDC 4.9.1 or newer."
  :command ("gdc"
            "-fshow-column"
            "-fno-diagnostics-show-caret" ; Do not visually indicate the source location
            "-fno-diagnostics-show-option" ; Do not show the corresponding
                                        ; warning group
            (option-flag "-funittest" flycheck-gdc-unittests)
            (option-list "-include" flycheck-gdc-includes)
            (option-list "-W" flycheck-gdc-warnings concat)
            (option-list "-D" flycheck-gdc-definitions concat)
            (option-list "-I" flycheck-gdc-include-path)
            (option-list "-J" flycheck-gdc-string-include-path)
            source
            ;; GDC performs full checking only when actually compiling, so
            ;; `-fsyntax-only' is not enough. Just let it generate assembly
            ;; code.
            "-S" "-o" null-device)
  :error-patterns
  ((error line-start
          (message "In file included from") " " (file-name) ":" line ":"
          column ":"
          line-end)
   (info line-start (file-name) ":" line ":" column
         ": note: " (message) line-end)
   (warning line-start (file-name) ":" line ":" column
            ": warning: " (message) line-end)
   (error line-start (file-name) ":" line ":" column
          ": " (or "fatal error" "error") ": " (message) line-end))
  :error-filter
  (lambda (errors)
    (flycheck-fold-include-levels (flycheck-sanitize-errors errors)
                                  "In file included from"))
  :modes (d-mode))

(add-to-list 'flycheck-checkers 'd-gdc)

(provide 'flycheck-gdc)
;;; flycheck-gdc.el ends here
