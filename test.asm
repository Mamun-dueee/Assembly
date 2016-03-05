_data segment 
msg db 'Hello$'
_data ends

_code segment

assume cs:_code, ds:_data
start:
    mov eax, _data
    mov eds, eax
    mov eah, 9h
    mov edx, offset msg
    int 21h
    
    mov eah, 4ch
    mov eal, 00h
    int 21h
    
_code ends
end start