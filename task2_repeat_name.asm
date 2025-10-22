%include "asm_io.inc"

%define MAX_NAME 128

segment .data
    askName   db "Enter your name: ", 0
    askCount  db "How many times (must be > 50 and < 100)? ", 0
    errMsg    db "Error: number must be > 50 and < 100.", 10, 0
    hello1    db "Welcome, ", 0
    hello2    db "!", 10, 0

segment .bss
    nameBuf   resb MAX_NAME
    count     resd 1

segment .text
global asm_main
asm_main:
    enter 0,0
    pusha

    ; --- read name into nameBuf ---
    mov     eax, askName
    call    print_string
    mov     edi, nameBuf
    mov     ecx, MAX_NAME-1
.read_loop:
    call    read_char          ; AL=char
    cmp     al, 10             ; newline?
    je      .terminate
    cmp     ecx, 0
    je      .terminate
    mov     [edi], al
    inc     edi
    dec     ecx
    jmp     .read_loop
.terminate:
    mov     byte [edi], 0

    ; --- read count ---
    mov     eax, askCount
    call    print_string
    call    read_int
    mov     [count], eax

    ; check 51..99 (strictly greater than 50, less than 100)
    mov     eax, [count]
    cmp     eax, 51
    jl      .bad
    cmp     eax, 99
    jg      .bad

    ; --- print ECX times ---
    mov     ecx, [count]
.print_loop:
    cmp     ecx, 0
    jle     .done_ok
    mov     eax, hello1
    call    print_string
    mov     eax, nameBuf
    call    print_string
    mov     eax, hello2
    call    print_string
    dec     ecx
    jmp     .print_loop

.bad:
    mov     eax, errMsg
    call    print_string
    jmp     .finish

.done_ok:
    ; fallthrough

.finish:
    popa
    mov     eax, 0
    leave
    ret
