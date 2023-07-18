#lang racket/base

(provide (all-from-out "vec2.rkt")
         (all-from-out "list2.rkt")
         (struct-out 2htdp/color)
         assoc-ref
         color
         transparent)

(require (rename-in 2htdp/image
                    [color 2htdp/color])
         dispatch memo
         "list2.rkt" "vec2.rkt")

(define (assoc-ref v lst)
  (cadr (assoc v lst)))

(define/memoize (color r g b)
  (2htdp/color r g b))

(define transparent (2htdp/color 0 0 0 0))
