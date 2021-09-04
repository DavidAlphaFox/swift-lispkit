;;; Procedures.scm
;;; Regression test data
;;;
;;; Author: Matthias Zenger
;;; Copyright © 2021 ObjectHub. All rights reserved.
;;;
;;; Licensed under the Apache License, Version 2.0 (the "License");
;;; you may not use this file except in compliance with the License.
;;; You may obtain a copy of the License at
;;;
;;;      http://www.apache.org/licenses/LICENSE-2.0
;;;
;;; Unless required by applicable law or agreed to in writing, software
;;; distributed under the License is distributed on an "AS IS" BASIS,
;;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;; See the License for the specific language governing permissions and
;;; limitations under the License.

(
  "Procedure predicates"
  (#f #t #t #t #f #f #t #t)
  (list (procedure? '(+ 1 2))
        (procedure? (lambda args 1))
        (procedure? (thunk (define x 1) (+ x 10)))
        (thunk? (thunk (define x 1) (+ x 10)))
        (thunk? (lambda (x) (+ x 1)))
        (procedure-of-arity? "string" 12)
        (procedure-of-arity? (lambda (x y z) (+ x y z)) 3)
        (procedure-of-arity? (lambda (x . args) (+ x y z)) 3))
)

(
  "Procedure arity"
  ((0 . 0) (1 . 1) (1 . 1) (0 . #f) (1 . #f))
  (list (procedure-arity (lambda () 3))
        (procedure-arity (lambda (x) x))
        (procedure-arity car)
        (procedure-arity (lambda x x))
        (procedure-arity (lambda (x . y) x)))
)

(
  "Case-lambda arity"
  ((0 . 1) (2 . 6) (1 . #f) (0 . #f) (2 . 2) (3 . #f) #t #f #t #f #t #f #t #t #f #t #f)
  (define (plus x y) (+ x y))
  (define (sum x y z . args) 0)
  (define foo (case-lambda
    (() 0)
    ((x) 1)))
  (define bar (case-lambda
    ((a b) 2)
    ((a b c d) 4)
    ((a b c d e f) 6)))
  (define goo (case-lambda
    ((a b c) 3)
    ((a b) 2)
    ((a . args) 1)))
  (define baz (case-lambda
    (args 0)))
  (list (procedure-arity foo)
        (procedure-arity bar)
        (procedure-arity goo)
        (procedure-arity baz)
        (procedure-arity plus)
        (procedure-arity sum)
        (procedure-arity-valid? foo 0)
        (procedure-arity-valid? foo 2)
        (procedure-arity-valid? bar 6)
        (procedure-arity-valid? bar 5)
        (procedure-arity-valid? goo 4)
        (procedure-arity-valid? goo 0)
        (procedure-arity-valid? baz 9)
        (procedure-arity-valid? plus 2)
        (procedure-arity-valid? plus 1)
        (procedure-arity-valid? sum 3)
        (procedure-arity-valid? sum 2))
)
