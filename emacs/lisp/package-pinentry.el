;;;; package-pinentry.el --- -*- lexical-binding: t -*-

(require 'init)
(require 'init-constants)
(require 'init-packages)

(use-package pinentry
  :config
  (setenv "INSIDE_EMACS" emacs-version)

  (defun gpg-update-tty (&rest _args)
    (shell-command
     "gpg-connect-agent updatestartuptty /bye"
     " *gpg-update-tty*"))

  (with-eval-after-load 'magit
    (advice-add 'magit-start-git :before 'gpg-update-tty)
    (advice-add 'magit-call-git  :before 'gpg-update-tty)))


(use-package epa
  :after pinentry

  :preface
  (eval-when-compile
    (defvar epa-pinentry-mode))

  :init
  (setq epa-pinentry-mode 'loopback))


(use-package epg
  :after epa

  :preface
  (declare-function pinentry-start nil)

  :config
  (pinentry-start))

(provide 'package-pinentry)
