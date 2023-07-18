#lang racket/base

(provide char->tileimg
         char/color->tileimg
         color-tileimg)

(require (except-in 2htdp/image color)
         racket/match
         memo
         "util.rkt")

; mostly copied from github.com/Eugleo/roguelike

(define tilemap-size (vec2 16 15))
(define tile-size (vec2 16 16))

(define tilemap
  (let ([full (bitmap/file "tiles.png")]
        [tile-width (vec2-x tile-size)]
        [tile-height (vec2-y tile-size)])
    (for/list ([y (vec2-y tilemap-size)])
      (for/list ([x (vec2-x tilemap-size)])
        (crop (* x tile-width)
              (* y tile-height)
              (vec2-x tile-size)
              (vec2-y tile-size)
              full)))))

(define tiledict
  (map (λ (t)
         (list (car t)
               (list2-ref tilemap (cadr t))))
       '(("@" (0 4))
         ("." (14 2))
         ("stone-wall" (2 11)))))

(define (char->tileimg char)
  (assoc-ref char tiledict))

(define/memoize (char/color->tileimg char fg bg)
  #:hash hash
  (color-tileimg
   (char->tileimg char)
   fg bg))

(define/memoize (color-tileimg tile fg bg)
  (define pix (image->color-list tile))
  (define new-pix (map (match-lambda
                         [(2htdp/color x y z 0) bg]
                         [(2htdp/color x y z 255) fg])
                       pix))
  (color-list->bitmap new-pix (vec2-x tile-size)
                      (vec2-y tile-size)))
