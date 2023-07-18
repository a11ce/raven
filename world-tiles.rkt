#lang racket/base

(require "font.rkt"
         "util.rkt")

(provide (struct-out world-tile) grass-floor stone-wall)

(struct world-tile (tileimg walkable) #:transparent)

(define grass-floor (world-tile
                     (char/color->tileimg "." (color 50 100 50)
                                          (color 27 27 27)) #t))

(define stone-wall (world-tile (char/color->tileimg "stone-wall"
                                                    (color 100 100 100)
                                                    (color 27 27 27))
                               #f))
