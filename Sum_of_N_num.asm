
readnum macro num
    
    push ax
    push dx         ;pushing ax,dx in stack to keep the previous values
                    ;protected
    
    mov ah, 01h     ;read character function
    
    int 21h         ;execute the function 
    
    
    sub al, 30h     ;to conert ascci to number and keep the number in AL 
    
    mov bh, 0ah     ;set bh for next use
    
    mul bh          ;AL*BH , result goes in AL 
    
    mov num, al     
    
    mov ah, 01h     ;read character function for next input
    
    int 21h         ;execute the 01h function 
    
    sub al, 30h     ;same as before
    
    add num, al     ;simply add this to the previous num(inputed digit*10)
                    ; to get the two digit input 
    
    
    pop dx
    
    pop ax          ;get the values, which are kept in the stack
    
endm    ; end of macro


printstring macro x
    
    push ax             ;same as before
    push dx
    
    mov ah, 09h         ;display string function
    
    lea dx, x           ;load effective address of x in dx
    
    int 21h             ;execute the 09h function
    
    pop dx
    pop ax              ; same as before
    
endm        ;end of the macro


_data segment           ;start data segment
    
    cr equ 0dh          ;set carriage return to cr(same as define in C)
    
    lf equ 0ah          ;set line feed  to lf
    
    msg1 db 'How many numbers ? <XX>:$'
    
    msg2 db cr,lf,'Enter Number<XX>:$'      ;cr AND lf IS FOR NEWLINE(microsoft rule)
    
    msg3 db cr,lf,'Sum:$'
    
    
    
    ntable db 100 dup (0)   ;number table with 100 values and the values are zero.like array.
    
    
    num db ?            ;num is a unasigned variable
    
    temp db ?           ;same as num
    
    result db 20 dup ('$')  ;same as ntable but the values are $ character
    
    
_data ends

_code segment
    assume cs:_code, ds:_data
    
    start:
    
    mov ax, _data
    mov ds, ax
    
    
    printstring msg1        ;print msg1 using macro(printstring)
    
    readnum num             ;get input using macro(readnum) 
    
    mov si, offset ntable   ;set si to ntable's first memory address(only offset)
    
    mov ch, 00h             
    
    mov cl, num         ;set cl with num for loop (num)th time
    
    
nextread:
    
        printstring msg2 
        
        readnum temp    ;get input by macro and keep this in temp variable.
        
        mov al, temp
        
        mov [si], al    ;keep the inputed value in the ntable(in [si] address) like array in C
        
        inc si          
        
    loop nextread 
        
        
        
    mov si, offset ntable
        
    mov ah, 00h
        
    mov al, [si]
    
    mov cl, 01h
    
    
next_check:             ;calculating sum of the inputed numbers
        
        inc si
        
        cmp cl, num     ;compare cl and num if (cl==num) ret 0
        
        je no_more      ;jump on zero.
        
        mov bh, 00h
        
        mov bl, [si]
        
        add ax, bx
        
        inc cl
        
        jmp next_check
        
        
no_more:
        
        mov si, offset result   ;set si to result(array) first memory address(only offset)
        
        call hex2asc            ;hex to string convertion by calling the procedure
        
        printstring msg3
        
        printstring result
        
        
        
        mov ah, 4ch         
        mov al, 00h      
        int 21h         ;;back to DOS
        
        
        
hex2asc proc near
    
    pusha       ;keep all resister's value in stack to fetch  next time
    
    mov cx, 00h
    
    mov bx, 0ah     ;we have to divide by 10(decimal), so we set bx to 10d or 0ah
    
    
rpt1:

    mov dx, 00h
    
    div bx         ;divide AX by BX and remainder stored in dl, quotient stored in AX
    
    
    add dl, 30h     ;to convert integer to ascci(character)
    
    push dx        ;push the character(ascci) in stack
    
    inc cx
    
    cmp ax, 0ah
    
    jge rpt1       ;jump on greater or equal
    
    add al, 30h
    
    mov [si], al
    
    
rpt2:

    pop ax         ;pop those character which are pushed in #rpt1# level.
    
    inc si
    
    mov [si], al
    
    loop rpt2      ;pop all the character and keep in result(array)
    
    
    
    inc si
       
    mov al, '$'       ;append end of string
    mov [si], al
    
    popa
    
  ret
  
  
hex2asc endp       ;end of procedure.

_code ends
end start
         
