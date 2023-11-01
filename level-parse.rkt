#lang racket/base

(require (for-syntax
          syntax/parse
          racket/base
          racket/syntax)
         racket/string
         threading
         "world-tile.rkt"
         "list2.rkt"
         "level.rkt"
         "vec2.rkt")

(provide define-level)

(define (level-str->symbols str)
  (map (λ~>> string->list
         (map (λ~> string string->symbol)))
       (string-split str "\n")))

(define-syntax-rule
  (define-level name
    [char tile] ...
    level-str)
  (define name
    (let ([tile-map (make-hash)])
      (hash-set! tile-map 'char tile) ...
      (define tiles
        (map/2d (λ~>> (hash-ref tile-map))
                (level-str->symbols level-str)))
      (define width (apply max (map length tiles)))
      (define height (length tiles))
      (level 'name (vec2 width height) tiles))))
