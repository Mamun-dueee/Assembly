
title PGM6_2: FIRST AND LAST CAPITALS
.model small
.stack 100h

.data

    prompt db 'Type a line of text.',0DH, 0AH, '$'
    
    nocap_msg db 0DH, 0AH, 'No capitals $'
    
    cap_msg db  0DH, 0AH,'First capital = '
    first   db  ']'
            db  ' Last capital = '
    last    db  '@ $'
    
.code

main proc
    
    ;initialize DS
    
    mov ax, @data
    mov ds, ax
    
    ;display opening message
    
    mov ah, 9       ;display string function
    lea dx, prompt  ;get opening message
    int 21h         ;display it
    
    ;read and process a line of text
    mov ah, 1       ;read char function
    int 21h         ;char in al
    
  while:
     
    ;while character is not a carriage return do
    
    cmp al, 0DH
    je end_while    ;yes exit
    
    ;if character is a capital letter
    
    cmp al, 'A'
    jnge end_if     ;not a capital letter
    
    cmp al, 'Z'
    jnle end_if     ;not a capital letter
    
    ;then
    ;if character precedence first capital
    
    cmp al, first
    jnl check_last
    
    ;then first capital = character
    mov first, al
    
    ;end_if
  check_last:
    
    ;if character follows last capital
    
    cmp al, last        ;char > last capital?
    jng end_if
    
    ;then last capital = character
    
    mov last, al        ;last = char
    
    ;end_if
  end_if:
    
    ;read a characters
    
    int 21h     ;char in al
    jmp while   ;repeat loop
    
  end_while:
    
    ;display results
    
    mov ah,9
    
    ;if no capitals were typed
    
    cmp first, ']'
    jne caps
    
    ;then
    
    lea dx, nocap_msg
    jmp display
    
  caps:
    
    lea dx, cap_msg
    
  display:
  
    int 21h
    
  ;end_if
  ;dos exit
  
    mov ah, 4CH
    int 21h
    
main endp

    end main