global _Z4str1PKci
extern _Z6print1i


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
_Z4str1PKci:
    ;prolog
    push rbp
    mov rbp,rsp
    push rdi
    push rsi

    mov rax, [space]
    mov [str_adres], rdi

    xor rbx, rbx
    xor rcx, rcx
    xor rsi, rsi
    cld
cycle:
    mov rdx, [rdi]
    cmp rdx, '\'
    je end_string

    inc rcx
    scasb
    je white_space

    jmp cycle
white_space:
    inc esi
    jmp cycle
end_string:
    ;space_count in esi; len in ecx
    mov [space_count], rsi
    mov [str_len], rcx
    mov rcx, [rsp]
    sub rcx, [str_len]
    mov [added_size], rcx
    ;check space_count
    cmp esi, 0
    je small_block

small_block:
    mov rcx, [added_size]
    mov rsi, [str_adres]
    lea rdi, [answer]
    mov rax, 'X'
    cld

    cycle2:
         mov [rdi], rax
         inc rdi
         loop cycle2

    mov rcx, [str_len]
    rep movsb

    ;adres of result in edi
    jmp finalization

big_block:
    mov rax, [added_size]
    mov rcx, [space_count]
    cdq
    idiv rcx
    mov [every_space_adding], rax
    mov [remain], rdx
    lea rdi, [answer]
    mov rsi, [str_adres]
    mov rcx, [str_len]
    mov rax, ' '
    cld

    cycle3: ; using ecx, edi, esi
        cmp [rsi], rax
        je process
        movsb
        jmp cycle3_end

        process:
            push rcx
            mov rcx, [every_space_adding]

            inc rsi
            mov [rdi], rax
            inc rdi
            cycle3_2:
                ;actions
                mov [rdi], rax
                inc rdi
                loop cycle3_2
            pop rcx

        cycle3_end:
            loop cycle3

finalization:
    ;epilog
    pop rsi
    pop rdi
    mov rsp,rbp
    pop rbp
    mov rax, 3
    ret


