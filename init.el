(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Customizations.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("57d7e8b7b7e0a22dc07357f0c30d18b33ffcbb7bcd9013ab2c9f70748cfa4838" "da8e6e5b286cbcec4a1a99f273a466de34763eefd0e84a41c71543b16cd2efac" default)))
 '(default-frame-alist (quote ((width . 120) (height . 40))))
 '(dired-auto-revert-buffer (quote dired-directory-changed-p))
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(intero-stack-executable "/Users/yiding/.local/bin/stack")
 '(make-backup-files nil)
 '(package-selected-packages
   (quote
    (flycheck-rust tuareg bazel-mode intero toml-mode rust-mode yaml-mode markdown-mode indent-guide org-evil evil-org color-theme-modern php-mode haskell-mode evil)))
 '(scroll-bar-mode nil)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil)
 '(uniquify-min-dir-content 2)
 '(vc-handled-backends (quote (RCS CVS SVN SCCS SRC Bzr Git))))

;; one-off scripts go here.
(add-to-list 'load-path "~/.emacs.d/scripts")
(autoload 'propindent-mode "propindent-mode" nil t)

;; evil.

(require 'evil)
(evil-mode 1)


; Consider underscores as part of words.
(modify-syntax-entry ?_ "w")

;; Dired hide details by default
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Configure some UI specific things.

; Tweak haskell syntax highlighting.
(defun haskell-mode-tweaks ()
  (set-face-bold-p 'haskell-definition-face nil)
  (set-face-bold-p 'haskell-constructor-face nil)
  (set-face-bold-p 'haskell-type-face nil))
(when window-system
  (set-face-attribute 'default nil :font "Noto Mono 12")
  (set-face-attribute 'variable-pitch nil :font "Noto Sans Display 12")
  (set-face-bold-p 'bold nil)
  (add-hook 'haskell-mode-hook
	    (lambda ()
	      (variable-pitch-mode)
	      (haskell-mode-tweaks)))
  (add-hook 'rust-mode-hook 'variable-pitch-mode)
  )

;; Color theme
(load-theme 'desert t t)
(enable-theme 'desert)
