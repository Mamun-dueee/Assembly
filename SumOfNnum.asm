readnum macro num
    
    push ax
    push dx
    
    mov ah,01h
    int 21h
    sub al,30h
    mov bh,0ah
    mul bh
    mov num,al
    mov ah,01h
    int 21h
    sub al,30h
    add num,al
    
    
    pop dx
    pop ax
    
endm 

printstring macro x
    
    push ax
    push dx
    
    mov ah,09h
    lea dx,x
    int 21h
    
    pop dx
    pop ax
    
endm


_data segment
    
    cr equ 0dh ;carriage return
    lf equ 0ah ;line feed
    
    msg1 db 'How many numbers ? <XX>:$'
    msg2 db cr,lf,'Enter Number<XX>:$'
    msg3 db cr,lf,'Sum:$'
    
    ntable db 100 dup (0) ; Number Table with 100 values
    
    num db ?
    temp db ?
    result db 20 dup ('$')

_data ends

_code segment
    assume cs:_code, ds:_data
    
    start:
    
    mov ax,_data
    mov ds,ax
    
    printstring msg1
    readnum num
    mov si,offset ntable ;lea usable ?
    mov ch,00h
    mov cl,num
    
nextread:
         
         printstring msg2
         readnum temp
         mov al,temp
         mov [si],al
         inc si
         loop nextread
         
         mov si,offset ntable ;lea ?
         mov ah,00h
         mov al,[si]
         mov cl,01h
         
nextchk:
         
         inc si
         cmp cl,num
         je nomore
         mov bh,00h
         mov bl,[si]
         add ax,bx
         inc cl
         jmp nextchk
         
nomore:
       
         mov si,offset result
         call hex2asc
         printstring msg3
         printstring result
         
         mov ah,4ch
         mov al,00h
         int 21h
         
hex2asc proc near
        
        pusha ;used since all general registers are needed
        mov cx,00h
        mov bx,0ah
        
        
rpt1: 
        
        mov dx,00h
        div bx
        
        add dl,30h
        push dx
        inc cx
        cmp ax,0ah
        jge rpt1
        add al,30h
        mov [si],al
        
rpt2:

        pop ax
        inc si
        mov [si],al
        loop rpt2
        
        inc si
        mov al,’$’ ;append end of string
        mov [si],al
        
        popa
        
        ret
        
        
        
hex2asc endp


_code ends
end start