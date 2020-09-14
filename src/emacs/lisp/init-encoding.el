;;;; init-encoding.el --- -*- lexical-binding: t -*-

;;; defining utf-8 as the universal default encoding

;; use utf-8 as much as possible with unix line endings

(unless *sys/win32*
  (prefer-coding-system        'utf-8)
  (set-selection-coding-system 'utf-8)
  (set-language-environment    "UTF-8")
  (set-default-coding-systems  'utf-8)
  (set-terminal-coding-system  'utf-8)
  (set-keyboard-coding-system  'utf-8)
  (setq locale-coding-system   'utf-8))

;; treat clipboard input as a utf-8 string first, compound text next, etc.

(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(provide 'init-encoding)
