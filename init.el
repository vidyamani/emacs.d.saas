(require 'package)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
                      starter-kit-bindings
                      starter-kit-ruby
                      color-theme
                      textmate
                      rvm
                      ruby-compilation
                      flymake-easy
                      yaml-mode
                      zenburn-theme
                      expand-region
                      yasnippet-bundle)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; (require 'color-theme)
;; (color-theme-arjen)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)

(require 'yaml-mode)

;; Textmate like fuzzy file locate and symbol lookup
;; Map to Super-t and Super-T. For the sake of Mac
;; terminal/iterm ssh user also mapped to Meta-t and
;; Meta-T
(textmate-mode)
(global-set-key (kbd "M-t") 'textmate-goto-file)
(global-set-key (kbd "M-T") 'textmate-goto-symbol)


;; Turn off ido flex complete if the complete list is
;; exceed 2000. Emacs will freeze up otherwise.
(defvar af-ido-flex-fuzzy-limit (* 2000 5))
(defadvice ido-set-matches-1 (around my-ido-set-matches-1 activate)
  (let ((ido-enable-flex-matching (< (* (length (ad-get-arg 0)) (length ido-text))
                                     af-ido-flex-fuzzy-limit)))
    ad-do-it))



;; Provid IntelliJ C-W style incremental selection base on sexp.
(global-set-key (kbd "M-+") 'er/expand-region)

;; Robust version of duplicate a line
(require 'duplicate-line)
(global-set-key (kbd "C-c C-d") 'duplicate-line)

;; cmd-return to toggle full screen on mac
(global-set-key (kbd "s-<return>") 'ns-toggle-fullscreen)

;; load ruby-test-run
(require 'ruby-test-run)
(global-set-key (kbd "C-x r f") 'ruby-test-run-file)
(global-set-key (kbd "C-x r s") 'ruby-test-run-single)
(global-set-key (kbd "C-x r l") 'ruby-test-run-last)


;; load rails-toolbelt
(require 'rails-toolbelt)

(require 'flymake-json)

;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-safe-themes (quote ("9f443833deb3412a34d2d2c912247349d4bd1b09e0f5eaba11a3ea7872892000" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(font-use-system-font t)
 '(grep-find-ignored-directories (quote ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "log")))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;; yas/snippets
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)


;; disable annoyed ring bell
(setq ring-bell-function 'ignore)


;; Sort out the font size and background color
(if (eq system-type 'gnu/linux)
    (custom-set-faces
     ;; custom-set-faces was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))))


;; increase font size
(set-face-attribute 'default nil :height 130)


(load-theme 'zenburn)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
