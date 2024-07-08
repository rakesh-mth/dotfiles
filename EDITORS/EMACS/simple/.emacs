;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;;(package-refresh-contents)


;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;; Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(unless (package-installed-p 'undo-fu)
  (package-install 'undo-fu))
(unless (package-installed-p 'goto-last-change)
  (package-install 'goto-last-change))
;; Enable Evil
(require 'evil)
(evil-mode 1)
(setq evil-fold-list
  `(((hs-minor-mode)
     :open-all   hs-show-all
     :close-all  hs-hide-all
     :toggle     hs-toggle-hiding
     :open       hs-show-block
     :open-rec   nil
     :close      hs-hide-block)
   )
)

;; install company
(unless (package-installed-p 'company)
  (package-install 'company))
;;(use-package company
;;  :init
;;  (setq company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev)))
;;  :config
;;  (global-company-mode 1))
;;(use-package company
;;  :init
;;  :config (progn
;;	    (add-to-list 'company-backends '(company-capf company-dabbrev))
;;	    (add-to-list 'company-backends '(company-lsp company-dabbrev))
;;	    (add-to-list 'company-backends '(company-css company-dabbrev))
;;	    (add-to-list 'company-backends '(company-elisp company-dabbrev))
;;	    (add-to-list 'company-backends '(company-nxml company-dabbrev))
;;	    (add-to-list 'company-backends '(company-files company-dabbrev))
;;	    (setq company-dabbrev-downcase nil)
;;	    (global-company-mode)))

;; dependencies of Projectile
;; counsel
(unless (package-installed-p 'counsel)
  (package-install 'counsel))
;; ivy
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
(ivy-mode 1)


;; Projectile
(add-to-list 'package-pinned-packages '(projectile . "melpa-stable") t)
(unless (package-installed-p 'projectile)
  (package-install 'projectile))
(require 'projectile)
;; Recommended keymap prefix on macOS
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; projectile search path
(setq projectile-project-search-path '("F:/DevTrees/" "%USERPROFILE%/source/repos/"))
;; completion system for projectile
(setq projectile-completion-system 'ivy)
(projectile-mode +1)


;; Magit
(add-to-list 'package-pinned-packages '(magit . "melpa-stable") t)
(unless (package-installed-p 'magit)
  (package-install 'magit))


;; set font
(set-face-attribute 'default nil :height 200)
;; relative line number
;;(setq global-display-line-numbers-mode 'relative)
;;(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))
;; disable toolbar
(tool-bar-mode -1)
;; enable company mode in all buffer
(add-hook 'after-init-hook 'global-company-mode)
;; add company-backends
;;(add-to-list company-backends '((company-files company-keywords company-capf company-dabbrev-code company-etags company-dabbrev)))
;;(setq company-backends '((company-capf) (company-dabbrev)))
;;(setq company-backends '((company-dabbrev)))


;; open this config file
(defun my-config-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company magit undo-fu undo-tree goto-last-change use-package counsel ivy projectile evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
