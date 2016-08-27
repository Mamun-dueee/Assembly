
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
    tb equ 09h
    
    msg1 db tb,'OUTSIDE SENSOR:$'
    
    msg2 db tb,'INSIDE SENSOR:$'
    
    newline db cr, lf, '$'
    
    
    activate db '**  SYSTEM ACTIVATED  **  $' 
    
    
    
    door_open db tb,'GARAGE door OPENS$'
    
    door_close db tb,'GARAGE door CLOSES$'
    
 
    exist db tb,'GARAGE is FULL door is LOCKED$'
    
    empty db tb,'GARAGE is EMPTY$'
    
    
    deactivate db '**  SYSTEM DEACTIVATED  ** $ '
     
data ends

code segment
    assume cs:code, ds:data
    
  start:
    
    mov ax, data
    mov ds, ax
    
    mov ch, 00h
    mov cl, 30d 
    
    printstring activate 
    
  level_1:
      
    
      
    printstring newline
    printstring newline
    
    printstring msg1
      
    mov ah, 01h     ;read character function 1
    int 21h  
      
    
    
   
    
    cmp al,31h
    je outside_on
     
    cmp al, 30h
    je outside_off
    
    cmp al,64h
    je deactivate_system
    
    loop level_1
    
    
  outside_on:
  
    printstring newline
     
    printstring msg2
       
      
    mov ah, 01h     ;read character function 2
    int 21h
    
    
     
    cmp al, 30h
    je inside_off 
    
    cmp al,31h
    je situation_1
                   
                   
    cmp al,64h
    je deactivate_system
    
    printstring newline
    printstring newline
    
    jmp level_1
    
    
  outside_off:
    
    printstring newline
    
    printstring msg2
       
      
    mov ah, 01h     ;read character function 2
    int 21h
   
    cmp al,31h
    je inside_on
                   
                   
    cmp al, 30h   
    je situation_2
    
    
    cmp al,64h
    je deactivate_system
    
    printstring newline
    printstring newline
    
    jmp level_1
    
  
   
   inside_off:


   printstring newline
   printstring newline
    
   printstring door_open


   printstring newline
   printstring newline
       
       
    jmp level_1    
       
       
        
        
        
   inside_on:


   printstring newline
   printstring newline
    
   printstring door_close


   printstring newline
   printstring newline
       
       
   jmp level_1    
          
        
        
    
   situation_1:


   printstring newline
   printstring newline
    
   printstring exist


   printstring newline
   printstring newline
       
       
   jmp level_1    
          
    
    
    
     
   situation_2:


   printstring newline
   printstring newline
    
   printstring empty


   printstring newline
   printstring newline
       
       
   jmp level_1   
    
    
    
    
    
    
        
        
  
  loop level_1
    





  deactivate_system:
    
    printstring newline
    printstring newline
    printstring newline
    printstring deactivate
    
    
    
    mov ah, 4ch
    int 21h             ;return to DOS
    
code ends 
    
  end start
    