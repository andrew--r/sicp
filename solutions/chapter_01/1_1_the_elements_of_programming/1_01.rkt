#lang racket

; Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented.

10
; 10

(+ 5 3 4)
; 12

(- 9 1)
; 8

(/ 6 2)
; 3

(+ (* 2 4) (- 4 6))
; (+ 8 (- 2))
; 6

(define a 3)
; 3

(define b (+ a 1))
; 4

(+ a b (* a b))
; (+ 3 4 (* 3 4))
; (+ 3 4 12)
; 19

(= a b)
; #f

(if (and (> b a) (< b (* a b)))
    b
    a)
; (and (> 4 3) (< 4 (* 3 4)))
; (and #t #t)
; #t
; 4

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; (= a 4) #f
; (= b 4) #t
; (+ 6 7 a)
; (+ 6 7 3)
; 16

(+ 2 (if (> b a) b a))
; (> b a) #t
; (+ 2 b)
; (+ 2 4)
; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
; (* 4 (+ a 1))
; (* 4 (+ 3 1))
; 16
