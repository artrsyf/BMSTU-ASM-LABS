%include "io.inc"

section .data
    start_msg db "Enter a, b:", 10, 13, 0
    optional_msg db "Enter k:", 10, 13, 0
    result_msg db "Result is: f = ", 0
    end_line db 10, 13, 0
    
section .bss
    a resw 10
    b resw 10
    k resw 10
    f resw 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp ; Debugging
    xor eax, eax ; eax clearing
    PRINT_STRING start_msg
    
    GET_DEC 4, [a]
    GET_DEC 4, [b]
    mov eax, [a]
    add eax, [b]
    
    cmp eax, 0
    jg TRUE_LABEL ; If true
    jmp CONTINUE ; If false
    
TRUE_LABEL:
    PRINT_STRING optional_msg
    GET_DEC 4, [k]
    
    mov eax, [a]
    mov ebx, [b]
    mov ecx, [k]
    
    imul eax, ebx
    cdq
    idiv ecx
    jmp CONTINUE


CONTINUE:
    PRINT_STRING result_msg
    mov [f], eax
    PRINT_DEC 4, [f]
    PRINT_STRING end_line
    ret    
