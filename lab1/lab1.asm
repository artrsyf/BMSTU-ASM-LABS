%include "io.inc"

section .data ; сегмент инициализированных переменных
    ExitMsg db "Press Enter to Exit",10 ; выводимое сообщение
    lenExit equ $-ExitMsg

    A dd -30
    B dd 21
    
    val1 db 255
    chart dw 256
    lue3 dw -128
    v5 db 10h
    sth db 100101b
    beta db 23,23h,0ch
    sdk db "Hello",10
    min dw -32767
    ar dd 12345678h
    valar times 5 db 8
    
    digit dw 25
    double dd -35
    string db "РоманRoman"
    
    first_try1 dw 9472
    first_try2 dw 37
    second_try1 dw -56064
    second_try2 dw -65499
    
    F1 dw 65535
    F2 dd 65535
    
section .bss ; сегмент неинициализированных переменных
    InBuf resb 10 ; буфер для вводимой строки
    lenIn equ $-InBuf
    
    X resd 1
    
    alu resw 10
    f1 resb 5

section .text ; сегмент кода
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, [F1]
    mov ebx, [F2]
    add eax,1
    add ebx,1
    
    mov eax, [A] ; загрузить число A в регистр EAX
    add eax, 5 ; сложить EAX и 5, результат в EAX
    sub eax, [B] ; вычесть число B, результат в EAX
    mov [X], eax ; сохранить результат в памяти
    ; write
    mov eax, 4 ; системная функция 4 (write)
    mov ebx, 1 ; дескриптор файла stdout=1
    mov ecx, ExitMsg ; адрес выводимой строки
    mov edx, lenExit ; длина выводимой строки
    int 80h ; вызов системной функции
    ; read
    mov eax, 3 ; системная функция 3 (read)
    mov ebx, 0 ; дескриптор файла stdin=0
    mov ecx, InBuf ; адрес буфера ввода
    mov edx, lenIn ; размер буфера
    int 80h ; вызов системной функции   
    ; exit
    mov eax, 1 ; системная функция 1 (exit)
    xor ebx, ebx ; код возврата 0
    int 80h ; вызов системной функции