;;; SRFI 208
;;; NaN procedures
;;;
;;; This SRFI provides procedures that dissect NaN (Not a Number) inexact values. 
;;; IEEE 754:2008 is a standard for floating point numbers used on essentially all modern
;;; CPUs that have hardware floating point support. It specifies a set of floating-point
;;; values known as NaNs, i.e. "Not A Number". They are generated by such operations
;;; as `(/ 0.0 0.0)`, the mathematical result of which could be any number whatsoever, and
;;; by `(flsqrt -1.0)` from SRFI 144, the result of which cannot be any floating-point
;;; number. Scheme implementations that conform to R7RS use the external representations
;;; `+nan.0` and `-nan.0` for NaNs, and the procedure `nan?` will return `#t` when applied
;;; to any inexact real number (on R7RS systems, any inexact number) that is a NaN.
;;; In fact, however, there are 252 - 1 possible NaN values, assuming the representation
;;; is an IEEE binary64 float. This SRFI makes it possible to dissect a NaN to see which
;;; of these internal representations it corresponds to.
;;; 
;;; Author of spec: Emmanuel Medernach, John Cowan
;;; 
;;; Copyright © 2022 Matthias Zenger. All rights reserved.
;;;
;;; Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
;;; file except in compliance with the License. You may obtain a copy of the License at
;;;
;;;   http://www.apache.org/licenses/LICENSE-2.0
;;;
;;; Unless required by applicable law or agreed to in writing, software distributed under
;;; the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
;;; ANY KIND, either express or implied. See the License for the specific language
;;; governing permissions and limitations under the License.

(define-library (srfi 208)
  
  (export make-nan
          nan-negative?
          nan-quiet?
          nan-payload
          nan=?)
  
  (import (lispkit base)
          (rename (lispkit internal) (make-nan internal-make-nan)))
  
  (begin
    
    (define (make-nan neg quiet payload . args)
      (internal-make-nan neg quiet payload))
    
    (define (nan=? nan1 nan2)
      (assert (nan? nan1) (nan? nan2))
      (flbits=? nan1 nan2))
  )
)
