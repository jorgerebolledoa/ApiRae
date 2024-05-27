#lang racket
(require request)
(require json)
(require net/url)

(display "Ingresa una palabra: ")
(define word (read-line))

(define str1 "http://localhost:3000/api/")
(define result (string-append str1 word))

(define (format-definiciones definicion)
  (string-join (string-split definicion #px"\d+\. ") "\n\n"))

(define (make-http-request url)
  (define response (get-pure-port url))
  (cond
    ((port? response)
     (let* ((body (port->string response))
            (json-data (string->jsexpr body)))
       (cond
         ((hash? json-data)
          (let ((palabra (hash-ref json-data 'palabra))
                (definicion (hash-ref json-data 'definicion)))
            (displayln (string-append "Palabra: " palabra))
            (displayln "Definiciones:")
            (displayln (format-definiciones definicion))))
         (else
          (displayln "Error: Respuesta no es un JSON válido")))))
    (else
     (displayln "Error: Failed to make HTTP request"))))

(make-http-request (string->url result))



