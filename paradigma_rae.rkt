#lang racket

(require request)
(require json)
(require net/url)

; Define a function that splits a sentence into words
(define (split-sentence sentence)
  (string-split sentence))

; Read a sentence from the user
(display "Introduce una frase: ")
(define user-input (read-line))

; Split the sentence into words
(define words (split-sentence user-input))

; Function to format definitions
(define (format-definiciones definicion)
  (string-join (string-split definicion #px"\\d+\\. ") "\n\n"))

; Function to make an HTTP request and print the response
(define (make-http-request word)
  (define url (string-append "http://localhost:3000/api/" word))
  (define response (get-pure-port (string->url url)))
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

; Iterate over each word and make HTTP request
(for-each make-http-request words)
