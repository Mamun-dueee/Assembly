
code segment
  start:
    mov cx, 0
    
    mov ah, 2
    mov dl, '*'
    
  top:
    
    int 21h
    
  loop top
  
  
    mov ax, 4ch
    int 21h
    
code ends
  end start