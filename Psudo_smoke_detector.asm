
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
    
    msg1 db 'State of smoke detecting sensor:$'
    
    newline db cr, lf, '$'
    
    on db 'Alarm is ON and Water falls from ceiling.$'
    
    off db 'Alarm is OFF.$'
    
    
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
      
    mov ah, 01h     ;read character function
    int 21h
    cmp al,31h
    je alarm_on
     
    cmp al, 30h
    je alarm_off
    
    cmp al,65h
    je bye
    
    loop level_1
    
    
  alarm_on:
  
    printstring newline
    printstring on
    printstring newline
    printstring newline
    
    jmp level_1
    
    
  alarm_off:
    
    printstring newline
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
    
    