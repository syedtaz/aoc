(def mapping @{
  "one" 1
  "two" 2
  "three" 3
  "four" 4
  "five" 5
  "six" 6
  "seven" 7
  "eight" 8
  "nine" 9
  "zero" 0
  "1" 1
  "2" 2
  "3" 3
  "4" 4
  "5" 5
  "6" 6
  "7" 7
  "8" 8
  "9" 9
  "0" 0
})

(def rmapping (table ;(mapcat identity (map (fn [pair] [(string/reverse (get pair 0)) (get pair 1)]) (pairs mapping)))))

(defn findaux [key mapping text acci accv]
  (cond 
    (= key nil) accv
    (let [
      vl (get mapping key)
      i (string/find key text)
    ]
    (if (<= i acci)
      (findaux (next mapping key) mapping text i vl)
      (findaux (next mapping key) mapping text acci accv)))))

(defn find 
 [{:mapping mapping
    :text text}]
  (findaux (next mapping nil) mapping text (length text) 0))

(defn f [text] 
  (let [
    fst (find {:mapping mapping :text text})
    snd (find {:mapping rmapping :text (string/reverse text)})
  ] 
  (+ (* 10 fst) snd)))

(defn run [fpath]
  (with [fl (file/open fpath)]
    (var acc 0)
    (loop [line :iterate (file/read fl :line)]
      (+= acc (f line)))
    acc
  ))

(let [
  args (dyn :args)
] 
  (print (run (get args 1))))
