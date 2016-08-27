
TITLE PGM4_2:PRINT STRING PROGRAM

.MODEL SMALL

.STACK 100H

.DATA

MSG DB 'HELLO EVERYONE !$'

.CODE
MAIN PROC
    
    ;initialize DS
    
    MOV AX, DATA
    MOV DS, AX          ;initialize DS
    
    ;display message
    
    LEA DX, MSG         ;get message
    MOV AH, 9           ;display string function
    INT 21H             ;display message
    
    ;return to DOS
           
    MOV AX, 4CH
    INT 21H             ;return to DOS
    
MAIN ENDP
    END MAIN