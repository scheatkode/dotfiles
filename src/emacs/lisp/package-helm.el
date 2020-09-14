
(require 'init)
(require 'init-constants)
(require 'init-packages)

(use-package helm
  :defer 1
  :diminish helm-mode
  :bind
  (("C-x C-f"       . helm-find-files)
   ("C-x C-b"       . helm-buffers-list)
   ("C-x b"         . helm-multi-files)
   ("M-x"           . helm-M-x)
   :map helm-find-files-map
   ("C-<backspace>" . helm-find-files-up-one-level)
   ("C-f"           . helm-execute-persistent-action)
   ([tab]           . helm-ff-RET))
  :config
  (defun daedreth/helm-hide-minibuffer ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face
                     (let ((bg-color (face-background 'default nil)))
                       `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))
  (add-hook 'helm-minibuffer-set-up-hook 'daedreth/helm-hide-minibuffer)
  (setq helm-autoresize-max-height 0
	helm-autoresize-min-height 40
	helm-M-x-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-split-window-in-side-p nil
	helm-move-to-line-cycle-in-source nil
	helm-ff-search-library-in-sexp t
	helm-scroll-amount 8
	helm-echo-input-in-header-line nil
	;; completion-styles '(helm-flex)
	)
  :init
  (helm-mode 1))

(use-package helm-posframe
  :after  helm
  :demand t
  :if (and (window-system) (version<= "26.1" emacs-version))
  :config (setq helm-posframe-poshandler 'posframe-poshandler-frame-center
		;; helm-posframe-height 20
		;; helm-posframe-width (round (* (window-width) 0.49))
		helm-posframe-parameters '((internal-border-width . 10)))
  (helm-posframe-enable))

(require 'helm-config)
(helm-autoresize-mode 1)

(provide 'package-helm)
