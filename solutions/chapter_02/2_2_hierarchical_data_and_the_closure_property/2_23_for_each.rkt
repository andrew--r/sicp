#lang racket

(define (for-each fn items)
  (define (proceed)
    (fn (car items))
    (for-each fn (cdr items))
    )
        
  (if (null? items)
      true
      (proceed)
      )
  )
