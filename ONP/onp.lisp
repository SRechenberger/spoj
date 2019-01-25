(defvar stk '())

(defun init ()
  (setf stk '()))

(defun red ()
  (let ((b (pop stk))
    (o (pop stk))
    (a (pop stk)))
    (push (concatenate 'string a b o) stk)))

(defun shift (char)
  (push (coerce `(,char) 'string) stk))

(defun reduce-one-expr (expr)
  (loop for c across expr
     do
       (cond
     ((equal c #\() nil)
     ((equal c #\)) (red))
     (t (shift c))))
  (car stk))

(defun main ()
  (let ((cases (read)))
    (loop for i from 1 to cases
       do
     (format t "~a~%" (reduce-one-expr (read-line))))))

(main)