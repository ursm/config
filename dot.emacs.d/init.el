(setq load-path
      (cons (expand-file-name "~/.emacs.d/site-lisp")
            load-path))

;; C-h をバックスペースに
(keyboard-translate ?\C-h ?\C-?)
(keyboard-translate ?\C-? ?\C-?)

(setq default-frame-alist
      (append (list '(width . 111)
                    '(height . 64)
                    '(alpha . (90 90)))
              default-frame-alist))

;; リージョンに色を付ける
(setq transient-mark-mode t)

;; スタートアップメッセージを非表示
(setq inhibit-startup-message t)

(if window-system
    (progn
      ;; ツールバーを非表示
      (tool-bar-mode 0)

      ;; ウィンドウタイトルをファイル名に
      (setq frame-title-format "%b")

      ;; スクロールバーを右に
      (set-scroll-bar-mode 'right)

      (require 'color-theme)
      (if (not (eq emacs-major-version 23))
	  (color-theme-initialize))
      (color-theme-dark-laptop)

      (if (eq system-type 'gnu/linux)
	  ((set-default-font "Bitstream Vera Sans Mono-10")
	   (set-fontset-font (frame-parameter nil 'font)
			     'japanese-jisx0208
			     '("IPAGothic" . "unicode-bmp"))))
      ))

;; 1行ずつスクロール
(setq scroll-step 1)

;; ビープ音を消す
(setq ring-bell-function 'ignore)

;; 行末の空白を強調表示
(when (boundp 'show-trailing-whitespace)
  (setq-default show-trailing-whitespace t))

(require 'iswitchb)
(iswitchb-default-keybindings)

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when
      (and
       (eq iswitchb-method iswitchb-default-method)
       iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

(defadvice iswitchb-completions
  (after
   iswitchb-completions-with-file-name
   activate)
  "選択してるときにファイル名とかを出してみる。"
  (when iswitchb-matches
    (save-excursion
      (set-buffer (car iswitchb-matches))
      (setq ad-return-value
            (concat ad-return-value "\n"
                    (cond ((buffer-file-name)
                           (concat "file: "
                                   (expand-file-name (buffer-file-name))))
                          ((eq major-mode 'dired-mode)
                           (concat "directory: "
                                   (expand-file-name dired-directory)))
                          (t (concat "mode: " mode-name " Mode"))))))))

(require 'mcomplete)
(turn-on-mcomplete-mode)

(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)
(setq browse-kill-ring-display-style 'one-line)
(setq browse-kill-ring-highlight-current-entry t)
