;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "https://orgmode.org/elpa/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/") ))
(package-initialize)
(when (memq window-system '(mac ns x))
(when (eq system-type 'darwin)
       (if (equal (file-name-nondirectory (getenv "SHELL")) "fish")
           (progn
             (setq path-separator " ")
             (exec-path-from-shell-initialize)
             (setq path-separator ":"))
         (exec-path-from-shell-initialize))))

(setq inhibit-startup-screen t)





;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; other configs
(setq ring-bell-function 'ignore)
(defalias 'yes-or-no-p 'y-or-n-p)
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode   -1))
(when (fboundp 'tooltip-mode)
  (tooltip-mode    -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode   -1))
(when (fboundp 'global-linum-mode)
  (global-linum-mode 1))
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))
(setq left-fringe-width 20)


;; Highlight Indent (like vscode)
(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\│)
  :hook ((prog-mode . highlight-indent-guides-mode)))


;; linum space
(setq linum-format "  %3d ")



;; Ace Jump
(use-package ace-jump-mode :ensure t)



;; RipGrep
(use-package helm-rg :ensure t)



;; evil mode
(use-package evil 
  :ensure t)


;; evil leader
(use-package evil-leader 
  :ensure t)



;; Treemacs
(use-package treemacs
  :ensure t
  :config
  (treemacs-follow-mode t)
  (treemacs-git-mode 'simple)
  (treemacs-filewatch-mode nil)
  (treemacs-fringe-indicator-mode nil)
  (setq treemacs-width 35
        treemacs-max-git-entries 100
        treemacs-display-in-side-window t
        treemacs-deferred-git-apply-delay 0.5
        treemacs-indentation-string (propertize " " 'face 'font-lock-comment-face)
        treemacs-indentation 1
        treemacs-file-follow-delay 0.2
        treemacs-silent-filewatch t
        treemacs-silent-refresh t)
  (add-hook 'treemacs-mode-hook #'hide-mode-line-mode)
  (add-hook 'treemacs-mode-hook (lambda ()
                                  (linum-mode -1)
                                  (fringe-mode 0)
                                  (setq buffer-face-mode-face `(:background "#21252c"))
                                  (buffer-face-mode 1)))
  ;; Improve treemacs icons
  (with-eval-after-load 'treemacs
    (with-eval-after-load 'all-the-icons
      (let ((all-the-icons-default-adjust 0)
            (tab-width 1))
        ;; Root icon
        (setq treemacs-icon-root-png (concat (all-the-icons-octicon "repo" :height 0.8 :v-adjust -0.2)  " "))
        ;; File icons
        (setq treemacs-icon-open-png
              (concat
               (all-the-icons-octicon "chevron-down" :height 0.8 :v-adjust 0.1)
               "\t"
               (all-the-icons-octicon "file-directory" :v-adjust 0)
               "\t")
              treemacs-icon-closed-png
              (concat
               (all-the-icons-octicon "chevron-right" :height 0.8 :v-adjust 0.1 :face 'font-lock-doc-face)
               "\t"
               (all-the-icons-octicon "file-directory" :v-adjust 0 :face 'font-lock-doc-face)
               "\t"))
        ;; File type icons
        (setq treemacs-icons-hash (make-hash-table :size 200 :test #'equal)
              treemacs-icon-fallback (concat
                                      "\t\t"
                                      (all-the-icons-faicon "file-o" :face 'all-the-icons-dsilver :height 0.8 :v-adjust 0.0)
                                      "\t")
              treemacs-icon-text treemacs-icon-fallback)
        
        (dolist (item all-the-icons-icon-alist)
          (let* ((extension (car item))
                 (func (cadr item))
                 (args (append (list (caddr item)) '(:v-adjust -0.05) (cdddr item)))
                 (icon (apply func args))
                 (key (s-replace-all '(("^" . "") ("\\" . "") ("$" . "") ("." . "")) extension))
                 (value (concat "\t\t" icon "\t")))
            (unless (ht-get treemacs-icons-hash (s-replace-regexp "\\?" "" key))
              (ht-set! treemacs-icons-hash (s-replace-regexp "\\?" "" key) value))
            (unless (ht-get treemacs-icons-hash (s-replace-regexp ".\\?" "" key))
              (ht-set! treemacs-icons-hash (s-replace-regexp ".\\?" "" key) value))))))))

(use-package treemacs-projectile
  :ensure t)




;; Modeline
(use-package hide-mode-line :ensure t)











;; JS TS and Web
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (typescript-mode . flycheck-mode)
         (before-save . tide-formater-before-save))
  :config
  (define-key typescript-mode-map (kbd "C-c r") 'tide-refactor))



(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
;; Flycheck
(use-package flycheck :ensure t)
;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))
;; Shell 

;;prettier js 
(add-to-list 'load-path "~/.emacs.d/other-packages/prettier-mode/")
(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
      (funcall (cdr my-pair)))))
(add-hook 'web-mode-hook #'(lambda ()
                            (enable-minor-mode
                             '("\\.jsx?\\'" . prettier-js-mode))))





;; Load Atom One Dark theme
(load-theme 'atom-one-dark t)










;; ranger
(use-package ranger
  :ensure t
  :config
  (setq ranger-hide-cursor nil)
  (setq ranger-show-literal t)
  (setq ranger-dont-show-binary t)
  :init
  (ranger-override-dired-mode 1))




;; Company mode
(use-package company
  :ensure t
  :init
  (setq company-minimum-prefix-length 3)
  (setq company-auto-complete nil)
  (setq company-idle-delay 0.1)
  (setq company-require-match 'never)
  (setq company-frontends
        '(company-pseudo-tooltip-unless-just-one-frontend
          company-preview-frontend
          company-echo-metadata-frontend))
  (setq tab-always-indent 'complete)
  (defvar completion-at-point-functions-saved nil)
  :config
  (global-company-mode 1))





;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-locate-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-completion-in-region-fuzzy-match t
        helm-candidate-number-list 80
        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-echo-input-in-header-line t
        helm-autoresize-max-height 0
        helm-autoresize-min-height 20)
  :config
  (helm-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action))







;; wn-mode
(wn-mode 1)


(eval-when-compile
  (require 'use-package))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type (quote box))
 '(elscreen-display-tab nil)
 '(eshell-scroll-to-bottom-on-input (quote all))
 '(evil-default-state (quote insert))
 '(exec-path-from-shell-arguments (quote ("nil")))
 '(global-evil-tabs-mode t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(mode-line-format
   (quote
    ("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position evil-mode-line-tag
     (elscreen-display-screen-number
      (" " elscreen-mode-line-string))
     (vc-mode vc-mode))))
 '(package-selected-packages
   (quote
    (evil-tabs js2-mode web-mode magit quelpa-use-package evil-escape helm-rg wn-mode atom-one-dark-theme use-package)))
 '(switch-to-buffer-in-dedicated-window nil)
 '(window-sides-slots (quote (nil nil nil nil)))
 '(window-sides-vertical t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#282C34" :foreground "#ABB2BF" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 300 :width normal :foundry "nil" :family "Consolas"))))
 '(eshell-prompt ((t (:foreground "SpringGreen2" :weight bold))))
 '(flycheck-error ((t (:foreground "dark red" :underline (:color "dark red" :style wave)))))
 '(treemacs-directory-face ((t (:foreground "#89b8ff"))))
 '(treemacs-root-face ((t (:inherit font-lock-constant-face :underline nil :weight normal :height 1.2))))
 '(variable-pitch ((t (:family "Consolas")))))



;; evil mode
;;evil mode 
(evil-mode 1)
(global-evil-leader-mode)



;; evil escape 
(use-package evil-escape :ensure t)
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "jf")	
(setq-default evil-escape-delay 0.2)

(setq-default evil-insert-state-cursor '("#528BFF" quote box))




;; pop shell 
(add-to-list 'load-path "~/.emacs.d/other-packages/pop-eshell-mode/")


(require 'pop-eshell-mode)
(setq pop-find-parent-directory '(".git" "gradlew")) ;; parent directory should have .git or gradlew file
;;(pop-eshell-mode 1)

(add-hook 'eshell-mode-hook (lambda () (linum-mode -1)))
(setenv "PAGER" "cat")

;;magit
(use-package magit :ensure t)



(add-hook
 'eshell-mode-hook
 (lambda ()
   (setenv "TERM" "emacs") ; enable colors
  ))











;;;;;;;;;;;;;;;; Key Blink;;;;;;;;;;;;;;

(global-set-key (kbd "s-j") 'forward-char)
(global-set-key (kbd "s-f") 'backward-char)
(global-set-key (kbd "s-e") 'previous-line)
(global-set-key (kbd "s-i") 'next-line)
(global-set-key (kbd "s-q") 'move-beginning-of-line)
(global-set-key (kbd "s-p") 'move-end-of-line)
(global-set-key (kbd "s-k") 'forward-word)
(global-set-key (kbd "s-d") 'backward-word)
(global-set-key (kbd "s-w") 'scroll-down-command)
(global-set-key (kbd "s-o") 'scroll-up-command)
(global-set-key (kbd "s-g") 'isearch-forward)
(global-set-key (kbd "s-h") 'isearch-repeat-forward)
(global-set-key (kbd "s-y") 'isearch-yank-pop)
(global-set-key (kbd "s-m") 'eshell-pop-toggle)
(global-set-key (kbd "s-b") 'delete-window)

(global-set-key [(s shift h)] 'isearch-repeat-backward)
(global-set-key [(s /)] 'comment-line)
(global-set-key [(s \\)] 'treemacs)






(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "f" 'helm-find-files)
(evil-leader/set-key "s" 'save-buffer)
(evil-leader/set-key "r" 'split-window-right)
(evil-leader/set-key "b" 'split-window-below)
(evil-leader/set-key "v" 'er/mark-word)
(evil-leader/set-key "e" 'switch-to-buffer)
(evil-leader/set-key "g" 'evil-ex)
