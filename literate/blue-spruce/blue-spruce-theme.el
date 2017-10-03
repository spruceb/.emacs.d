(deftheme blue-spruce
  "A blue theme inspired by DOOM One")

(defgroup blue-spruce-theme nil
  "Options for blue-spruce"
  :group 'faces)

(require 'dash)

;; Color helper functions
;; "Borrowed" from doom-themes, who "borrowed" from solarized
(defun blue-spruce-name-to-rgb (color &optional frame)
  (mapcar (lambda (x) (/ x (float (car (color-values "#ffffff")))))
          (color-values color frame)))

(defun blue-spruce-blend (color1 color2 alpha)
  (apply (lambda (r g b) (format "#%02x%02x%02x" (* r 255) (* g 255) (* b 255)))
         (--zip-with (+ (* alpha it) (* other (- 1 alpha)))
                     (blue-spruce-name-to-rgb color1)
                     (blue-spruce-name-to-rgb color2))))

(defun blue-spruce-darken (color alpha)
  (blue-spruce-blend color "#000000" (- 1 alpha)))

(defun blue-spruce-lighten (color alpha)
  (blue-spruce-blend color "#FFFFFF" (- 1 alpha)))



(defface blue-spruce-default '((t (:inherit default)))
  "Background face for source code windows."
  :group 'blue-spruce-theme)

(defface blue-spruce-minibuffer-active '((t (:inherit mode-line)))
  "Face for active minibuffer."
  :group 'blue-spruce-theme)

(defface blue-spruce-linum '((t (:inherit linum)))
  "Another linum face for darker windows (like popups)."
  :group 'blue-spruce-theme)

(defface blue-spruce-nlinum-highlight '((t (:inherit linum)))
  "A face for the nlinum overlay on the current line."
  :group 'blue-spruce-theme)

(defface blue-spruce-hl-line '((t (:inherit hl-line)))
  "A face for the current line highlight."
  :group 'blue-spruce-theme)

;; add an org level 9 (https://emacs.stackexchange.com/questions/22115)
(defface org-level-9 ;; originally copied from org-level-8
  (org-compatible-face nil ;; not inheriting from outline-9 because that does not exist
    '((((class color)) (:foreground "#51afef"))))
  "Face used for level 9 headlines."
  :group 'org-faces)
(defface org-level-10
  (org-compatible-face nil
    '((((class color)) (:foreground "#51afef"))))
  "Face used for level 10 headlines."
  :group 'org-faces)
(setq org-level-faces (append org-level-faces (list 'org-level-9)))
(setq org-n-level-faces (length org-level-faces))

(let
    ((c '((class color) (min-colors 89)))
     (bold t)
     (italic t)
     
     ;; base colors
     (black          "#181E26")
     (white          "#DFDFDF")
     (grey           "#5B6268")
     (yellow         "#ECBE7B")
     (orange         "#DA8548")
     (red            "#FF6C6B")
     (magenta        "#C678DD")
     (violet         "#A9A1E1")
     (cyan           "#46D9FF")
     (teal           "#4DB5BD")
     (blue           "#51AFEF")
     (green          "#7bc275")

     ;; variant colors
     (bright-black-1    "#1c1f24")
     (dark-grey         "#3D3D48")
     (dark-grey-2       "#404850")
     (dark-yellow       "#CDB464")
     (dark-cyan         "#5699AF")
     (light-cyan        "#8ee5ff")
     (dark-blue         "#1F5582")
     (muted-green       "#98BE65")

     )

  (let*
      ((bg "#282c34")
       (bg-d (if window-system "#22252c" "#222222"))
       ;; (fg             "#bbc2cf")
       (fg  "#a0c2e9")
       (highlight      blue)
       (vertical-bar   black)
       (current-line   (if window-system "#23272e" "#262626"))
       (selection      dark-blue)
       (builtin        magenta)
       (comments       dark-cyan)
       (doc-comments   teal)
       (constants      violet)
       (functions      cyan)
       (keywords       blue)
       (methods        cyan)
       (operators      blue)
       (type           yellow)
       (strings        green)
       (variables      light-cyan)
       (numbers        orange)
       (region         "#3d4451")
       ;; tabs
       (tab-unfocused-bg "#353a42")
       (tab-unfocused-fg "#1e2022")
       ;; main search regions
       (search-bg      blue)
       (search-fg      black)
       ;; other search regions
       (search-rest-bg dark-grey)
       (search-rest-fg blue)
       ;; line number column
       (linum-bg       bg-d)
       (linum-fg       (if window-system dark-grey-2 grey))
       (linum-hl-fg    "#BBBBBB")
       (linum-hl-bg    bg-d)
       ;; mode line
       (modeline-fg    fg)
       (modeline-fg-l  blue)
       (modeline-bg    (blue-spruce-darken blue 0.475))
       (modeline-bg-l  (if window-system blue current-line))
       (modeline-fg-inactive grey)
       (modeline-bg-inactive (blue-spruce-darken blue 0.7))
       (modeline-height 3)
       ;; vcs
       (vc-modified    dark-yellow)
       (vc-added       green)
       (vc-deleted     red))

    (custom-theme-set-faces
     'blue-spruce
     ;; Doom faces
     
     `(blue-spruce-default
       ((((type graphic)) :inherit default :background ,bg)
        (t                :inherit default)))
     `(blue-spruce-hl-line
       ((((type graphic)) :background ,current-line)
        (t                :inherit hl-line)))
     `(blue-spruce-linum
       ((((type graphic)) :inherit linum :background ,bg)
        (t                :inherit linum)))
     `(blue-spruce-minibuffer-active ((,c (:background ,bg))))
     `(blue-spruce-nlinum-highlight  ((,c (:foreground ,linum-hl-fg :bold nil))))
     `(blue-spruce-flycheck-error    ((,c (:underline nil :foreground ,black :background ,red))))
     `(blue-spruce-flycheck-warning  ((,c (:underline nil :foreground ,black :background ,yellow))))
     `(blue-spruce-flycheck-info     ((,c (:underline nil :foreground ,black :background ,green))))
     ;; Base
     `(bold                   ((,c (:weight ,(if bold 'bold 'normal) :color ,white))))
     `(italic                 ((,c (:slant  ,(if italic 'italic 'normal)))))
     `(bold-italic            ((,c (:weight ,(if bold 'bold 'normal) :slant ,(if italic 'italic 'normal) :foreground ,white))))
     ;; Global
     `(default                ((,c (:background ,bg-d :foreground ,fg))))
     `(fringe                 ((,c (:inherit default :foreground ,comments))))
     `(region                 ((,c (:background ,region))))
     `(highlight              ((,c (:background ,blue :foreground ,black))))
     `(hl-line                ((,c (:background ,bg))))
     `(cursor                 ((,c (:background ,blue))))
     `(shadow                 ((,c (:foreground ,grey))))
     `(minibuffer-prompt      ((,c (:foreground ,blue))))
     `(tooltip                ((,c (:background ,black :foreground ,fg))))
     `(error                  ((,c (:foreground ,red))))
     `(warning                ((,c (:foreground ,yellow))))
     `(success                ((,c (:foreground ,green))))
     `(secondary-selection    ((,c (:background ,blue :foreground ,black))))
     `(lazy-highlight         ((,c (:background ,dark-blue :foreground ,white))))
     `(match                  ((,c (:foreground ,green :background ,black :bold ,bold))))
     `(trailing-whitespace    ((,c (:background ,doc-comments))))
     `(vertical-border        ((,c (:foreground ,vertical-bar :background ,vertical-bar))))
     `(show-paren-match       ((,c (:foreground ,blue :inverse-video t))))
     `(linum
       ((((type graphic)) :background ,bg-d :foreground ,dark-grey-2 :bold nil)
        (t                :background ,bg-d :foreground ,grey :bold nil)))

     `(font-lock-builtin-face           ((,c (:foreground ,builtin))))
     `(font-lock-comment-face           ((,c (:foreground ,comments))))
     `(font-lock-comment-delimiter-face ((,c (:foreground ,comments))))
     `(font-lock-doc-face               ((,c (:foreground ,doc-comments))))
     `(font-lock-doc-string-face        ((,c (:foreground ,doc-comments))))
     `(font-lock-constant-face          ((,c (:foreground ,constants))))
     `(font-lock-function-name-face     ((,c (:foreground ,functions))))
     `(font-lock-keyword-face           ((,c (:foreground ,keywords))))
     `(font-lock-string-face            ((,c (:foreground ,strings))))
     `(font-lock-type-face              ((,c (:foreground ,type))))
     `(font-lock-variable-name-face     ((,c (:foreground ,variables))))
     `(font-lock-warning-face           ((,c (:inherit warning))))
     `(font-lock-negation-char-face          ((,c (:foreground ,operators :bold ,bold))))
     `(font-lock-preprocessor-face           ((,c (:foreground ,operators :bold ,bold))))
     `(font-lock-preprocessor-char-face      ((,c (:foreground ,operators :bold ,bold))))
     `(font-lock-regexp-grouping-backslash   ((,c (:foreground ,operators :bold ,bold))))
     `(font-lock-regexp-grouping-construct   ((,c (:foreground ,operators :bold ,bold))))
     
     ;; Modeline
     `(mode-line                   ((,c
                                     (:foreground ,modeline-fg
                                                  :background ,modeline-bg
                                                  :box (:line-width ,modeline-height :color ,modeline-bg)))))
     `(mode-line-inactive          ((,c (:foreground ,modeline-fg-inactive :background ,modeline-bg-inactive
                                                     :box (:line-width ,modeline-height :color ,modeline-bg-inactive)))))
     `(header-line                 ((,c (:inherit mode-line))))
     ;; Custom (doom)
     `(blue-spruce-modeline-buffer-path       ((,c (:foreground ,(if bold white cyan) :bold ,bold))))
     `(blue-spruce-modeline-buffer-project    ((,c (:foreground ,fg))))
     `(blue-spruce-modeline-buffer-modified   ((,c (:foreground ,red))))
     `(blue-spruce-modeline-buffer-major-mode ((,c (:foreground ,(if bold white blue) :bold ,bold))))

     `(blue-spruce-modeline-highlight     ((,c (:foreground ,blue))))
     `(blue-spruce-modeline-panel         ((,c (:foreground ,black :background ,blue))))
     `(blue-spruce-modeline-bar           ((,c (:background ,blue))))
     `(blue-spruce-modeline-eldoc-bar     ((,c (:background ,yellow))))

     ;; Powerline/Spaceline
     `(spaceline-highlight-face    ((,c (:foreground ,blue))))
     `(powerline-active1           ((,c (:inherit mode-line))))
     `(powerline-active2           ((,c (:inherit mode-line))))
     `(powerline-inactive1         ((,c (:inherit mode-line-inactive))))
     `(powerline-inactive2         ((,c (:inherit mode-line-inactive))))

     ;; Dired/dired-k
     `(dired-directory             ((,c (:foreground ,orange))))
     `(dired-ignored               ((,c (:foreground ,comments))))
     `(dired-k-directory           ((,c (:foreground ,blue))))

     ;; Search
     `(isearch                     ((,c (:background ,search-bg :foreground ,black :bold ,bold))))
     `(isearch-lazy-highlight-face ((,c (:background ,search-rest-bg))))
     `(yas-field-highlight-face    ((,c (:inherit match))))

     ;; `window-divider'
     `(window-divider              ((,c (:foreground ,vertical-bar))))
     `(window-divider-first-pixel  ((,c (:foreground ,vertical-bar))))
     `(window-divider-last-pixel   ((,c (:foreground ,vertical-bar))))

     ;;
     ;; Plugins
     ;;

     ;; Avy
     `(avy-lead-face-0    ((,c (:background ,search-bg :foreground ,search-fg))))
     `(avy-lead-face-1    ((,c (:background ,search-bg :foreground ,search-fg))))
     `(avy-lead-face-2    ((,c (:background ,search-bg :foreground ,search-fg))))
     `(avy-lead-face      ((,c (:background ,search-bg :foreground ,search-fg))))
     
     ;; company-mode
     `(company-tooltip             ((,c (:inherit tooltip))))
     `(company-tooltip-common      ((,c (:foreground ,blue))))
     `(company-tooltip-search      ((,c (:foreground ,search-fg :background ,highlight))))
     `(company-tooltip-selection   ((,c (:background ,selection))))
     `(company-tooltip-mouse       ((,c (:background ,magenta :foreground ,bg))))
     `(company-tooltip-annotation  ((,c (:foreground ,violet))))
     `(company-scrollbar-bg        ((,c (:background ,black))))
     `(company-scrollbar-fg        ((,c (:background ,blue))))
     `(company-preview             ((,c (:foreground ,blue))))
     `(company-preview-common      ((,c (:foreground ,magenta :background ,dark-grey))))
     `(company-preview-search      ((,c (:inherit company-tooltip-search))))
     
     ;; diff-hl
     `(diff-hl-change              ((,c (:foreground ,vc-modified))))
     `(diff-hl-delete              ((,c (:foreground ,vc-deleted))))
     `(diff-hl-insert              ((,c (:foreground ,vc-added))))
     
     ;; ediff
     `(ediff-fine-diff-A    ((,c (:background ,red :foreground ,black :bold ,bold))))
     `(ediff-fine-diff-B    ((,c (:background ,green :foreground ,black :bold ,bold))))
     `(ediff-fine-diff-C    ((,c (:background ,dark-grey :foreground ,black :bold ,bold))))
     `(ediff-current-diff-A ((,c (:background ,(blue-spruce-darken red 0.6)))))
     `(ediff-current-diff-B ((,c (:background ,(blue-spruce-darken green 0.6)))))
     `(ediff-current-diff-C ((,c (:background ,(blue-spruce-darken dark-grey 0.6)))))
     `(ediff-even-diff-A    ((,c (:background ,(blue-spruce-lighten dark-grey 0.05)))))
     `(ediff-even-diff-B    ((,c (:background ,(blue-spruce-lighten dark-grey 0.05)))))
     `(ediff-even-diff-C    ((,c (:background ,(blue-spruce-lighten dark-grey 0.05)))))
     `(ediff-odd-diff-A     ((,c (:background ,(blue-spruce-darken dark-grey 0.15)))))
     `(ediff-odd-diff-B     ((,c (:background ,(blue-spruce-darken dark-grey 0.15)))))
     `(ediff-odd-diff-C     ((,c (:background ,(blue-spruce-darken dark-grey 0.15)))))
     
     ;; elscreen
     `(elscreen-tab-background-face     ((,c (:background ,bg-d))))
     `(elscreen-tab-control-face        ((,c (:background ,bg-d :foreground ,bg-d))))
     `(elscreen-tab-current-screen-face ((,c (:background ,bg :foreground ,fg))))
     `(elscreen-tab-other-screen-face   ((,c (:background ,tab-unfocused-bg :foreground ,tab-unfocused-fg))))
     
     ;; flycheck
     `(flycheck-error     ((,c (:underline (:style wave :color ,red)))))
     `(flycheck-warning   ((,c (:underline (:style wave :color ,yellow)))))
     `(flycheck-info      ((,c (:underline (:style wave :color ,green)))))
     `(flyspell-incorrect ((,c (:underline (:style wave :color ,grey) :inherit unspecified))))
     
     ;; git-gutter
     `(git-gutter:modified         ((,c (:foreground ,vc-modified))))
     `(git-gutter:added            ((,c (:foreground ,vc-added))))
     `(git-gutter:deleted          ((,c (:foreground ,vc-deleted))))
     `(git-gutter+-modified        ((,c (:foreground ,vc-modified))))
     `(git-gutter+-added           ((,c (:foreground ,vc-added))))
     `(git-gutter+-deleted         ((,c (:foreground ,vc-deleted))))
     
     ;; Helm
     `(helm-selection              ((,c (:background ,selection))))
     `(helm-match                  ((,c (:foreground ,blue :underline t))))
     `(helm-source-header          ((,c (:background ,current-line :foreground ,grey))))
     `(helm-swoop-target-line-face ((,c (:foreground ,highlight :inverse-video t))))
     `(helm-ff-file                ((,c (:foreground ,fg))))
     `(helm-ff-prefix              ((,c (:foreground ,magenta))))
     `(helm-ff-dotted-directory    ((,c (:foreground ,dark-grey))))
     `(helm-ff-directory           ((,c (:foreground ,orange))))
     `(helm-ff-executable          ((,c (:foreground ,white :slant italic))))
     
     ;; indent-guide, highlight-{quoted,numbers,indentation}-mode
     `(indent-guide-face                         ((,c (:foreground "#2F2F38"))))
     `(highlight-indentation-face                ((,c (:background "#222830"))))
     `(highlight-indentation-current-column-face ((,c (:background "#222830"))))
     `(highlight-indentation-guides-odd-face     ((,c (:background ,bg))))
     `(highlight-indentation-guides-even-face    ((,c (:background "#222830"))))
     `(highlight-quoted-symbol                   ((,c (:foreground ,type))))
     `(highlight-quoted-quote                    ((,c (:foreground ,operators))))
     `(highlight-numbers-number                  ((,c (:foreground ,numbers))))
     
     ;; hide-show
     `(hs-face            ((,c (:foreground ,comments :background ,bg-d))))
     `(hs-fringe-face     ((,c (:foreground ,blue))))
     
     ;; iedit
     `(iedit-occurrence            ((,c (:foreground ,magenta :bold ,bold :inverse-video t))))
     `(iedit-read-only-occurrence  ((,c (:inherit region))))
     
     ;; ivy
     `(ivy-current-match           ((,c (:background ,dark-blue))))
     `(ivy-minibuffer-match-face-1 ((,c (:background ,black :foreground ,(blue-spruce-lighten grey 0.1)))))
     `(ivy-minibuffer-match-face-2 ((,c (:background ,black :foreground ,magenta :bold ,bold))))
     `(ivy-minibuffer-match-face-3 ((,c (:background ,black :foreground ,green   :bold ,bold))))
     `(ivy-minibuffer-match-face-4 ((,c (:background ,black :foreground ,yellow  :bold ,bold))))
     `(ivy-virtual                 ((,c (:foreground ,fg))))
     
     ;; neotree
     `(neo-root-dir-face           ((,c (:foreground ,green :background ,bg))))
     `(neo-file-link-face          ((,c (:foreground ,fg))))
     `(neo-dir-link-face           ((,c (:foreground ,blue))))
     `(neo-expand-btn-face         ((,c (:foreground ,blue))))
     
     ;; pos-tip
     `(popup                       ((,c (:inherit tooltip))))
     `(popup-tip-face              ((,c (:inherit tooltip))))
     
     ;; tabbar
     `(tabbar-default              ((,c (:foreground ,bg-d :background ,bg-d :height 0.9))))
     `(tabbar-modified             ((,c (:inherit 'tabbar-default :foreground "#712222" :bold ,bold))))
     `(tabbar-unselected           ((,c (:inherit 'tabbar-default :foreground ,modeline-fg-inactive))))
     `(tabbar-selected             ((,c (:inherit 'tabbar-default :foreground ,modeline-fg :background ,bg :bold ,bold))))
     `(tabbar-selected-modified    ((,c (:inherit 'tabbar-selected :foreground "PaleGreen3"))))
     `(tabbar-highlight            ((,c (:foreground ,fg :background ,bg-d :inverse-video t))))
     `(tabbar-button               ((,c (:foreground ,modeline-fg :background ,modeline-bg-inactive))))
     `(tabbar-button-highlight     ((,c (:inherit 'tabbar-button :inverse-video t))))
     
     ;; swiper
     `(swiper-line-face            ((,c (:background ,blue    :foreground ,black))))
     `(swiper-match-face-1         ((,c (:background ,black   :foreground ,grey))))
     `(swiper-match-face-2         ((,c (:background ,orange  :foreground ,black :bold ,bold))))
     `(swiper-match-face-3         ((,c (:background ,magenta :foreground ,black :bold ,bold))))
     `(swiper-match-face-4         ((,c (:background ,green   :foreground ,black :bold ,bold))))
     
     ;; stripe-buffer
     `(stripe-highlight            ((,c (:background ,bg))))
     
     ;; Volatile highlights
     `(vhl/default-face            ((,c (:background ,dark-grey))))
     
     ;; Rainbow delimiters
     `(rainbow-delimiters-depth-1-face   ((,c (:bold ,bold :foreground ,blue))))
     `(rainbow-delimiters-depth-2-face   ((,c (:bold ,bold :foreground ,magenta))))
     `(rainbow-delimiters-depth-3-face   ((,c (:bold ,bold :foreground ,green))))
     `(rainbow-delimiters-depth-4-face   ((,c (:bold ,bold :foreground ,orange))))
     `(rainbow-delimiters-depth-5-face   ((,c (:bold ,bold :foreground ,violet))))
     `(rainbow-delimiters-unmatched-face ((,c (:bold ,bold :foreground ,red :inverse-video t))))
     
     ;; re-builder
     `(reb-match-0 ((,c (:foreground ,orange   :inverse-video t))))
     `(reb-match-1 ((,c (:foreground ,magenta  :inverse-video t))))
     `(reb-match-2 ((,c (:foreground ,green    :inverse-video t))))
     `(reb-match-3 ((,c (:foreground ,yellow   :inverse-video t))))
     
     ;; which-key
     `(which-key-key-face                   ((,c (:foreground ,green))))
     `(which-key-group-description-face     ((,c (:foreground ,violet))))
     `(which-key-command-description-face   ((,c (:foreground ,blue))))
     `(which-key-local-map-description-face ((,c (:foreground ,magenta))))
     
     ;; whitespace
     `(whitespace-tab              ((,c (:foreground ,dark-grey))))
     `(whitespace-newline          ((,c (:foreground ,dark-grey))))
     `(whitespace-trailing         ((,c (:background ,dark-grey))))
     `(whitespace-line             ((,c (:background ,current-line :foreground ,magenta))))
     
     ;; workgroups2
     `(wg-current-workgroup-face   ((,c (:foreground ,black  :background ,blue))))
     `(wg-other-workgroup-face     ((,c (:foreground ,grey :background ,current-line))))
     `(wg-divider-face             ((,c (:foreground ,dark-grey))))
     `(wg-brace-face               ((,c (:foreground ,blue))))

     ;;
     ;; Language-specific
     ;;

     ;; (css|scss)-mode
     `(css-proprietary-property ((,c (:foreground ,orange))))
     `(css-property             ((,c (:foreground ,green))))
     `(css-selector             ((,c (:foreground ,blue))))
     
     ;; js2-mode
     `(js2-function-param  ((,c (:foreground ,variables))))
     `(js2-function-call   ((,c (:foreground ,functions))))
     `(js2-object-property ((,c (:foreground ,violet))))
     `(js2-jsdoc-tag       ((,c (:foreground ,comments))))
     
     ;; typescript-mode
     `(ts-object-property  ((,c (:inherit js2-object-property))))
     
     ;; web-mode
     `(web-mode-doctype-face           ((,c (:foreground ,comments))))
     `(web-mode-html-tag-face          ((,c (:foreground ,methods))))
     `(web-mode-html-tag-bracket-face  ((,c (:foreground ,methods))))
     `(web-mode-html-attr-name-face    ((,c (:foreground ,type))))
     `(web-mode-html-entity-face       ((,c (:foreground ,cyan :italic ,italic))))
     `(web-mode-block-control-face     ((,c (:foreground ,orange))))
     ;;`(web-mode-html-tag-bracket-face  ((,c (:foreground ,operators))))
     
     ;; makefile-*-mode
     `(makefile-targets     ((,c (:foreground ,blue))))
     
     ;; markdown-mode
     `(markdown-header-face           ((,c (:foreground ,red :bold nil))))
     `(markdown-header-delimiter-face ((,c (:inherit markdown-header-face))))
     `(markdown-metadata-key-face     ((,c (:foreground ,red))))
     ;; `(markdown-blockquote-face ((,c (:foreground ,violet))))
     `(markdown-markup-face     ((,c (:foreground ,grey))))
     ;; `(markdown-markup-face     ((,c (:foreground ,operators))))
     `(markdown-pre-face        ((,c (:foreground ,green))))
     `(markdown-inline-face     ((,c (:foreground ,cyan))))
     `(markdown-list-face       ((,c (:foreground ,red))))
     `(markdown-link-face       ((,c (:foreground ,blue :bold nil))))
     `(markdown-url-face        ((,c (:foreground ,magenta :bold nil))))
     `(markdown-header-face-1   ((,c (:inherit markdown-header-face))))
     `(markdown-header-face-2   ((,c (:inherit markdown-header-face))))
     `(markdown-header-face-3   ((,c (:inherit markdown-header-face))))
     `(markdown-header-face-4   ((,c (:inherit markdown-header-face))))
     `(markdown-header-face-5   ((,c (:inherit markdown-header-face))))
     `(markdown-header-face-6   ((,c (:inherit markdown-header-face))))
     ;;`(markdown-header-rule-face       ((,c (:inherit shadow))))
     `(markdown-italic-face            ((,c (:inherit italic :foreground ,violet))))
     `(markdown-bold-face              ((,c (:inherit bold :foreground ,orange))))
     ;;`(markdown-link-face              ((,c (:inherit shadow))))
     ;;`(markdown-link-title-face        ((,c (:inherit link))))
     ;;`(markdown-url-face               ((,c (:inherit link))))
     
     ;; org-mode
     `(org-tag                   ((,c (:foreground ,yellow :bold nil))))
     `(org-priority              ((,c (:foreground ,red))))
     `(org-ellipsis            ((,c (:height 1))))
     `(org-hide                  ((,c (:foreground ,bg))))
     `(org-table                 ((,c (:foreground ,cyan))))
     `(org-quote                 ((,c (:slant italic :foreground ,grey :background ,current-line))))
     `(org-document-info         ((,c (:foreground ,orange))))
     `(org-document-info-keyword ((,c (:foreground ,dark-grey))))
     `(org-meta-line             ((,c (:foreground ,dark-grey-2 :height 0.8))))
     `(org-block-begin-line      ((,c (:background ,current-line :foreground
                                                   ,dark-grey-2 :height 0.8))))
     `(org-block-end-line        ((,c (:inherit org-block-begin-line))))
     `(org-block      ((,c (:inherit default :background ,current-line))))
     `(org-archived              ((,c (:foreground ,grey))))
     `(org-document-title        ((,c (:foreground ,cyan :height 1.2))))
     `(org-level-1               ((,c (:inherit outline-1
                                                :background ,current-line
                                                :foreground ,blue
                                                :bold ,bold :height 1.25
                                                :box (:line-width 4 :color ,current-line)))))
     `(org-level-2               ((,c (:inherit outline-2 :foreground ,cyan
                                                :height 1.15))))
     `(org-level-3               ((,c (                          :foreground ,blue))))
     `(org-level-4               ((,c (                          :foreground ,cyan))))
     `(org-level-5               ((,c (                          :foreground ,blue))))
     `(org-level-6               ((,c (                          :foreground ,cyan))))
     `(org-level-7               ((,c (                          :foreground ,blue))))
     `(org-code                  ((,c (:foreground ,orange))))
     `(org-verbatim              ((,c (:foreground ,green))))
     `(org-formula               ((,c (:foreground ,cyan))))
     `(org-list-dt               ((,c (:foreground ,cyan))))
     `(org-footnote              ((,c (:foreground ,orange))))
     `(org-link                  ((,c (:foreground ,cyan :underline t))))
     `(org-date                  ((,c (:foreground ,violet))))
     `(org-todo                  ((,c (:foreground ,yellow :bold inherit))))
     `(org-done                  ((,c (:foreground ,green  :bold inherit))))
     `(org-headline-done         ((,c (:foreground ,grey :bold nil :strike-through t))))
     `(org-special-keyword       ((,c (:foreground ,magenta))))
     `(org-checkbox              ((,c (:inherit org-todo))))
     `(org-checkbox-statistics-todo ((,c (:inherit org-todo))))
     `(org-checkbox-statistics-done ((,c (:inherit org-done))))
     ;; Custom org-mode faces
     `(org-list-bullet           ((,c (:foreground ,cyan))))
     `(message-header-name ((,c (:foreground ,green)))))

    (custom-theme-set-variables
     'blue-spruce
     `(vc-annotate-color-map
       '((20 .  ,green)
         (40 .  ,(blue-spruce-blend yellow green (/ 1.0 3)))
         (60 .  ,(blue-spruce-blend yellow green (/ 2.0 3)))
         (80 .  ,yellow)
         (100 . ,(blue-spruce-blend orange yellow (/ 1.0 3)))
         (120 . ,(blue-spruce-blend orange yellow (/ 2.0 3)))
         (140 . ,orange)
         (160 . ,(blue-spruce-blend magenta orange (/ 1.0 3)))
         (180 . ,(blue-spruce-blend magenta orange (/ 2.0 3)))
         (200 . ,magenta)
         (220 . ,(blue-spruce-blend red magenta (/ 1.0 3)))
         (240 . ,(blue-spruce-blend red magenta (/ 2.0 3)))
         (260 . ,red)
         (280 . ,(blue-spruce-blend grey red (/ 1.0 4)))
         (300 . ,(blue-spruce-blend grey red (/ 2.0 4)))
         (320 . ,(blue-spruce-blend grey red (/ 3.0 4)))
         (340 . ,grey)
         (360 . ,grey)))
     `(vc-annotate-very-old-color nil)
     `(vc-annotate-background ,black))
    ))

(provide-theme 'blue-spruce)
