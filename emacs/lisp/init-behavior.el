;;;; init-behavior.el --- -*- lexical-binding: t -*-

(require 'init)
(require 'init-constants)


;;;; -- VERSION CHECK & EARLY INIT ---------------------------------------------

(cond ((version< emacs-version "26.1")
       (warn "Emacs 26.1 or above is recommended !"))
      ((let* ((early-init-f             (expand-file-name "early-init.el"           user-emacs-directory))
	      (early-init-do-not-edit-d (expand-file-name "early-init-do-not-edit/" user-emacs-directory))
	      (early-init-do-not-edit-f (expand-file-name "early-init.el"           early-init-do-not-edit-d)))
	 (and (version< emacs-version "27")
	      (or (not (file-exists-p early-init-do-not-edit-f))
		  (file-newer-than-file-p early-init-f early-init-do-not-edit-f)))
	 (make-directory early-init-do-not-edit-d t)
	 (copy-file early-init-f early-init-do-not-edit-f t t t t)
	 (add-to-list 'load-path early-init-do-not-edit-d)
	 (require 'early-init))))


;;;; -- GARBAGE COLLECTION -----------------------------------------------------

;; garbage collection on startup

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold       better-gc-cons-threshold)
	    (setq file-name-handler-alist file-name-handler-alist-original)
	    (makunbound 'file-name-handler-alist-original)))

;; garbage collect when  emacs is out of focus and  avoid garbage collection
;; when using minibuffer.

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (if (boundp 'after-focus-change-function)
			(lambda ()
			  (unless (frame-focus-state)
			    (garbage-collect)))
		(add-hook 'after-focus-change-function 'garbage-collect))
	    (defun gc-minibuffer-setup-hook ()
	      (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

	    (defun gc-minibuffer-exit-hook ()
	      (garbage-collect)
	      (setq gc-cons-threshold better-gc-cons-threshold))

	    (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
	    (add-hook 'minibuffer-exit-hook  #'gc-minibuffer-exit-hook)))


(provide 'init-behavior)

;;;; init-behavior.el --- -*- lexical-binding: t -*-
