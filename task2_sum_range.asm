%include "asm_io.inc"

segment .data
    askLo   db "Enter start of range [1..100]: ", 0
    askHi   db "Enter end of range [1..100]: ", 0
    err     db "Invalid range.", 10, 0
    msg     db "Range sum = ", 0
    nl      db 10, 0

segment .bss
    arr     resd 100
    lo      resd 1
    hi      resd 1
    sum     resd 1

segment .text
global asm_main
asm_main:
    enter 0,0
    pusha

    ; init arr[i] = i+1
    xor     ecx, ecx
.init:
    cmp     ecx, 100
    jge     .ask
    mov     eax, ecx
    inc     eax
    mov     [arr + ecx*4], eax
    inc     ecx
    jmp     .init

.ask:
    mov     eax, askLo
    call    print_string
    call    read_int
    mov     [lo], eax

    mov     eax, askHi
    call    print_string
    call    read_int
    mov     [hi], eax

    ; validate 1 <= lo <= hi <= 100
    mov     eax, [lo]
    cmp     eax, 1
    jl      .bad
    cmp     eax, 100
    jg      .bad
    mov     edx, [hi]
    cmp     edx, 1
    jl      .bad
    cmp     edx, 100
    jg      .bad
    cmp     eax, edx
    jg      .bad

    ; sum arr[lo-1 .. hi-1]
    mov     ecx, [lo]          ; ecx = current index (1-based)
    mov     edx, [hi]          ; edx = end (1-based)
    xor     eax, eax           ; eax = sum
.loop:
    cmp     ecx, edx
    jg      .done
    mov     ebx, ecx
    dec     ebx                ; 0-based index
    shl     ebx, 2             ; *4
    add     eax, [arr + ebx]
    inc     ecx
    jmp     .loop

.done:
    mov     [sum], eax
    mov     eax, msg
    call    print_string
    mov     eax, [sum]
    call    print_int
    mov     eax, nl
    call    print_string
    jmp     .finish

.bad:
    mov     eax, err
    call    print_string

.finish:
    popa
    mov     eax, 0
    leave
    ret