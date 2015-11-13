;;; Haskell --- Customizations
;;; Commentary:
;;;    Custom haskell hooks

;;------------------------------
;; Haskell
;;------------------------------

;;; Code:
(setq exec-path (cons "~/.stack/programs/x86_64-linux/ghc-7.8.4/bin/" exec-path))
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(setq haskell-process-load-or-reload-prompt t)
(setq haskell-indent-offset 4)
(setq haskell-indent-spaces 4)
(setq haskell-indent-after-keywords (quote (("where" 4 0) ("of" 4) ("do" 4) ("mdo" 4) ("rec" 4) ("in" 4 0) ("{" 4) "if" "then" "else" "let")))
(setq haskell-stylish-on-save t)

(custom-set-variables
 '(haskell-package-manager-name "stack")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci)))


(defmacro hcRequire (name &rest body)
  `(if (require ',name nil t)
       (progn ,@body)
     (warn (concat (format "%s" ',name) " NOT FOUND"))))

;; Do this to get a variable in scope
(auto-complete-mode)
(defun hc-ac-haskell-candidates (prefix)
  (let ((cs (haskell-process-get-repl-completions (haskell-process) prefix)))
    (remove-if (lambda (c) (string= "" c)) cs)))
(ac-define-source haskell
                  '((candidates . (hc-ac-haskell-candidates ac-prefix))))
(defun hc-haskell-hook ()
  (add-to-list 'ac-sources 'ac-source-haskell))
(add-hook 'haskell-mode-hook 'hc-haskell-hook)

;; cd /src/ && git clone git@github.com:ajnsit/ghc-mod.git
;; cd /src/ghc-mod ; git checkout stack-support ; stack build
(add-to-list 'load-path "/Users/jared/Data/development/oss/haskell/ghc-mod/.stack-work/install/x86_64-osx/lts-2.17/7.8.4/lib/x86_64-osx-ghc-7.8.4/ghc-mod-0")

(ac-define-source ghc-mod
                  '((depends ghc)
                    (candidates . (ghc-select-completion-symbol))
                    (symbol . "s")
                    (cache)))
(defun my-ac-haskell-mode ()
  (setq ac-sources '(ac-source-words-in-same-mode-buffers
                     ac-source-dictionary
                     ac-source-ghc-mod)))
(add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

(eval-after-load 'haskell-mode
  '(progn
     (define-key haskell-mode-map (kbd "C-u C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
     (define-key haskell-mode-map (kbd "C-c M-.") nil)
     (define-key haskell-mode-map (kbd "C-c C-d") nil)
     (define-key haskell-mode-map (kbd "C-c v c") 'haskell-cabal-visit-file)
     ))

(eval-after-load "align"
  '(add-to-list 'align-rules-list
                '(haskell-types
                  (regexp . "\\(\\s-+\\)\\(::\\|∷\\)\\s-+")
                  (modes quote (haskell-mode literate-haskell-mode)))))
(eval-after-load "align"
  '(add-to-list 'align-rules-list
                '(haskell-assignment
                  (regexp . "\\(\\s-+\\)=\\s-+")
                  (modes quote (haskell-mode literate-haskell-mode)))))
(eval-after-load "align"
  '(add-to-list 'align-rules-list
                '(haskell-arrows
                  (regexp . "\\(\\s-+\\)\\(->\\|→\\)\\s-+")
                  (modes quote (haskell-mode literate-haskell-mode)))))
(eval-after-load "align"
  '(add-to-list 'align-rules-list
                '(haskell-left-arrows
                  (regexp . "\\(\\s-+\\)\\(<-\\|←\\)\\s-+")
                  (modes quote (haskell-mode literate-haskell-mode)))))

(load-library "inf-haskell")

(defun my-inf-haskell-hook ()
  (setq comint-prompt-regexp
        (concat comint-prompt-regexp "\\|^.> ")))

(add-to-list 'inferior-haskell-mode-hook 'my-inf-haskell-hook)

;;; haskell-custom.el ends here
