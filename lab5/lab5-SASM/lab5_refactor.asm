%include "io.inc"

section .data
    a: db "qwerwqe\", 0
    a2: db "qwer wq e\", 0
    b: dd 13
    space: db ' '
    end: db '\'
    
section .bss
    space_count resd 1
    added_size resd 1
    str_len resd 1
    str_adres resd 1
    every_space_adding resd 1
    remain resd 1
    answer resb 100
    ;copy resb 1
    debug_output resb 100
    
section .text
global CMAIN
_Z4str1PKcPc:
    ;prolog
    push ebp
    mov ebp,esp
    push edi
    push esi
    
    mov al, [space]
    mov [str_adres], edi

    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    cld
cycle:
    mov dl, [edi]
    cmp dl, '\'
    je end_string
    
    inc ecx
    scasb
    je white_space
    
    jmp cycle  
white_space:
    inc esi
    jmp cycle
end_string:
    ;space_count in esi; len in ecx
    mov [space_count], esi
    mov [str_len], ecx
    mov ecx, [esp]
    sub ecx, [str_len]
    mov [added_size], ecx
    ;check space_count
    cmp esi, 0
    je small_block
    jmp big_block
   
small_block:
    mov ecx, [added_size]
    mov esi, [str_adres]
    lea edi, [answer]
    mov al, 'X'
    cld
    
    cycle2:
         mov [edi], al
         inc edi
         loop cycle2
         
    mov ecx, [str_len]
    rep movsb

    ;adres of result in edi
    jmp finalization

big_block:
    mov eax, [added_size]
    mov ecx, [space_count]
    cdq
    idiv ecx
    mov [every_space_adding], eax
    mov [remain], edx    
    lea edi, [answer]
    mov esi, [str_adres]
    mov ecx, [str_len]
    mov al, ' '    
    cld
     
    cycle3: ; using ecx, edi, esi
        cmp [esi], al
        je process
        movsb
        jmp cycle3_end

        process:
            push ecx
            mov ecx, [every_space_adding]
            
            inc esi
            mov [edi], al
            inc edi
            cycle3_2:
                ;actions
                mov [edi], al
                inc edi
                loop cycle3_2
            pop ecx
   
        cycle3_end:
            loop cycle3
                 
finalization:
    ;epilog
    pop esi
    pop edi   
    mov esp,ebp
    pop ebp
    mov eax, 3
    ret


CMAIN:
    mov ebp, esp; for correct debugging
    
    ;System V convention: send 2 params in rdi, rsi; return 1 param in rax
    
    lea edi, [a]
    mov esi, [b]
    
    call _Z4str1PKcPc
    PRINT_STRING answer
    ;debug esi and esi have their own values
    ret