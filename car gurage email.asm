
printstring macro x 
    
    push ax
    push dx
    
    mov ah, 09h     ;display string function
    lea dx, x       ;load effective address of x parameter
    int 21h         ;execute the function
    
    pop dx
    pop ax
    
endm

data segment
    
    cr equ 0dh 
    lf equ 0ah 
    
    msg1 db 'pressure gradiant sensor 1:$'
    
    msg2 db 'pressure gradiant sensor 2:$'
    
    newline db cr, lf, '$'
    
    on db 'Water tap is ON$'
    
    off db 'Water tap is OFF$'
    
    msg_bye db 'Thank You$'
    
data ends

code segment
    assume cs:code, ds:data
    
  start:
    
    mov ax, data
    mov ds, ax
    
    mov ch, 00h
    mov cl, 30d 
    
  level_1:
      
    printstring msg1
      
    mov ah, 01h     ;read character function 1
    int 21h  
      
    
    printstring msg1
       
      
    mov bh, 01h     ;read character function 2
    int 21h
   
    
    cmp al,31h
    je outside_on
     
    cmp al, 30h
    je outside_off
    
    cmp al,66h
    je bye
    
    loop level_1
    
    
  outside_on:
  
    printstring newline
     
     
    cmp al,31h
    je nothing
     
    cmp al, 30h
    je inside_off
    
    printstring on
    printstring newline
    printstring newline
    
    jmp level_1
    
    
  outside_off:
    
    printstring newline
    
    cmp al,31h
    je outside_on
     
    cmp al, 30h
    je nothig
    
    printstring off
    printstring newline
    printstring newline
    
    jmp level_1
    
  








  
  loop level_1
    





  bye:
    
    printstring newline
    printstring msg_bye
    
    
    
    
    mov ah, 4ch
    int 21h             ;return to DOS
    
code ends 
    
  end start
    