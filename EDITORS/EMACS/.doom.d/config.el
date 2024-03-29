;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
(setq doom-font (font-spec :family "MesloLGS NF" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "MesloLGS NF" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; save this file: M-x eval-buffer and M-x projectile-discover-projects-in-search-path
(setq projectile-project-search-path '(("~/.config/emacs" . 2) ("~/workspaces" . 2) ("F:\\DevTrees" . 1) "F:\\DevTrees\\opensource"))

;; maximize in full screen on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; relative line number
(setq display-line-numbers-type 'relative)
;; do not ask for confirmation on exit
(setq confirm-kill-emacs nil)

;; to solve issue in MacBook Pro. will look on why to increase these limits.
(setq max-specpdl-size 8000) ;; default is 1000
(setq max-lisp-eval-depth 8000) ;; default is 500

;; c/c++ lsp, Use "clangd" in eglot if in PATH. on mac use clang from llvm with brew.
(when (featurep! :tools lsp +eglot)
  (after! eglot
    (let ((clangd (if IS-MAC "/usr/local/opt/llvm/bin/clangd" "clangd")))
      (when (executable-find clangd)
        (set-eglot-client! 'c++-mode `(,clangd "-j=3" "--clang-tidy"))
        (set-eglot-client! 'c-mode `(,clangd "-j=3" "--clang-tidy"))))))

;; c/c++ specific
;; (global-set-key (kbd "C-x C-o") 'ff-find-other-file) ;; will use local-set-key and only for c/c++ files.
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key  (kbd "C-x C-o") 'ff-find-other-file)))

;; add a function for clear ielm buffer, and a key mapping (C-l)
(with-eval-after-load 'comint
        (unless (fboundp 'comint-clear-buffer)
                (defun comint-clear-buffer ()
                        "clean ielm window"
                        (interactive)
                        (let ((comint-buffer-maximum-size 0))
                                (comint-truncate-buffer)))))

(define-key comint-mode-map "\C-l" #'comint-clear-buffer)

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
