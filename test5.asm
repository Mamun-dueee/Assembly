_data segment
    num db ?
    
_data ends  

_code segment 
    
    assume cs:_code, ds:_data
    
start:
    mov ah, 01h     ;read character function
    
    int 21h         ;execute the function 
    
    
    sub al, 30h      ;to conert ascci to number and keep the number in AL 
    
    mov bh, 0ah     ;set bh for nest use
    
    mul bh          ;AL*BH , result goes in AL 
    
    mov num, al     
    
    mov ah, 01h     ;read character function for next input
    
    int 21h         ;execute the 01h function 
    
    sub al, 30      ;same as before
    
    add num, al 
    
    mov al, 4ch
    int 21h
  
_code ends
end start