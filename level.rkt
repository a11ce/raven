#lang racket/base

(require (except-in 2htdp/image color))

(provide (struct-out level))

(struct level (name dims tiles)
  #:property prop:custom-write
  (λ (s port mode)
    (fprintf port "<level:~a>" (level-name s))))
