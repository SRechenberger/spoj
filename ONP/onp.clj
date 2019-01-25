(ns onp.core
  (:gen-class))

(declare shift)
(declare simplify)
(declare transform)

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (let [times (try
                (. Integer parseInt (read-line))
                (catch Exception e nil))]
    (loop [i times]
      (println (transform (read-line)))
      (if (> i 1)
        (recur (dec i))))))

(defn shift [stack c]
  (cons c stack))

(defn simplify [[b op a & stk]]
  (cons (str a b op) stk))

(defn transform [expr]
  (loop [stk []
         e   expr]
    (cond
      (empty? e)           (first stk)
      (= "(" (subs e 0 1)) (recur stk (subs e 1))
      (= ")" (subs e 0 1)) (recur (simplify stk) (subs e 1))
      :else                (recur (shift stk (subs e 0 1)) (subs e 1)))))

(-main)