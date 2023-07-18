#lang racket/base

(provide (struct-out vec2) vec2+)

(require dispatch)

(struct vec2 (x y))

(define/dispatch (vec2+ [a vec2?]
                        [b vec2?])
  (vec2 (+ (vec2-x a) (vec2-x b))
        (+ (vec2-y a) (vec2-y b))))
