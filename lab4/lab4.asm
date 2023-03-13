%include "io.inc"

section .data
    input_call: db 10, "Input some matrix:", 10, 13, 0
    check_call: db 10, "Yor input is:", 10, 13, 0
    answer_call: db 10, "Answer is:", 10, 13, 0

section .bss
    matrix resd 24

section .text
global CMAIN

ANSWER_PREPARING: ; Works after CHECK_PRINT only if it' s the first result print
    PRINT_STRING answer_call
    jmp PRINT_RESULT
PRINT_CHECK: ; Every result start point
    cmp ecx, 6
    je ANSWER_PREPARING
PRINT_RESULT: ; Main print block
    PRINT_DEC 4, eax
    PRINT_STRING " "
    cmp ecx, 0 ; If cycle is not finished - jump into end of current iteration
    jnz CONTINUE

CMAIN:
    mov ebp, esp ; For debuuging
    xor eax, eax ; Eax cleaning
    mov ecx, 24 ; Counter for matrix consistent input
    mov edi, 0 ; DWORD index
    PRINT_STRING input_call
    
INPUT_MATRIX_CYCLE:
    GET_DEC 4, [matrix+edi*4] ; Matrix - relative address of matrix
    inc edi
    loop INPUT_MATRIX_CYCLE
    
output_matrix_prepare:
    mov ecx, 24
    mov edi, 0
    PRINT_STRING check_call
    
OUTPUT_MATRIX_CYCLE:
    PRINT_DEC 4, [matrix+edi*4]
    inc edi
    loop OUTPUT_MATRIX_CYCLE
    
    
cycle_through_columns_prepare:
    xor eax, eax
    xor edi, edi
    mov ecx, 6 ; Main counter - number of columns
    NEWLINE
    
MAIN_CYCLE:
    push ecx ; Put main counter into the stack
    mov ecx, 4 ; Now current counter equals sub counter
    xor ebx, ebx ; Base register cleaning
SUB_CYCLE:
    add eax, [ebx*4 + edi + matrix] ; EBX*4 points on current row byte
    add ebx, 6 ; Every sixth index is next element in current column
    loop SUB_CYCLE
    pop ecx ; Get main counter after sub_cycle ending
    add edi, 4 ; Jump on the next column byte
    jmp PRINT_CHECK ; IO macros are bigger than 128 bytes, it will fix cycle process
CONTINUE: ; Iteration finalization
    xor eax, eax
    loop MAIN_CYCLE

FINALIZATION:
    NEWLINE
    ret
    