;;;; package-evil.el --- -*- lexical-binding: t -*-

(require 'init)
(require 'init-constants)
(require 'init-packages)

(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
	(setq evil-want-C-u-delete t)
  :config
  (evil-define-key 'normal 'global ";" 'evil-ex)
  (evil-define-key 'visual 'global ";" 'evil-ex)
  (evil-mode t))

(provide 'package-evil)
