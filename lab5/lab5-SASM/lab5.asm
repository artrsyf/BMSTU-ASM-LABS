%include "io.inc"

section .data
    a: db "qwerwqe\", 0 ; "qwer wq e\"
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
    answer resb 1
    
section .text
global CMAIN
_Z4str1PKcPc: push ebp
mov ebp,esp
mov al, [space]
mov edi, ebx
mov [str_adres], edi
push ebx
push ecx
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
    xor ecx, ecx
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
    ;PRINT_CHAR [edi]
    ;mov eax, [edi]
    ;mov [answer], eax
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
    mov al, ' '
    
    cld
    mov ecx, [str_len]
    cycle3: ; using ecx, edi, esi
        cmp [esi], al
        je process
        movsb
        jmp cycle3_end
        
        
        process:
            push ecx
            mov ecx, [every_space_adding]
            
            inc esi
            ;inc edi
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
    PRINT_STRING answer
    mov esp,ebp
    pop ebp
    MOV EBX, [answer]
    ret


CMAIN:
    mov ebp, esp; for correct debugging
    lea ebx, [a]
    mov ecx, [b]
    call _Z4str1PKcPc