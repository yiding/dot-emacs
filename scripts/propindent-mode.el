(defun propindent--whitespace-columns ()
  (looking-at " *")
  (- (match-end 0) (match-beginning 0)))

(defun propindent--line-columns ()
  (- (line-end-position) (line-beginning-position)))

(defun propindent--move-to-alignment-line ()
  (let ((columns (propindent--whitespace-columns)))
    (forward-line -1)
    (while (not (< (propindent--whitespace-columns) columns (propindent--line-columns)))
      (forward-line -1))))

(defun propindent--get-alignment-width ()
  (save-excursion
    (let ((columns (propindent--whitespace-columns)))
      (if (<= columns 0)
          (cons 0 0)
        (propindent--move-to-alignment-line)
        (let* ((parent-width (propindent--get-alignment-width))
               (parent-columns (car parent-width))
               (parent-pixels (cdr parent-width))
               (pixel-size
                (window-text-pixel-size nil
                                        (+ (point) parent-columns)
                                        (+ (point) columns))))
          (cons columns
                (+ parent-pixels (car pixel-size))))))))

(defun propindent--align-whitespace (from to)
  (let* ((width
          (save-excursion
            (goto-char from)
            (propindent--get-alignment-width)))
         (pixels (cdr width)))
    (put-text-property from to 'display `(space :width (,pixels)))))

(defconst propindent--font-lock-keywords
  `(("^ +"
     (0 (progn
          (propindent--align-whitespace (match-beginning 0) (match-end 0))
          nil)))))

(define-minor-mode propindent-mode
  nil
  :lighter " Propindent"
  (if (and propindent-mode window-system)
      (progn
        (variable-pitch-mode 1)
        (add-to-list 'font-lock-extra-managed-props 'display)
        (font-lock-add-keywords nil propindent--font-lock-keywords t))
    (font-lock-remove-keywords nil propindent--font-lock-keywords)
    (remove 'display 'font-lock-extra-managed-props)
    (variable-pitch-mode -1)))

(provide 'propindent-mode)
