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
    sb equ 20h 
 msg db 'THE WATER LEVEL CONTROLLER IS ACTIVATED',cr,lf,cr,lf,'$'
 msg0 db 'WATER TANK is 10 meter DEEP',cr,lf,cr,lf,'$'     
 msg1 db 'WATER LEVEL measured by ULTRASONIC sensor :',sb,sb,'$'
 meter db sb,'meter.$'
 newline db cr, lf, '$'
    on db 'WATER TANK is EMPTY -- WATER PUMP is turned ON $'
    off db 'WATER TANK is FULL -- WATER PUMP is turned OFF $'
    msg_deact db cr,lf,'WATER LEVEL CONTROLLER IS DEACTIVATED $'
   data ends

code segment
    assume cs:code, ds:data
    start:
    mov ax, data
    mov ds, ax
    
    mov ch, 00h
    mov cl, 30d 
     printstring msg  
    printstring msg0 
 level_1:
     printstring msg1
     mov ah, 01h     ;read character function
     int 21h  
     cmp al, 31h
     je pump_on
     cmp al, 39h
     je pump_off
     cmp al,64h
     je deactivate
loop level_1
pump_on:
     printstring meter
     printstring newline
     printstring on
     printstring newline
     printstring newline
 jmp level_1
    
pump_off:
     printstring meter
     printstring newline
     printstring off
     printstring newline
     printstring newline
 jmp level_1
deactivate:
     printstring newline
     printstring msg_deact
     mov ah, 4ch
     int 21h             ;return to DOS
code ends 
 end start
