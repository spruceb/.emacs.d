;; Bootstrap literate configuration
;;
;; Spruce Bondera
;;
;; This file ensures the bare minimum is set up to load the
;; configuration system from various org files

;; Fail when running on sufficiently outdated Emacs
;; TODO: separate out config into portions that will work on older
;; versions
(when (version< emacs-version "24")
  (unless (yes-or-no-p "This Emacs is old, config probably won't work. Kill? ")
    (kill-emacs)))

;; Set up package management and ensure org is up to date
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives
        '(("gnu" . "https://elpa.gnu.org/packages/")
          ("melpa" . "https://melpa.org/packages/")
          ("org" . "http://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'org)
    (package-refresh-contents)
    (package-install 'org)))

;; Tangle code and load from an initial file
(setq spruce/bootstrap-org-file "configuration.org")
(setq spruce/bootstrap-org-path
      (expand-file-name
       (concat user-emacs-directory spruce/bootstrap-org-file)))
(org-babel-load-file spruce/bootstrap-org-path)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) %(file-line-error) %(extraopts) %S%(PDFout)"))))
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "926cf2e79abc7465cbe92759d0124c68e9c06d4147cc29217b229fe52f0411bd" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "d8f76414f8f2dcb045a37eb155bfaa2e1d17b6573ed43fb1d18b936febc7bbc2" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" default)))
 '(debug-on-error nil)
 '(global-font-lock-mode t)
 '(org-agenda-files (quote ("~/Documents/Classes/school-schedule.org")))
 '(org-bullets-bullet-list (quote ("●" "●" "○" "○" "○" "○" "○" "○" "○")))
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(org-fontify-whole-heading-line t)
 '(org-pretty-entities t)
 '(package-selected-packages
   (quote
    (htmlize paradox company-auctex auctex markdown-mode yasnippet w3m visible-mark use-package undo-tree transpose-frame spaceline spacegray-theme smartparens smart-mode-line-powerline-theme slime reveal-in-finder rainbow-mode pyvenv python-info pylint py-autopep8 persistent-scratch org-pandoc org-bullets multiple-cursors magit llvm-mode lispy julia-mode indent-guide highlight-indentation highlight-indent-guides helm-swoop helm-pydoc helm-projectile helm-flx helm-company helm-ag flycheck find-file-in-project fill-column-indicator emms dtrt-indent debbugs company-jedi column-marker color-theme buffer-move auto-complete aggressive-indent)))
 '(paradox-github-token t)
 '(safe-local-variable-values
   (quote
    ((eval setq byte-compile-not-obsolete-vars
           (quote
            (display-buffer-function))))))
 '(sml/line-number-format "  %3l ")
 '(tls-checktrust nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:weight bold :family "Source Code Pro"))))
 '(column-marker-1 ((t (:background "red"))))
 '(org-code ((t (:foreground "OrangeRed2" :weight ultra-light))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.1))))
 '(org-level-2 ((t (:inherit outline-2))))
 '(vertical-border ((((type mac tty) (class color)) (:inherit mode-line-inactive))))
 '(window-divider ((t (:foreground "dark gray")))))
