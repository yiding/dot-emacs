(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Customizations.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("da8e6e5b286cbcec4a1a99f273a466de34763eefd0e84a41c71543b16cd2efac" default)))
 '(default-frame-alist (quote ((width . 120) (height . 40))))
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(intero-stack-executable "/Users/yiding/.local/bin/stack")
 '(make-backup-files nil)
 '(package-selected-packages
   (quote
    (intero toml-mode rust-mode yaml-mode markdown-mode indent-guide org-evil evil-org color-theme-modern php-mode haskell-mode evil)))
 '(scroll-bar-mode nil)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil))

;; one-off scripts go here.
(add-to-list 'load-path "~/.emacs.d/scripts")
(autoload 'propindent-mode "propindent-mode" nil t)

;; evil.

(require 'evil)
(evil-mode 1)

; Consider underscores as part of words.
(modify-syntax-entry ?_ "w")

;; Because sometimes we need monospace fonts.

(defun use-monospace ()
  "Switch the current buffer to a monospace font."
  (face-remap-add-relative 'default '(:family "Monospace" :height 120)))

;; Dired hide details by default
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Configure some UI specific things.
(when window-system
  (add-hook 'dired-mode-hook 'use-monospace)
  (set-face-attribute 'default nil :font "Source Code Pro 12")
  (set-face-attribute 'variable-pitch nil :font "Linux Libertine O 14")
  (add-hook 'haskell-mode-hook 'propindent-mode))

;; Color theme
(load-theme 'desert t t)
(enable-theme 'desert)
