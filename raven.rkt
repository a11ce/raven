#lang racket/base

(require (except-in 2htdp/image color) 2htdp/universe
         racket/match
         "util.rkt"
         "font.rkt"
         "render.rkt"
         "level.rkt" ; remove!
         "world-tile.rkt" ; remove!
         (prefix-in game: "test-data.rkt"))

(define tileimg-size 16)

(struct object (pos tileimg))
(struct state (level player))

(define (init)
  (state game:courtyard
         (object (vec2 1 1)
                 (char/color->tileimg "@" (color 161 28 224)
                                      (color 27 27 27)))))

(define (render level player)
  (define floor (render-level level))
  (scale 2 (draw-object floor player)))

(define (draw-object floor object)
  (define xy (object-pos object))
  (define x (vec2-x xy))
  (define y (vec2-y xy))
  (overlay/align/offset
   "left" "top" (object-tileimg object)
   (* -1 x tileimg-size)
   (* -1 y tileimg-size) floor))

(define (movable-location? w pos)
  (define tile (list2-ref (level-tiles (state-level w)) pos))
  (and tile
       (world-tile-walkable? tile)))

(define (try-move-player w dir)
  (define new-pos (vec2+ dir (object-pos (state-player w))))
  (if (movable-location? w new-pos)
      (struct-copy state w
                   [player
                    (struct-copy object (state-player w)
                                 [pos new-pos])])
      w))

(define (handle-key state key)
  (cond
    [(key=? key "left")
     (try-move-player state (vec2 -1 0))]
    [(key=? key "right")
     (try-move-player state (vec2 1 0))]
    [(key=? key "up")
     (try-move-player state (vec2 0 -1))]
    [(key=? key "down")
     (try-move-player state (vec2 0 1))]
    [else state]))

(big-bang (init)
  (to-draw (λ (s) (render (state-level s)
                          (state-player s))))
  (on-key (λ (s k) (handle-key s k))))
