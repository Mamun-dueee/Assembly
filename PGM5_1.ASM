title PGM5_1:CHECK FLAGS

;used in DEBUG to check flag settings

.model small
.stack 100h
.code
main proc
    
    mov ax, 4000h       ;ax = 4000h
    add ax, ax          ;ax = 8000h
    sub ax, 0FFFFh      ;ax = 8001h
    neg ax              ;ax = 7FFFh
    inc ax              ;ax = 8000h
    
    mov ah,4ch
    int 21h
    
main endp
    end main