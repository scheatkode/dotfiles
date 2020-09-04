;;;; early-init.el --- -*- lexical-binding: t -*-


;;; lexical binding

;;   until  emacs  24.1 (june  2012),  elisp  only had  dynamically  scoped
;;   variables, a feature, mostly by accident, common to old lisp dialects.
;;   while dynamic scope has some selective uses, it’s widely regarded as a
;;   mistake for  local variables,  and virtually  no other  languages have
;;   adopted it.

;;   → (https://nullprogram.com/blog/2016/12/22/)


;;; garbage collection deferring

;;   the garbage  collector eats up  quite a  bit of time,  easily doubling
;;   startup time. the trick is to turn up the memory threshold as early as
;;   possible.

(setq gc-cons-threshold 100000000)


;;; disable package initialization

;;   package  initialize  occurs  automatically, before  user-init-file  is
;;   loaded, but after early-init-file.   we handle package initialization,
;;   so we must prevent emacs from doing it early!

(setq package-enable-at-startup nil)


;;; unset file handler list

;;   every file  opened and loaded by  emacs will run through  this list to
;;   check for a proper handler for  the file, but during startup, it won’t
;;   need any of them.

(defvar file-name-handler-alist-original file-name-handler-alist
  "file-name-handler-alist backup")
(setq   file-name-handler-alist          nil)


;;; disable unnecessary ui

;;   it  will  be   faster  to  disable  them  here   before  they've  been
;;   initialized.

(menu-bar-mode -1) ; disable the menu bar

(unless (and (display-graphic-p) (eq system-type 'darwin))
  (push '(menu-bar-lines . 0) default-frame-alist))

(push '(tool-bar-lines . 0)   default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)


;;; early init

;; provide the early init object.

(provide 'early-init)
