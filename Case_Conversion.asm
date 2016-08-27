TITLE PGM4_3: CASE CONVERSION PROGRAM
.MODEL SMALL
.STACK 100H
.DATA
    CR EQU 0DH
    LP EQU 0AH
  MSG1 DB 'ENTER A LOWER CASE LETTER: $'
  MSG2 DB CR,LF,'IN UPPER CASE IT IS: '
  CHAR DB ?,'$'

.CODE
MAIN PROC

;initialize DS
  MOV AX, @DATA       ;get data segment
  MOV DS, AX          ;initialize DS

;print user prompt
  LEA DX, MSG1        ;get first message
  MOV AH, 9           ;display string function
  INT 21H             ;display first message

;input a character and convert to upper case
  MOV AH, 1           ;read character function
  INT 21H             ;execute the function
  SUB AL, 20H         ;convert it to upper case
  MOV CHAR, AL        ;and store it

;display on the next line
  LEA DX, MSG2        ;get second message
  MOV AH, 9           ;display string function
  INT 21H             ;execute the function

;DOS exit
  MOV AH, 4CH
  INT 21H             ;dos exit

MAIN ENDP
  END MAIN