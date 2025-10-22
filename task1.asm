%include "asm_io.inc"       ; Include I/O macros and function declarations

segment .data
    integer1 dd 15           ; first integer
    integer2 dd 6            ; second integer

segment .bss
    result   resd 1          ; reserve space for result

segment .text
    global asm_main

asm_main:
    pusha                    ; save all registers

    mov eax, [integer1]      ; load first integer into eax
    add eax, [integer2]      ; add second integer
    mov [result], eax        ; store result in memory

    call print_int           ; print value in eax
    call print_nl            ; optional: print newline (if available)

    popa                     ; restore registers
    mov eax, 0               ; return 0 to C (normal exit)
    ret
