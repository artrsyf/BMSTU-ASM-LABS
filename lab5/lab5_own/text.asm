global _Z4str1PKciPc
extern _Z6print1i



section .text
_Z4str1PKciPc:
    ; Prolog
    push rbp
    mov rbp,rsp
    push rdi
    push rsi
    push rdx

    ; Preparation
    mov al, ' '
    xor rbx, rbx
    xor rcx, rcx
    xor rsi, rsi
    xor rdx, rdx
    cld
; Cycle processes string and calculates main features
cycle:
    mov dl, [rdi]
    cmp dl, 0
    je end_string

    inc rcx
    scasb
    je white_space

    jmp cycle
white_space:
    inc rsi
    jmp cycle
end_string:
    push rsi
    push rcx
    mov rcx, [rsp+24] ; According to second proc param - int(esp + 24 - in stack)
    sub rcx, [rsp] ; On this step RSP is pointing on str_len
    push rcx
    cmp rsi, 0
    je small_block ; If string is without spaces
    jmp big_block  ; In opposite case

small_block:
    mov rcx, [rsp]
    mov rsi, [rsp+40]
    mov rdi, [rsp+24]
    mov al, ' '
    cld

    cycle2:
         mov [rdi], al
         inc rdi
         loop cycle2

    mov rcx, [rsp+8]
    rep movsb

    jmp finalization

big_block:
    mov rax, [rsp]
    mov rcx, [rsp+16]

    cdq

    idiv rcx

    push rax
    push rdx

    mov rdi, [rsp+40]
    mov rsi, [rsp+56] ; Fixed
    mov rcx, [rsp+24]

    mov al, ' '
    cld

    cycle3:
        cmp [rsi], al
        je process
        movsb
        jmp cycle3_end

        process:
            push rcx
            mov rcx, [rsp+16] ; considering ecx on previous line
            add rcx, [rsp+8] ; remain adding
            mov qword[rsp+8], 0 ; Only one time remain is needed

            inc rsi
            mov [rdi], al
            inc rdi
            cycle3_2:
                mov [rdi], al
                inc rdi
                loop cycle3_2
            pop rcx

        cycle3_end:
            loop cycle3

    big_block_finalization:
        pop rcx
        pop rcx

finalization:
    pop rcx
    pop rcx
    pop rcx
    pop rdx

    ;epilog
    pop rsi
    pop rdi
    mov rsp,rbp
    pop rbp
    mov rax, 3
    ret
