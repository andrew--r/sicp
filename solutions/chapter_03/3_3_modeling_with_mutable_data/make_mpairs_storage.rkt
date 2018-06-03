#lang racket
(require compatibility/mlist)

(provide make-mpairs-storage)

(define (make-mpairs-storage)
  (let ((storage (mlist)))
    (define (contains? item)
      (define (inner temp-storage)
        (cond ((null? temp-storage) false)
          ((eq? (mcar temp-storage) item) true)
          (else (inner (mcdr temp-storage)))))
      (inner storage))

    (define (add x)
      (set! storage (mcons x storage)))

    (lambda (message)
      (cond ((eq? message 'contains?) contains?)
          ((eq? message 'add) add)
          (else (error "Unknown operation on mpairs-storage"))))))

(module+ test
  (require rackunit)
  (test-case "make-mpairs-storage"
    (define counted-mpairs (make-mpairs-storage))

    (define a (mcons 'a 'a))
    (define b (mcons 'b 'b))
    (define c (mcons 'c 'c))

    (check-equal? ((counted-mpairs 'contains?) a) false)
    (check-equal? ((counted-mpairs 'contains?) b) false)
    (check-equal? ((counted-mpairs 'contains?) c) false)

    ((counted-mpairs 'add) a)
    (check-equal? ((counted-mpairs 'contains?) a) true)
    (check-equal? ((counted-mpairs 'contains?) b) false)
    (check-equal? ((counted-mpairs 'contains?) c) false)

    ((counted-mpairs 'add) c)
    (check-equal? ((counted-mpairs 'contains?) a) true)
    (check-equal? ((counted-mpairs 'contains?) b) false)
    (check-equal? ((counted-mpairs 'contains?) c) true)

    ((counted-mpairs 'add) b)
    (check-equal? ((counted-mpairs 'contains?) a) true)
    (check-equal? ((counted-mpairs 'contains?) b) true)
    (check-equal? ((counted-mpairs 'contains?) c) true)
  ))
