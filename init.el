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
(require 'org)

;; Tangle code and load from an initial file
(setq spruce/bootstrap-org-file "configuration.org")
(setq spruce/bootstrap-org-path
      (expand-file-name
       (concat user-emacs-directory spruce/bootstrap-org-file)))
(org-babel-load-file spruce/bootstrap-org-path)
