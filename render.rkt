#lang racket

(require (except-in 2htdp/image color)
         "vec2.rkt"
         "level.rkt"
         "world-tile.rkt")

(provide render-level)

(define *tileimg-size* 16)

(define (render-world-tile tile)
  (world-tile-tileimg tile))

(define (render-level level)
  (overlay/align
   "left" "top"
   (apply above
          (map (λ (row)
                 (apply beside
                        (map render-world-tile row)))
               (level-tiles level)))
   (rectangle (* (vec2-x (level-dims level)) *tileimg-size*)
              (* (vec2-y (level-dims level)) *tileimg-size*)
              'solid 'black)))
