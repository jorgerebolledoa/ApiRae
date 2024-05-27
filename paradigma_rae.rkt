#lang racket
(require request)
(require json)
(require net/url)


(display "Ingresa una palabra: ")
(define word (read-line))


(define str1 "http://localhost:3000/api/")
;(define str3 "martillo")
(define result (string-append str1 word))


;(define refino lambda(entrada))
;  cond  

(define (make-http-request url)
  (define response (get-pure-port url))
  (cond
    ((port? response)
     (let ((body (port->string response)))
       (display "Response body: ")
       (newline)
       (displayln body)))
;       (refino url->string body)
    (else
     (displayln "Error: Failed to make HTTP request"))))

(make-http-request (string->url result)) 




