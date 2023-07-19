#lang racket/base

(provide list2-ref)

(require dispatch
         "vec2.rkt")

(define/dispatch (list2-ref [list2 list?]
                            [x number?]
                            [y number?])
  (if (and (< -1 y (length list2))
           (< -1 x (length (car list2))))
      (list-ref
       (list-ref list2 y) x)
      #f))


(define/dispatch (list2-ref [list2 list?]
                            [pos vec2?])
  (list2-ref list2 (vec2-x pos) (vec2-y pos)))

(define/dispatch (list2-ref [list2 list?]
                            [pos list?])
  (list2-ref list2 (car pos) (cadr pos)))
