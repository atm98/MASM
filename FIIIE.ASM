READNUM MACRO NUM
        MOV AH,01H
        INT 21H
        SUB AL,'0'
        MOV BH,0AH
        MUL BH
        MOV NUM,AL
        MOV AH,01H
        INT 21H
        SUB AL,'0'
        ADD NUM,AL
ENDM
PRINTSTRING MACRO MSG
        MOV AH,09H
        MOV DX,OFFSET MSG
        INT 21H
ENDM
DATA SEGMENT
        CR EQU 0DH
        LF EQU 0AH
        MSG1 DB CR,LF,'HOW MANY NUMBERS $'
        MSG2 DB CR,LF,'ENTER NUMBER $'
        MSG3 DB CR,LF,'LARGEST NUMBER IS $'
        NTABLE DB 100(0)
        NUM DB ?
        TEMP DB ?
        RESULT DB 20 DUP(0)
DATA ENDS
CODE SEGMENT
        ASSUME CS:CODE,DS:DATA
        START:
                MOV AX,DATA
                MOV DS,AX
                PRINTSTRING MSG1
                READNUM NUM
                MOV SI,OFFSET NTABLE
                MOV CH,00
                MOV CL,NUM
                NEXTREAD:
                PRINTSTRING MSG2
                READNUM TEMP
                MOV AL,TEMP
                MOV [SI],AL
                INC SI
                LOOP NEXTREAD

                MOV SI,OFFSET NTABLE
                MOV BL,[SI]
                MOV CL,01
                NEXTCHK:
                INC SI
                CMP CL,NUM
                JE NOMORE
                CMP BL,[SI]
                JGE SKIP
                MOV BL,[SI]
                SKIP:
                INC CL
                JMP NEXTCHK
                NOMORE:
                MOV AH,00
                MOV AL,BL
                MOV SI,OFFSET RESULT
                CALL HEX2ASC
                PRINTSTRING MSG3
                PRINTSTRING RESULT
                MOV AX,4C00H
                INT 21H
                HEX2ASC PROC NEAR
                PUSH AX
                PUSH BX
                PUSH CX
                PUSH DX
                PUSH SI
                MOV CX,00H
                MOV BX,0AH
                RPT1:
                MOV DX,00
                DIV BX
                ADD DL,'0'
                PUSH DX
                INC CX
                CMP AX,0AH
                JGE RPT1
                ADD AL,'0'
                MOV [SI],AL
                RPT2:
                POP AX
                INC SI
                MOV [SI],AL
                LOOP RPT2
                INC SI
                MOV AL,'$'
                MOV [SI],AL

                POP SI
                POP DX
                POP CX
                POP BX
                POP AX
                RET
                HEX2ASC ENDP
                CODE ENDS
                END START
