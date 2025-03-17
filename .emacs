;; -*- lexical-binding: t; -*-

(setq package-check-signature nil)

(add-to-list 'package-archives
			 '("melpa-stable" . "http://stable.melpa.org/packages/"))

(add-to-list 'package-archives
			 '("melpa" . "http://melpa.org/packages/"))

(package-initialize)

(load "~/.emacs.rc/rc.el")
(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-rc.el")

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(set-frame-font "TX-02 11" nil t)


(setq-default indicate-empty-lines t)
(fset 'yes-or-no-p 'y-or-n-p)

;; (add-to-list 'default-frame-alist '(fullscreen . fullboth))
;; (add-to-list 'initial-frame-alist '(fullscreen . fullboth))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode -1)
(column-number-mode 1)
(xterm-mouse-mode 1)
(global-auto-revert-mode 1)
(savehist-mode 1)
(recentf-mode 1)
(global-completion-preview-mode 1)
(global-hl-line-mode 1)


;; (setq default-frame-alist
;;       '((height . 44) (width  . 81) (left-fringe . 0) (right-fringe . 0)
;;         (internal-border-width . 32) (vertical-scroll-bars . nil)
;;         (bottom-divider-width . 0) (right-divider-width . 0)
;;         (undecorated-round . t)))
;; (modify-frame-parameters nil default-frame-alist)
;; (setq-default pop-up-windows nil)

(global-set-key (kbd "C-c p") 'find-file-at-point)

(add-hook 'prog-mode-hook
          (lambda ()
            (display-line-numbers-mode 1)
            (setq display-line-numbers-width-start 4)))

(set-face-attribute 'font-lock-type-face t :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)
(setq visible-bell 1)
(setq display-line-numbers-type 'relative)
(setq backup-drectory-alist '(("." . "~/.emacs_saves")))

(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

(defun rc/set-up-whitespace-handling ()
  (interactive)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)

(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

(eval-when-compile
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (setq use-package-expand-minimally t))

(use-package vertico
  :ensure t
  :config
  (setq vertico-count 6)
  (setq vertico-resize t)
  (setq vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia :ensure t :init (marginalia-mode))

(use-package consult
  :ensure t
  :bind (("C-c C-r" . consult-imenu)
         ("C-x b" . consult-buffer)
         ("M-s g" . consult-grep)
         ("M-s f" . consult-find)
         ("M-s o" . consult-outline)
         ("M-s l" . consult-line)))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

;; (use-package smex
;;   :ensure
;;   :bind (("M-x" . 'smex)
;;          ("M-X" . 'smex-major-mode-commands))
;;   :config (smex-initialize))

;; (use-package ido-completing-read+
;;   :ensure t
;;   :config
;;   (ido-mode 1)
;;   (ido-everywhere 1))

(use-package corfu
  :config
  (setq corfu-auto t)
  (setq corfu-auto-delay 0.2)
  (setq corfu-auto-prefix 2)
  (setq tab-always-indent 'complete)
  (setq corfu-preselect 'prompt)
  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode)
  (global-corfu-mode))

;; Add extensions
(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package paredit
  :hook ((emacs-lisp-mode . enable-paredit-mode)
         (lisp-mode . enable-paredit-mode)
         (common-lisp-mode . enable-paredit-mode)
         (scheme-mode . enable-paredit-mode)))

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("C-\"" . mc/skip-to-next-like-this)
         ("C-:" . mc/skip-to-previous-like-this)))



;; (use-package helm
;;   :bind (("C-c h" . 'helm-command-prefix)
;;          ("C-x b" . 'helm-mini)))

;; (use-package company
;;   :config (add-hook 'after-init-hook 'global-company-mode))

(use-package yasnippet
  :config (yas-global-mode 1)
  (setq yas-snippet-dirs '("~/.emacs.d/snippets")))

(use-package yasnippet-snippets
  :after yasnippet)

(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package which-key
  :config (which-key-mode))

(use-package typescript-mode)
(use-package go-mode)

;; (use-package markdown-mode
;;   :mode ("README\\.md\\'" . gfm-mode)
;;   :init (setq markdown-command "multimarkdown"))

;; (use-package haskell-mode
;;   :hook ((haskell-mode . haskell-indent-mode)
;;          (haskell-mode . interactive-haskell-mode)
;;          (haskell-mode . haskell-doc-mode)
;;          (haskell-mode . hindent-mode))
;;   :config
;;   (setq haskell-process-type 'cabal-new-repl)
;;   (setq haskell-process-log t))

(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t)
  :hook
  ((rust-mode . eglot)))

(use-package eglot
  :hook
  (rust-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((c++-mode c-mode) "clangd"))
  (add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) .
                                        ("rust-analyzer" :initializationOptions (:check (:command "clippy"))))))

;; (use-package auctex
;;                :config
;;                (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
;;                      TeX-source-correlate-start-server t)
;;                (global-set-key (kbd "C-c C-v") 'TeX-view)
;;                (add-hook 'TeX-after-compilation-finished-functions
;;                          #'TeX-revert-document-buffer))

;; (use-package pdf-tools
;;   :mode ("\\.pdf\\'" . pdf-view-mode)
;;   :config
;;   (pdf-tools-install)
;;   (setq-default pdf-view-display-size 'fitpage
;;                 pdf-annot-activate-created-annotations t
;;                 pdf-view-incompatible-modes '(display-line-numbers-mode)))

(use-package xterm-color
  :config (setq compilation-environment '("TERM=xterm-256color"))
  (advice-add 'compilation-filter :around
              (lambda (f proc string)
                (funcall f proc (xterm-color-filter string)))))

(use-package olivetti
  :config
  (setq olivetti-minimum-body-width 100))

;; Enable Completion Preview mode in code buffers
(add-hook 'prog-mode-hook #'completion-preview-mode)
;; also in text buffers
(add-hook 'text-mode-hook #'completion-preview-mode)
;; and in \\[shell] and friends
(with-eval-after-load 'comint
  (add-hook 'comint-mode-hook #'completion-preview-mode))

(with-eval-after-load 'completion-preview
  ;; Show the preview already after two symbol characters
  (setq completion-preview-minimum-symbol-length 2)

  ;; Non-standard commands to that should show the preview:

  ;; Org mode has a custom `self-insert-command'
  (push 'org-self-insert-command completion-preview-commands)
  ;; Paredit has a custom `delete-backward-char' command
  (push 'paredit-backward-delete completion-preview-commands)

  ;; Bindings that take effect when the preview is shown:

  ;; Cycle the completion candidate that the preview shows
  (keymap-set completion-preview-active-mode-map "M-n" #'completion-preview-next-candidate)
  (keymap-set completion-preview-active-mode-map "M-p" #'completion-preview-prev-candidate)
  ;; Convenient alternative to C-i after typing one of the above
  (keymap-set completion-preview-active-mode-map "M-i" #'completion-preview-insert))

(use-package challenger-deep-theme)
(use-package gruber-darker-theme)
(use-package material-theme)







;; (load-theme 'challenger-deep t)
;; (load-theme 'gruber-darker t)
;; (load-theme 'material t)
;; (load-theme 'flatland t)
;; (load-theme 'modus-vivendi-tinted t)
;; (load-theme 'modus-vivendi t)
;; (load-theme 'nord t)
;; (load-theme 'nordless t)
;; (load-theme 'nordic-midnight t)

;; scroll one line at a time (less "jumpy" than defaults)
;; (pixel-scroll-mode 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(use-package nano-theme
  :config
  (load-theme 'nano-dark))

(use-package nano-modeline
  :config
  (nano-modeline-text-mode t))

(add-hook 'prog-mode-hook            #'nano-modeline-prog-mode)
(add-hook 'text-mode-hook            #'nano-modeline-text-mode)
(add-hook 'org-mode-hook             #'nano-modeline-org-mode)
(add-hook 'pdf-view-mode-hook        #'nano-modeline-pdf-mode)
(add-hook 'mu4e-headers-mode-hook    #'nano-modeline-mu4e-headers-mode)
(add-hook 'mu4e-view-mode-hook       #'nano-modeline-mu4e-message-mode)
(add-hook 'elfeed-show-mode-hook     #'nano-modeline-elfeed-entry-mode)
(add-hook 'elfeed-search-mode-hook   #'nano-modeline-elfeed-search-mode)
(add-hook 'term-mode-hook            #'nano-modeline-term-mode)
(add-hook 'xwidget-webkit-mode-hook  #'nano-modeline-xwidget-mode)
(add-hook 'messages-buffer-mode-hook #'nano-modeline-message-mode)
(add-hook 'org-capture-mode-hook     #'nano-modeline-org-capture-mode)
(add-hook 'org-agenda-mode-hook      #'nano-modeline-org-agenda-mode)


(use-package clang-format
  :commands (clang-format-buffer clang-format-on-save-mode)
  :hook (c-mode c++-mode)
  :config
  (clang-format-on-save-mode))
