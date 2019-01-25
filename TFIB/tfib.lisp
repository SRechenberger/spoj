;;;; How many fucking fibs

(defvar r1 1)
(defvar r2 2)

(defvar n 0)

(defvar fibs 0)

(defun calc-next-fib ()
  (cond
    ((= n 0) r1)
    ((= n 1) r2)
    ((= (mod n 2) 0) (setf r1 (+ r1 r2)))
    ((= (mod n 2) 1) (setf r2 (+ r1 r2)))))

(defun how-many-fibs? (a b)
  (setf fibs 0)
  (setf n 0)
  (setf r1 1)
  (setf r2 2)
  (loop
     do
       ; (format t "<fibs = ~a; n = ~a; r1 = ~a; r2 = ~a>~%" fibs n r1 r2)
       (let
       ((curr (calc-next-fib)))
     (cond
       ((> curr b) (return))
       ((>= curr a) (incf fibs))))
       (incf n))
  fibs)


(defun main ()
  (let ((a (read))
    (b (read)))
    (loop
       do
     (cond
       ((= a b 0) (return))
       (t (progn
        (format t "~a~%" (how-many-fibs? a b))
        (setf a (read))
        (setf b (read))))))))

(main)