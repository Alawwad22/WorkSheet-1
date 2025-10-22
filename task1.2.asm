%include "asm_io.inc"

segment .data
    msg1 db "Enter a number: ", 0
    msg2 db "The sum of ", 0
    msg3 db " and ", 0
    msg4 db " is: ", 0

segment .bss
    integer1 resd 1         ; first integer
    integer2 resd 1         ; second integer
    result   resd 1         ; result

segment .text
    global asm_main

asm_main:
    pusha

    ; --- Read first integer ---
    mov eax, msg1            ; print "Enter a number: "
    call print_string
    call read_int            ; read first integer
    mov [integer1], eax      ; store in memory

    ; --- Read second integer ---
    mov eax, msg1            ; print "Enter a number: "
    call print_string
    call read_int            ; read second integer
    mov [integer2], eax      ; store in memory

    ; --- Compute sum ---
    mov eax, [integer1]      ; load first integer
    add eax, [integer2]      ; add second integer
    mov [result], eax        ; store result

    ; --- Print formatted result ---
    mov eax, msg2            ; "The sum of "
    call print_string

    mov eax, [integer1]      ; print first integer
    call print_int

    mov eax, msg3            ; " and "
    call print_string

    mov eax, [integer2]      ; print second integer
    call print_int

    mov eax, msg4            ; " is: "
    call print_string

    mov eax, [result]        ; print result
    call print_int
    call print_nl

    ; --- Exit ---
    popa
    mov eax, 0
    ret
