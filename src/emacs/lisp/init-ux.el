;;;; init-ux.el --- -*- lexical-binding: t -*-

(defalias 'yes-or-no-p 'y-or-n-p)

(setq confirm-kill-emacs 'y-or-n-p)	; ask before killing emacs
(setq echo-keystrokes 0.1)		; instantly show keystrokes in progress


;; turn off annoying ui elements

(menu-bar-mode -1) ; remove menu bar
(tool-bar-mode  0) ; remove title bar

(setq make-backup-files false) ; stop creating backup~ files
(setq auto-save-default false) ; stop creating #autosave# files


;; vertical scroll

(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll     false)
(setq fast-but-imprecise-scrolling false)

;; horizontal scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

(provide 'init-ux)
