;; EQC Emacs Mode -- Configuration Start
(add-to-list 'load-path "/usr/local/erlang-17.4/lib/erlang/lib/eqc-1.34.2")
(autoload 'eqc-erlang-mode-hook "eqc-ext" "EQC Mode" t)
(add-hook 'erlang-mode-hook 'eqc-erlang-mode-hook)
(setq eqc-max-menu-length 30)
(setq eqc-root-dir "/usr/local/erlang-17.4/lib/erlang/lib/eqc-1.34.2")
;; EQC Emacs Mode -- Configuration End

;; Erlang Emacs Mode -- Configuration Start
(setq erlang-root-dir "/usr/local/erlang-17.4")
(setq load-path (cons "/usr/local/erlang-17.4/lib/erlang/lib/tools-2.7.1/emacs" load-path))
(setq exec-path (cons "/usr/local/erlang-17.4/bin" exec-path))
(require 'erlang-start)
;; Erlang Emacs Mode -- Configuration End

;; cleanup on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq magit-last-seen-setup-instructions "1.4.0")

;; Desktop save
(desktop-save-mode 1)

;; Run in daemon mode
(server-start)
