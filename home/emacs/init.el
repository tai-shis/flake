;; UI Elements
(menu-bar-mode -1)
(setq inhibit-startup-screen t)

;; Package init
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-dracula t)
  (doom-themes-visual-bell-config) ; Set flash on bell instead of beep
  (doom-themes-org-config)) ; Special settings for Org mode

;; Modeline customization
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25))

;; Better line numbers
(use-package display-line-numbers
  :ensure nil ; Built-in package
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative))


;; Smooth scrolling
(setq scroll-step 1
      scroll-margin 5
      scroll-conservatively 1000
      redisplay-dont-pause t)


