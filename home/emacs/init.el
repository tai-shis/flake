;;; package --- Emacs lisp configuration -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;; ============================================
;;; Performance Optimization
;;; ============================================

;; Increase garbage collection threshold during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reduce garbage collection during normal operation
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024) ; 16MB
                  gc-cons-percentage 0.1)))

;; Don't compact font caches during GC
(setq inhibit-compacting-font-caches t)

;; Prefer loading newer compiled files
(setq load-prefer-newer t)

;;; ============================================
;;; Package Management (managed by NixOS)
;;; ============================================

;; No need for package.el - all packages managed by Nix
(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure nil  ; Nix manages packages
      use-package-always-defer t)    ; Defer loading by default

;;; ============================================
;;; UI Elements
;;; ============================================

(menu-bar-mode -1)
(setq inhibit-startup-screen t)

;; Theme - load immediately for better UX
(use-package doom-themes
  :demand t  ; Load immediately
  :config
  (load-theme 'doom-dracula t))

;; Alternative theme (uncomment to use):
;; (use-package nord-theme
;;   :demand t
;;   :config
;;   (load-theme 'nord t))

;; Modeline customization
(use-package doom-modeline
  :demand t  ; Load immediately for visual consistency
  :config
  (setq doom-modeline-height 25)
  (doom-modeline-mode 1))

;; Better line numbers - only in programming modes
(use-package display-line-numbers
  :ensure nil ; Built-in package
  :defer t
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative))

;; Highlighting
(global-hl-line-mode t)
(show-paren-mode t)

;; Smooth scrolling
(setq scroll-step 1
      scroll-margin 5
      scroll-conservatively 1000)

;;; ============================================
;;; Development Tools
;;; ============================================

;; Direnv integration
(use-package direnv
  :defer t
  :config
  (direnv-mode))

;; Flycheck - defer until needed
(use-package flycheck
  :defer t
  :hook (prog-mode . flycheck-mode))

;; Treemacs - only load when invoked
(use-package treemacs
  :defer t
  :bind ("C-c t" . treemacs))

;; Magit - only load when invoked
(use-package magit
  :defer t
  :bind ("C-x g" . magit-status))

;;; ============================================
;;; LSP Configuration
;;; ============================================

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :init
  ;; LSP performance tuning
  (setq lsp-keymap-prefix "C-c l"
        lsp-log-io nil  ; Disable logging for performance
        lsp-idle-delay 0.5
        lsp-enable-file-watchers nil  ; Disable file watchers for better performance
        lsp-file-watch-threshold 5000
        read-process-output-max (* 1024 1024))  ; 1MB
  :config
  ;; Disable features you might not need
  (setq lsp-enable-symbol-highlighting nil
        lsp-lens-enable nil
        lsp-headerline-breadcrumb-enable nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil))

;; LSP UI settings
(use-package lsp-ui
  :defer t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'bottom
        lsp-ui-doc-delay 0.5  ; Add delay to reduce overhead
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-delay 0.5))  ; Add delay

;;; ============================================
;;; Completion
;;; ============================================

(use-package company
  :defer t
  :hook (prog-mode . company-mode)  ; Only in programming modes
  :config
  (setq company-idle-delay 0.2  ; Slight delay to reduce overhead
        company-minimum-prefix-length 2  ; Require 2 chars before triggering
        company-selection-wrap-around t)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)))

;;; ============================================
;;; Language-Specific Configuration
;;; ============================================

;; Rust
(use-package rust-mode
  :defer t
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp-deferred))

;; Haskell
(use-package lsp-haskell
  :defer t
  :hook (haskell-mode . lsp-deferred))

(use-package haskell-mode
  :defer t
  :mode "\\.hs\\'")

;; Nix
(use-package nix-mode
  :defer t
  :mode "\\.nix\\'"
  :hook (nix-mode . lsp-deferred))

;;; ============================================
;;; Final Optimizations
;;; ============================================

;; File name handler optimization during startup
(defvar file-name-handler-alist-original file-name-handler-alist)

(setq file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-original)))

(provide 'init)
;;; init.el ends here
