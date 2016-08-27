
title PGM6_1:printing all characters

.model small

.stack 100h

.code
main proc
    
    mov ah, 2       ;display character function
    mov cx, 256
    mov dl, 0       ;ascii value of NULL character
    
PRINT_LOOP:
    
    int 21h         ;display a char
    inc dl          ;increment ASCII code
    dec cx          ;decrement counter\
    
    jnz PRINT_LOOP  ;keep going if cx not equal 0
    
    ;DOS exit
    mov ah, 4ch
    int 21h
    
main endp
    end main
   