%include "io.inc"

section .data
    q dd 2
    a dd 6


section .bss
    s resw 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp ; Debugger
    xor eax, eax ; Eax cleaning
    
    mov ecx, [q]
    mov edx, [a]
     
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
    ret