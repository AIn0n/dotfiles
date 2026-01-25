(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(set-face-attribute 'default nil :font "JetBrains Mono" :height 220)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq mac-right-option-modifier 'none) ; Only right Option inserts characters


(use-package gruvbox-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("51fa6edfd6c8a4defc2681e4c438caf24908854c12ea12a1fbfd4d055a9647a3"
     default))
 '(org-agenda-files
   '("~/inne/orgfiles/todo.org"
     "/Users/szymongorka/inne/orgfiles/til.org"))
 '(package-selected-packages
   '(counsel doom-modeline gruvbox-theme ivy ivy-rich org-bullets
	     org-roam org-roam-ui swiper visual-fill-column which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

 (load-theme 'gruvbox-dark-soft)

(require 'org-tempo)


(use-package swiper :ensure t)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         :map ivy-switch-buffer-map
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(column-number-mode)
(global-display-line-numbers-mode 1)

(dolist (mode '(term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(setq org-export-html-with-ids nil)


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
	 ("C-M-j" . 'counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))


(use-package org)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))



(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/inne/roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  (setq org-roam-graph-link-hidden-types '("file" "http" "https")
	org-roam-graph-extra-config '(("rankdir" . "LR"))))


(use-package org-roam-ui
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


(setq org-image-actual-width (list 600))
