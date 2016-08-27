
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
   
 msg1 db 'press  1 key  to increase MONEY and 2 key to decrease MONEY $'
 msg  db cr,lf,'(it will loop around 0 to 9 with a hint of the /). Press e to exit$'
 msg2 db cr,lf,'0$'
 msg3 db 'X$'
 msg4 db 'program will now exit$' 
 
data ends

code segment
    assume cs:code, ds:data
    start:
    
    
    
    mov ax,data
    mov ds,ax
    mov bl,00h
   
    
printstring msg1
printstring msg
printstring msg2
    
   
    
loop1: 
      
       mov dl,cr
       mov ah,02h
       int 21h
              
       cmp bl,9h
       jge loop4
       
       cmp bl,0h
       jl  loop5 
       
       mov ah,08h
       int 21h
       
       cmp al,65h
       jz finish
       
       sub al,30h
       mov cl,al
       
       cmp cl,01h
       
       je loop2
       
       jg loop3
       
       jmp loop1
   
    
    
loop2:
       inc bl
       mov al,bl
       add al,30h
       mov dl,al
       mov ah,02h
       int 21h
       
       jmp loop1
       
loop3: dec bl
       mov al,bl
       add al,30h
       mov dl,al
       mov ah,02h
       int 21h
       
       jmp loop1
       
 
loop4: sub bl,9h
       
       jmp loop1

loop5: 
       add bl,9h
       
       jmp loop1
       
       
finish: printstring msg4
        
        mov ah,4ch
        int 21h

      
       
     
    code ends

end start