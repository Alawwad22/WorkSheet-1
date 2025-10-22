%include "asm_io.inc"           ; Include I/O macros and declarations

segment .data
    integer1 dd 15              ; first integer
    integer2 dd 6               ; second integer
    plus     db " + ", 0        ; string for " + "
    equal    db " = ", 0        ; string for " = "
    nl       db 10, 0           ; newline

segment .bss
    result   resd 1             ; reserve space for result

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ; compute result
    mov     eax, [integer1]
    add     eax, [integer2]
    mov     [result], eax

    ; print "15 + 6 = 21"
    mov     eax, [integer1]
    call    print_int           ; print first number

    mov     eax, plus
    call    print_string        ; print " + "

    mov     eax, [integer2]
    call    print_int           ; print second number

    mov     eax, equal
    call    print_string        ; print " = "

    mov     eax, [result]
    call    print_int           ; print result

    mov     eax, nl
    call    print_string        ; newline

    popa
    mov     eax, 0
    leave
    ret
