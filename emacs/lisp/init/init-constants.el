;;;; init-constants.el --- -*- lexical-binding: t -*-

;;; requirements

(require 'init)

;;; user identification

(setq user-full-name    "chaoticmurder")
(setq user-mail-address "chaoticmurder.git@gmail.com")

;;; explicit true/false variable naming

(defconst true  t   "Explicit form of true value")
(defconst false nil "Explicit form of false value")

(defconst better-gc-cons-threshold 1000000)

;;; system identification

(defconst *sys/win32* (eq system-type 'windows-nt) "True if running on a Winblows system.")
(defconst *sys/linux* (eq system-type 'gnu/linux)  "True if running on a GNU/Linux system.")
(defconst *sys/mac*   (eq system-type 'darwin)     "True if running on a Mac system.")

;;; environment detection

(defconst python-p
  (or (executable-find "python3")
      (and (executable-find "python")
	   (> (length (shell-command-to-string "python --version | grep 'Python 3'")) 0)))
  "True if python3 is available.")

(defconst pip-p
  (or (executable-find "pip3")
      (and (executable-find "pip")
	   (> (length (shell-command-to-string ("pip --version | grep 'python 3'")) 0))))
  "True if pip3 is available.")

(defconst clandg-p
  (or (executable-find "clangd")                          ; usually
      (executable-find "/usr/local/opt/llvm/bin/clangd")) ; macos
  "True if clangd is available.")

(defconst eaf-env-p
  (and *sys/linux* (display-graphic-p) python-p pip-p
       (not (equal (shell-command-to-string "pip freeze | grep '^PyQt\\|PyQtWebEngine'") "")))
  "True if EAF environment is set up.")


(provide 'init-constants)
