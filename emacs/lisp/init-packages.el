;;;; init-package.el --- -*- lexical-binding: t -*-

;;; requirements

(require 'init)
(require 'package)

;;; -- PACKAGE MANAGER CONFIGURATION -------------------------------------------

;;; package archives location

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
	("melpa"  . "https://melpa.org/packages/")
	("cselpa" . "https://elpa.thecybershadow.net/packages/")
	))

;;; initialize package list

(unless (bound-and-true-p package--initialized)
  (setq package-enable-at-startup false) ; to prevent initializing twice
  (package-initialize))

;; set use-package-verbose  to true  for interpreted  .emacs, and  false for
;; byte-compiled .emacs.elc.

(eval-and-compile
  (setq use-package-verbose (not (bound-and-true-p byte-compile-current-file))))

;;; install use-package if not installed

(unless (package-installed-p 'use-package) ; if `use-package' is not installed
  (package-refresh-contents)               ; refresh package repository cache
  (package-install 'use-package))          ; install `use-package'

(eval-and-compile
  (setq use-package-always-ensure        true)
  (setq use-package-expand-minimally     true)
  (setq use-package-compute-statistics   true) ; statistics about package initialization
  (setq use-package-enable-imenu-support true))

(eval-when-compile
  (require 'use-package)
  (require 'bind-key))

;;; install useful packages early on

(use-package auto-package-update
  :if (not (daemonp))
  :custom
  (auto-package-update-interval             1) ;; in days
  (auto-package-update-prompt-before-update true)
  (auto-package-update-delete-old-versions  true)
  (auto-package-update-hide-results         false)
  :config
  (auto-package-update-maybe))

(use-package diminish)

;; update the package list if empty
(when (not package-archive-contents)
  (package-refresh-contents)
)

(defvar packages
      '(
	gruvbox-theme
	telephone-line
	lsp-mode
	company
       )
)

;; install any packages in packages, if they are not installed already
(let ((refreshed false))
  (when (not package-archive-contents)
    (package-refresh-contents)
    (setq refreshed true)
  )

  (dolist (pkg packages)
    (when
	(and
	   (not (package-installed-p pkg))
	   (assoc pkg package-archive-contents)
	)
      (unless refreshed
	(package-refresh-contents)
	(setq refreshed true)
      )
      (package-install pkg)
    )
  )
)


;; package loading

(require 'telephone-line)
(require 'lsp-mode)
(require 'company)

(lsp-mode t)
(company-mode t)
(telephone-line-mode t)

(provide 'init-packages)
