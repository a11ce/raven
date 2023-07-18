#lang racket/base

(provide list2-ref)

(require dispatch
         "vec2.rkt")

(define/dispatch (list2-ref [list2 list?]
                            [x number?]
                            [y number?])
  (list-ref
   (list-ref list2 y) x))


(define/dispatch (list2-ref [list2 list?]
                            [pos vec2?])
  (list2-ref list2 (vec2-x pos) (vec2-y pos)))

(define/dispatch (list2-ref [list2 list?]
                            [pos list?])
  (list2-ref list2 (car pos) (cadr pos)))
