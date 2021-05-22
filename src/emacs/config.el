;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name    "scheatkode"
      user-mail-address "scheatkode@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "Dyosevka" :size 14 :weight 'semi-light)
(setq doom-font "Dyosevka-14:weight=demibold"
      doom-big-font "Dyosevka-18:weight=demibold")
      ;; doom-variable-pitch-font (font-spec :family "Overpass" :size 14))
(setq doom-unicode-font doom-font)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/brain/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Determines the style used by `doom-modeline-buffer-file-name'.
;;
;; Given ~/Projects/FOSS/emacs/lisp/comint.el
;;   auto => emacs/lisp/comint.el (in a project) or comint.el
;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
;;   truncate-with-project => emacs/l/comint.el
;;   truncate-except-project => ~/P/F/emacs/l/comint.el
;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
;;   truncate-all => ~/P/F/e/l/comint.el
;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
;;   relative-from-project => emacs/lisp/comint.el
;;   relative-to-project => lisp/comint.el
;;   file-name => comint.el
;;   buffer-name => comint.el<2> (uniquify buffer name)
;;
;; If you are experiencing the laggy issue, especially while editing remote files
;; with tramp, please try `file-name' style.
;; Please refer to https://github.com/bbatsov/projectile/issues/657.
(setq doom-modeline-buffer-file-name-style 'truncate-except-project)

;; Splash image
(setq fancy-splash-image (expand-file-name "splash.png" doom-private-dir))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Place your custom functions here.

(defun my/join-path (root &rest dirs)
  "Join a series of directories together to return a full path."
  (if (not dirs)
      root
    (apply 'my/join-path
           (expand-file-name (car dirs) root)
           (cdr dirs))))

;; (defun my/org-inline-image--get-current-image ()
;;   "Return the overlay associated with the image under point."
;;   (car (--select
;;         (eq (overlay-get it 'org-image-overlay) t) (overlays-at (point)))))

;; (defun my/org-inline-image--get (prop)
;;   "Return the value of property `PROP' for image under point."
;;   (let ((image (my/org-inline-image--get-current-image)))
;;     (when image
;;       (overlay-get image prop))))

;; (defun my/org-inline-image-animate ()
;;   "Animate the image if possible."
;;   (interactive)
;;   (let ((image-props (my/org-inline-image--get 'display)))
;;     (when (image-multi-frame-p image-props)
;;       (image-animate image-props))))

;; (defun my/org-inline-image-animate-auto ()
;;   (interactive)
;;   (when (eq 'org-mode major-mode)
;;     (while-no-input
;;       (run-with-idle-timer 0.3 nil 'my/org-inline-image-animate))))

;;;; Modeline
;; When a buffer is modified, `red' text  is used by default in the `modeline'
;; to reflect the modification, change that to `orange'.
(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))

;; The default file encoding  is `LF UTF-8' and thus, not  worth noting in the
;; modeline.
(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be `LF UTF-8', so only show the
  modeline when this is not the case."
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

;; Redefining `;' key to trigger evil commands since it's not used anyway.
(map!
 :nv ";" 'evil-ex)

;; Configure Which-key
(use-package! which-key
  :init
  (setq which-key-idle-delay 0.5))         ; I need the help, I really do

;; I no longer use Deft because it messes up my buffer/project setup.
;; ;; Deft → Notational velocity for Org mode.
;; (after! deft
;;   (setq deft-directory          "~/org/notes"
;;         deft-recursive                      t
;;         deft-use-filename-as-title          t
;;         deft-use-filter-string-for-filename t
;;         deft-file-naming-rules
;;         '((noslash . "-")
;;           (nospace . "-")
;;           (case-fn . downcase))))

;; Map `C-SPC' to mark the current candidate for multiple actions.
(use-package! ivy
  :init
  (defun ivy--toggle-mark ()
    "Toggle mark for current candidate and move forwards."
    (interactive)
    (if (ivy--marked-p)
        (ivy-unmark)
      (ivy-mark)))
  :bind
  (:map ivy-minibuffer-map
   ("C-SPC" . ivy--toggle-mark)))

;; Setup Pinentry  server for  GPG authentication  and encryption  from inside
;; Emacs.
(use-package! pinentry
  :config
  (setenv "INSIDE_EMACS" emacs-version)

  (defun gpg-update-tty (&rest _args)
    (shell-command
     "gpg-connect-agent updatestartuptty /bye"
     " *gpg-update-tty*"))

  (with-eval-after-load 'magit
    (advice-add 'magit-start-git :before 'gpg-update-tty)
    (advice-add 'magit-call-git  :before 'gpg-update-tty)))
(use-package! epg
  :after pinentry

  :preface
  (declare-function pinentry-start nil)

  :init
  (setq epg-pinentry-mode      'loopback
        epg-gpg-home-directory "~/identities/gpg")

  :config
  (pinentry-start))

;; Configuration for very large files.
;; (use-package! vlf-setup
;;   :defer-incrementally
;;   vlf-tune
;;   vlf-base
;;   vlf-write
;;   vlf-search
;;   vlf-occur
;;   vlf-follow
;;   vlf-ediff
;;   vlf)

;; Configuration for Org-mode
(use-package! org
  ;; :defer-incrementally color

  ;; Configure font attributes for Org-mode
  ;; (set-face-attribute 'org-block nil :background
  ;;                     (color-lighten-name
  ;;                     (face-attribute 'default :background) 5))
  ;; (set-face-attribute 'org-block            nil :extend t)
  ;; (set-face-attribute 'org-block-begin-line nil :extend t)
  ;; (set-face-attribute 'org-block-end-line   nil :extend t)

  ;; ;; Setup LaTeX preview in Org-mode
  ;; (setq org-latex-packages-alist 'nil)
  ;; (setq org-latex-default-packages-alist
  ;;       '(("AUTO" "inputenc"  t ("pdflatex"))
  ;;         ("T1"   "fontenc"   t ("pdflatex"))
  ;;         (""     "graphicx"  t)
  ;;         (""     "grffile"   t)
  ;;         (""     "minted"   t)
  ;;         (""     "longtable" nil)
  ;;         (""     "wrapfig"   nil)
  ;;         (""     "rotating"  nil)
  ;;         ("normalem" "ulem"  t)
  ;;         (""     "amsmath"   t)
  ;;         (""     "amssymb"   t)
  ;;         (""     "unicode-math"   t)
  ;;         (""     "mathtools"   t)
  ;;         (""     "textcomp"  t)
  ;;         (""     "capt-of"   nil)
  ;;         (""     "hyperref"  nil)))
  ;; (plist-put org-format-latex-options :scale 1.6)
  ;; (add-to-list
  ;;  'org-preview-latex-process-alist
  ;;  '(dvixelatex :programs ("xetex" "convert")
  ;;               :description "pdf > png"
  ;;               :message "you need to install the programs: xetex and imagemagick."
  ;;               :image-input-type "pdf"
  ;;               :image-output-type "png"
  ;;               :image-size-adjust (1.0 . 1.0)
  ;;               :latex-compiler
  ;;               ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
  ;;               :image-converter
  ;;               ("dvisvgm %f -n -b min -c %S -o %O")))

  ;; (add-to-list
  ;;  'org-preview-latex-process-alist
  ;;  '(imagexetex :programs ("xelatex" "convert")
  ;;               :description "pdf > png"
  ;;               :message "you need to install the programs: xelatex and imagemagick."
  ;;               :image-input-type "pdf"
  ;;               :image-output-type "png"
  ;;               :image-size-adjust (1.0 . 1.0)
  ;;               :latex-compiler
  ;;               ("xelatex -interaction nonstopmode -output-directory %o %f")
  ;;               :image-converter
  ;;               ("convert -density %D -trim -antialias %f -quality 100 %O")))
  ;; (setq org-preview-latex-default-process 'imagexetex)
  ;; (setq org-startup-with-inline-images    'nil)
  ;; (setq org-image-actual-width             500)
  :config
  (progn
    ;; (defun my/org-log-todo-creation-time (&rest)
    ;;   "Log TODO creation time in the property drawer under the key 'CREATED'."
    ;;   (when (and (org-entry-is-todo-p)
    ;;              (not (org-entry-get nil "CREATED")))
    ;;     (org-entry-put nil "CREATED"
    ;;                    (format-time-string
    ;;                     (car org-time-stamp-inactive-formats)))))

    ;; (defun my/org-log-todo-close-time (&rest)
    ;;   "Log TODO close time in the property drawer under the key 'CLOSED'."
    ;;   (when (and (org-entry-is-done-p)
    ;;              (not (org-entry-get nil "CLOSED")))
    ;;     (org-entry-put nil "CLOSED"
    ;;                    (format-time-string
    ;;                     (car org-time-stamp-inactive-formats)))))

    (defun my/org-agenda-skip-function (part)
      "Partitions things to decide if they should go into the
      agenda '(agenda future-scheduled done)"
      (let* ((skip (save-excursion (org-entry-end-position)))
             (dont-skip nil)
             (scheduled-time (org-get-scheduled-time (point)))
             (deadline-time  (org-get-deadline-time  (point)))
             (result
              (or (and (org-entry-is-done-p) ; This entry is done and
                       'done)                ; should probably be
                                             ; ignored.
                  scheduled-time
                  deadline-time
                  'agenda)))            ; Everything else should go in the
                                        ; agenda.
        (if (eq result part) dont-skip skip)))

    ;; (defun my/org-log-capture-creation-time ()
    ;;   "Log capture creation time in the property drawer of newly
    ;;   created capture."
    ;;   (interactive)
    ;;   (org-set-property "CREATED" (format-time-string
    ;;                                (car org-time-stamp-inactive-formats))))

    ;; (defun my/org-capture-insert-creation-date (&rest ignore)
    ;;   (insert (format-time-string
    ;;            (concat "\nCREATED: "
    ;;                    (cdr org-time-stamp-formats))))
    ;;   (org-back-to-heading)             ; in org-capture, folds the entry; when inserting a heading, moves point back to the heading line
    ;;   (move-end-of-line()))             ; when inserting a heading, this moves point to the end of the line

    (defvar my/org-agenda-directory (my/join-path org-directory "agenda")
      "Name of the directory under the default org one that will
      host the agenda files")

    (setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . 955)
                                           ("#+END_SRC"   . 955)
                                           ("#+begin_src" . 955)
                                           ("#+end_src"   . 955)))
    (setq prettify-symbols-unprettify-at-point 'right-edge)
    (add-hook 'org-mode-hook 'prettify-symbols-mode)

    (unless (string-match-p "\\.gpg" org-agenda-file-regexp)
      (setq
       org-agenda-file-regexp (replace-regexp-in-string
                               "\\\\\\.org"
                               "\\\\.org\\\\(\\\\.gpg\\\\)?"
                               org-agenda-file-regexp)))

    (setq
     ;; Org agenda configuration
     org-agenda-files (directory-files-recursively "~/brain/agenda" "\\.org\\(\\.gpg\\)?$")
     org-agenda-skip-archived-trees                   t
     org-agenda-skip-timestamp-if-done                t
     org-agenda-skip-additional-timestamps-same-entry t
     ;; Org capture configuration
     +org-capture-todo-file     (my/join-path my/org-agenda-directory "todo.org")
     +org-capture-notes-file    (my/join-path my/org-agenda-directory "notes.org")
     +org-capture-projects-file (my/join-path my/org-agenda-directory "projects.org")
     org-log-done              'time
     org-log-into-drawer       t
     org-tags-column           -78
     org-auto-align-tags       t
     org-cycle-emulate-tab     'white

     org-todo-keywords '((sequence
                          "TODO(T)"
                          "NEXT(N!)"
                          "PROJ(P@/!)"
                          "STRT(S@/!)"
                          "WAIT(W@/!)"
                          "HOLD(H@/!)"
                          "|"
                          "DONE(D@/!)"
                          "KILL(K@/!)")
                         (sequence
                          "[ ](t)"
                          "[>](n!)"
                          "[-](s@/!)"
                          "[?](w@/!)"
                          "|"
                          "[X](d@/!)"
                          "[C](k!)"))

     org-time-stamp-inactive-formats '("[%Y-%m-%d %a]" . "[%Y-%m-%d %a %H:%M]")

     org-hide-emphasis-markers t
     org-hide-leading-stars    nil
     org-fontify-done-headline t
     org-pretty-entities       t

     org-src-fontify-natively  t
     org-return-follows-link   t
     org-export-in-background  t
     ;; org-indent-indentation-per-level 2 ; indentation to add per level
     org-startup-indented      nil
     org-adapt-indentation     t

     ;; my/org-inline-image--get-current-image
     ;; (byte-compile
     ;;  'my/org-inline-image--get-current-image)
     ;; my/org-inline-image-animate
     ;; (byte-compile
     ;;  'my/org-inline-image-animate))

    ;; (advice-add 'org-insert-todo-heading
    ;;             :after #'my/org-log-todo-creation-time)
    ;; (advice-add 'org-insert-todo-heading-respect-content
    ;;             :after #'my/org-log-todo-creation-time)
    ;; (advice-add 'org-insert-todo-subheading
    ;;             :after #'my/org-log-todo-creation-time)

    ;; (add-hook 'org-after-todo-state-change-hook
    ;;           #'my/org-log-todo-creation-time)
    ;; (add-hook 'org-after-todo-state-change-hook
    ;;           #'my/org-log-todo-close-time)
    ;; (add-hook 'org-capture-before-finalize-hook
    ;;           #'my/org-log-capture-creation-time)

    ;; (add-hook 'post-command-hook 'my/org-inline-image-animate-auto)

    ;; (add-hook 'org-capture-before-finalize-hook ; Add to org-capture hook
    ;;           #'my/org-capture-insert-creation-date)

    ;; (advice-add 'org-insert-todo-heading
    ;;             :after #'my/org-capture-insert-creation-date)

    ;; (add-hook 'org-mode-hook
    ;;           (lambda ()
    ;;             (variable-pitch-mode 1)
    ;;             visual-line-mode)))
    )))

;; Prettify Org-mode
(after! org
  ;; Configure font attributes for Org-mode
  ;; (set-face-attribute 'org-block nil :background
  ;;                     (color-lighten-name
  ;;                      (face-attribute 'default :background) 5))
  (set-face-attribute 'org-block            nil :extend t)
  (set-face-attribute 'org-block-begin-line nil :extend t)
  (set-face-attribute 'org-block-end-line   nil :extend t)
  ;; (set-face-attribute 'org-level-1 nil :background
  ;;                     (color-darken-name
  ;;                      (face-attribute 'default :background) 3))
  ;; (set-face-attribute 'org-level-2 nil :background
  ;;                     (color-darken-name
                       ;; (face-attribute 'default :background) 2))
  ;; (set-face-attribute 'org-level-3 nil :background
  ;;                     (color-darken-name
  ;;                      (face-attribute 'default :background) 1))

  ;; Setup LaTeX preview in Org-mode
  ;; (setq org-latex-packages-alist 'nil)
  ;; (setq org-latex-default-packages-alist
  ;;       '(("AUTO" "inputenc"  t ("pdflatex"))
  ;;         ("T1"   "fontenc"   t ("pdflatex"))
  ;;         (""     "graphicx"  t)
  ;;         (""     "grffile"   t)
  ;;         (""     "minted"   t)
  ;;         (""     "longtable" nil)
  ;;         (""     "wrapfig"   nil)
  ;;         (""     "rotating"  nil)
  ;;         ("normalem" "ulem"  t)
  ;;         (""     "amsmath"   t)
  ;;         (""     "amssymb"   t)
  ;;         (""     "unicode-math"   t)
  ;;         (""     "mathtools"   t)
  ;;         (""     "textcomp"  t)
  ;;         (""     "capt-of"   nil)
  ;;         (""     "hyperref"  nil)))
  (plist-put org-format-latex-options :scale 1.6)
  ;; (add-to-list
  ;;  'org-preview-latex-process-alist
  ;;  '(dvixelatex :programs ("xetex" "convert")
  ;;               :description "pdf > png"
  ;;               :message "you need to install the programs: xetex and imagemagick."
  ;;               :image-input-type "pdf"
  ;;               :image-output-type "png"
  ;;               :image-size-adjust (1.0 . 1.0)
  ;;               :latex-compiler
  ;;               ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
  ;;               :image-converter
  ;;               ("dvisvgm %f -n -b min -c %S -o %O")))

  ;; (add-to-list
  ;;  'org-preview-latex-process-alist
  ;;  '(imagexetex :programs ("xelatex" "convert")
  ;;               :description "pdf > png"
  ;;               :message "you need to install the programs: xelatex and imagemagick."
  ;;               :image-input-type "pdf"
  ;;               :image-output-type "png"
  ;;               :image-size-adjust (1.0 . 1.0)
  ;;               :latex-compiler
  ;;               ("xelatex -interaction nonstopmode -output-directory %o %f")
  ;;               :image-converter
  ;;               ("convert -density %D -trim -antialias %f -quality 100 %O")))
  ;; (setq org-preview-latex-default-process 'imagexetex)
  (setq org-startup-with-inline-images    'nil)
  (setq org-image-actual-width             500))

;; Org super agenda
(use-package! org-super-agenda
  :after org-agenda
  ;; :commands (org-super-agenda-mode)
  :init
  (setq org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-span 1
        org-agenda-start-day nil        ; today
        org-agenda-start-on-weekday nil
        org-agenda-start-with-clockreport-mode t
        ;; org-agenda-start-with-entry-text-mode t
        org-agenda-start-with-follow-mode nil
        org-agenda-start-with-log-mode '(closed clock state))
  (setq
   org-super-agenda-header-map (make-sparse-keymap)
   org-agenda-custom-commands
        '(("n" "Super Agenda"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name      "Today"
                            :time-grid t
                            :date      today
                            :todo      "TODAY"
                            :scheduled today
                            :order     1)
                           (:discard (:anything t))))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "Next-up"
                             :todo ("NEXT" "[>]")
                             :order 1)
                            (:name "Due today"
                             :deadline today
                             :order 2)
                            (:name "Due soon"
                             :deadline future
                             :order 8)
                            (:name "Issues"
                             :tag "issue"
                             :order 10)
                            (:name "Projects"
                             :category "project"
                             :todo ("PROJ")
                             :children t
                             ;; :tag "project"
                             :order 14)
                            (:name "Waiting"
                             :todo "WAIT"
                             :order 20)
                            (:name "Quick Picks"
                             :effort< "1:00"
                             :priority<= "C"
                             :tag "someday"
                             :order 90)
                            (:name "Overdue"
                             :deadline past
                             :face error
                             :order 3)))))))))
  :config
  (org-super-agenda-mode))

;; (after! org-agenda
;;   (org-super-agenda-mode))

;; LSP support in `src' blocks
;; (cl-defmacro lsp-org-babel-enable(lang)
;;   "Support LANG in org source code block."
;;   (setq centaur-lsp 'lsp-mode)
;;   (cl-check-type lang stringp)
;;   (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
;;          (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
;;     `(progn
;;        (defun ,intern-pre (info)
;;          (let ((file-name (->> info caddr (alist-get :file))))
;;            (unless file-name
;;              (setq file-name (make-temp-file "babel-lsp-")))
;;            (setq buffer-file-name file-name)
;;            (lsp-deferred)))
;;        (put ',intern-pre 'function-documentation
;;             (format "enable lsp-mode in the buffer of org source block (%s)."
;;                     (upcase ,lang)))
;;        (if (fboundp ',edit-pre)
;;            (advice-add ',edit-pre :after ',intern-pre)
;;          (progn
;;            (defun ,edit-pre (info)
;;              (,intern-pre info))
;;            (put ',edit-pre 'function-documentation
;;                 (format "Prepare local buffer environment for org source block (%s)."
;;                         (upcase ,lang))))))))
;; (defvar org-babel-lang-list
;;   '("go" "python" "ipython" "bash" "sh"))
;; (dolist (lang org-babel-lang-list)
;;   (eval `(lsp-org-babel-enable ,lang)))

