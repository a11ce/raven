#lang racket

(require "level-parse.rkt"
         "world-tile.rkt"
         "util.rkt"
         "font.rkt")

(provide courtyard)


(define grass-floor (world-tile
                     (char/color->tileimg "."
                                          (color 50 100 50)
                                          (color 27 27 27))
                     #t))

(define stone-wall (world-tile
                    (char/color->tileimg "stone-wall"
                                         (color 100 100 100)
                                         (color 27 27 27))
                    #f))

(define-level courtyard
  [X stone-wall]
  [- grass-floor]
  #<<L
XXXXXXXXXXXXXX
X------------X
X------------X
X------------X
X------------X
XXXXXXXXXXXXXX
L
  )
