%include "io.inc"

section .data
    start_message: db "Input string in lowercase:", 10, 13, 0
    answer_message: db 10, "Your answer is:", 10, 13, 0
    flag db 0
section .bss
    input_char resd 100
    output_char resd 100
    word_buffer resd 1

section .text
global CMAIN

VOWEL:
    inc esi
    jmp MAIN_CYCLE_CONTINUATION

CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, 500
    mov ebx, 0
    xor esi, esi
    xor edi, edi
    PRINT_STRING start_message
    
MAIN_TEXT_CYCLE:
    GET_CHAR input_char
    mov eax, [input_char]
    
    cmp eax, " "
    je WORD_END_HANDLER
    cmp eax, 92
    je WORD_END_HANDLER
    
    cmp eax, 97
    je VOWEL
    cmp eax, 101
    je VOWEL
    cmp eax, 105
    je VOWEL
    cmp eax, 111
    je VOWEL
    cmp eax, 117
    je VOWEL
    inc edi ; sogl
    
    MAIN_CYCLE_CONTINUATION:
        mov [word_buffer + ebx], eax
        inc ebx
        dec ecx
        jmp MAIN_TEXT_CYCLE ; the way is bigger than 128 bytes
 
 
 WORD_END_HANDLER:
    push ecx
    mov ecx, ebx
    mov ebx, [word_buffer]
    cmp ebx, 0 ; check on space
    je SUB_CYCLE_FINALIZATION
    
    cmp esi, edi
    jne SUB_CYCLE_FINALIZATION
    
    xor ebx, ebx
    
    SUB_PRINT_CYCLE:
        mov edx, [word_buffer + ebx] 
        mov [output_char], edx
        
        PRINT_CHAR output_char
        inc ebx
        loop SUB_PRINT_CYCLE
        
       PRINT_CHAR " "
       
    SUB_CYCLE_FINALIZATION:
        xor esi, esi
        xor edi, edi
        xor ebx, ebx
        mov [word_buffer], ebx
        pop ecx
        cmp eax, 92
        je FINALIZATION
        jmp MAIN_TEXT_CYCLE
        
        
FINALIZATION:
    NEWLINE 
    ret