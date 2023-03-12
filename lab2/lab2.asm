%include "io.inc"

section .data
    msg: db "Enter q, a: ",10, 13, 0
    res_msg: db "s = q**3 – 2 * a * q + a**2 / q = ", 0
    new_line: db 10, 13, 0
    error: db "Empty input or division by zero", 10, 13, 0


section .bss
    q resw 10
    a resw 10
    s resw 10

section .text
global CMAIN

ERROR:
    PRINT_STRING error
    ret

CMAIN:
    mov ebp, esp ; Debugger
    xor eax,eax ; EAX cleaning
    PRINT_STRING msg
    GET_DEC 4,[q]
    GET_DEC 4,[a]
    mov ecx, [q]
    mov edx, [a]
    
    cmp ecx, 0
    je ERROR
    cmp edx, 0
    je ERROR
    
 
    mov ebx, [q]
    imul ebx, ecx
    imul ebx, ecx
    add eax, ebx
 
    mov ebx, 2
    imul ebx, ecx
    imul ebx, edx
    sub eax, ebx
 
    mov ebx, edx
    imul ebx, edx
    xchg eax, ebx
    cdq
    idiv ecx
    add ebx, eax
 
    mov [s],ebx
    PRINT_STRING res_msg
    PRINT_DEC 4,[s] ; PRINT_DEC <size>, <literal> size - number of bytes allowd to print
    PRINT_STRING new_line
    ret
    