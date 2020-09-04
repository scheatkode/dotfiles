(require 'init)
(require 'init-constants)
(require 'init-packages)

(use-package term-keys
  :if (not (display-graphic-p))
  :config (term-keys-mode true)

