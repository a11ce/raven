#lang racket/base

(require "font.rkt"
         "util.rkt")

(provide (struct-out world-tile))

(struct world-tile (tileimg walkable?) #:transparent)
