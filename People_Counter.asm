
 printstring macro x
    
    push ax
    push dx
    
    mov ah,09h
    lea dx,x
    int 21h
    
    pop dx
    pop ax
    
 endm
 


data segment
     
    cr equ 0dh 
    lf equ 0ah
     
    msg1 db '*********---People Counter---***********',cr,lf,'$'
    newline db cr, lf, cr, lf, '$'     
    msg2 db 'Total $'    
    msg3 db ' people entered through the door.$'    
    msg4 db 'Pressing i (for every man entered through the door):$'    
    msg5 db '                        ----Thank You----$'
    
    total dw '0'    
    result db 20 dup ('$')
     
data ends

code segment
    
    assume cs:code ds:data
     
  start:
    mov ax, data
    mov ds, ax
    
    sub total, 30h
    
    printstring msg1
    printstring newline
    printstring msg4    
    
  loop1:
    mov ah, 08h
    int 21h
    
    inc total
    
    cmp al,69h
    je loop1    
                
    dec total    
    mov ax, total
    
    mov si,offset result
    call hex2asc
                 
    printstring newline
    printstring msg2    
    printstring result     
    printstring msg3                    
    printstring newline
    printstring newline
    printstring msg5
    
    mov ah,4ch
    mov al,00h
    int 21h
    
 
 
hex2asc proc near
        
        pusha 
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
        mov al,'$' 
        mov [si],al
        
        popa
        
        ret
        
        
        
hex2asc endp 

code ends
end start