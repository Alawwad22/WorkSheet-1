%include "asm_io.inc"

segment .data
    msgSum  db "Sum 1..100 = ", 0
    nl      db 10, 0

segment .bss
    arr     resd 100
    sum     resd 1

segment .text
global asm_main
asm_main:
    enter 0,0
    pusha

    ; arr[i] = i+1
    xor     ecx, ecx                ; i = 0
.init:
    cmp     ecx, 100
    jge     .sum_start
    mov     eax, ecx
    inc     eax                     ; i+1
    mov     [arr + ecx*4], eax
    inc     ecx
    jmp     .init

.sum_start:
    xor     ecx, ecx                ; i = 0
    xor     eax, eax                ; eax = running sum
.sum_loop:
    cmp     ecx, 100
    jge     .after_sum
    add     eax, [arr + ecx*4]
    inc     ecx
    jmp     .sum_loop

.after_sum:
    mov     [sum], eax
    mov     eax, msgSum
    call    print_string
    mov     eax, [sum]
    call    print_int
    mov     eax, nl
    call    print_string

    popa
    mov     eax, 0
    leave
    ret
