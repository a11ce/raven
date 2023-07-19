#lang racket/base

(require (except-in 2htdp/image color) 2htdp/universe
         racket/match
         "util.rkt"
         "font.rkt"
         "world-tiles.rkt")

(define WIDTH 20)
(define HEIGHT 10)


(define tileimg-size 16)

(struct object (pos tileimg))
(struct level (dims tiles))
(struct state (level player))

(define (make-default-level width height)
  (level (vec2 width height)
         (for/list ([h height])
           (for/list ([w width])
             (if (and (= h 4) (not (= w 2)))
                 stone-wall
                 grass-floor)))))

(define (init)
  (state (make-default-level WIDTH HEIGHT)
         (object (vec2 0 0)
                 (char/color->tileimg "@" (color 161 28 224)
                                      (color 27 27 27)))))

(define (render level player)
  (define floor (overlay/align
                 "left" "top"
                 (apply above
                        (map (λ (row)
                               (apply beside
                                      (map render-world-tile row)))
                             (level-tiles level)))
                 (rectangle (* WIDTH tileimg-size)
                            (* HEIGHT tileimg-size)
                            'solid 'black)))
  (scale 2 (draw-object floor player)))

(define (render-world-tile tile)
  (world-tile-tileimg tile))

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
