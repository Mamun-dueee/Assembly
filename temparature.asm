printstring macro msg     ;printstring-the user defined macro
                          ;msg-macro argument
    mov  ah,09h           ;display string function
    mov  dx,offset msg    ;initialize DX to MSG
    int  21h              ;call DOS service
    endm                  ;end of macro   


_DATA segment             ;_DATA-name of user defined segment
    
    cr  equ 0dh           ;ASCII code for carriage return
    lf  equ 0ah           ;ASCII code for line feed
    
    
    num1   db    "25"
    msg1   db     cr,lf,"Enter the temperature:$",cr,lf
    msg2   db    "Switch on the fan with windows open!!!$",cr,lf
    
    
    str1   db     ?,?
    
_DATA   ends               ;end of _DATA segment


_CODE segment
assume cs:_CODE, ds:_DATA  ;Initialize CS and DS to segments


start:    mov ax,_DATA     ;Initialize DS to the data segment
          mov ds,ax
                                                             
                                                             
          printstring msg1
          
tempinput:
          mov  si,offset str1
                                                              
readtemp :
          mov  ah,01h           ;read character from keyboard
          int  21h              ;call DOS service     
                                                             
                                                             
          mov   [si] , al 
          inc    si  
          cmp    al,  't'       ;read until t is pressed
          jne    readtemp
          
           
                                                                          
                                                                          
          ;Compare input temperature with reference temperature
          
          
          mov si,offset num1
          mov di,offset str1
          
          
comptemp:
          mov al,[si]           ;get character from num1
          cmp al,[di]           ;comparing
          jne reinput           ;if not equal then go to reinput label
          
          
          inc si
          inc di
          cmp al,'t'           ;check for end of string
          jne comptemp          ;if no then compare next byte
          je  display           ;if yes,then display string
          
reinput:
          printstring msg1      
          jmp tempinput
          
          
display:
          
        printstring msg2
        
_CODE ends
      end start