
TITLE PGM6_1: IBM CHARACTER DISPLAY
.MODEL SMALL
.STACK 100H
.CODE
MAIN  PROC
    MOV AH, 2       ;display char function
    MOV DL, 0       ;DL has ascii code of null character
    MOV CX, 256     ;no. of chars to display
    
PRINT_LOOP:
    INT 21H         ;display a character
    INC DL          ;increment ascii code
    DEC CX          ;decrement counter
    JNZ PRINT_LOOP  ;keep going if cx not 0
    
;exit to DOS
    MOV AH, 4CH     
    INT 21H
    
MAIN ENDP
    END MAIN
    