STRING MACRO MSG
        MOV AH,09H
        MOV DX,OFFSET MSG
        INT 21H
ENDM
DATA SEGMENT
        CR EQU 0DH
        LF EQU 0AH
        BUFF DB 20 DUP(0)
        REVBUFF DB 20 DUP(0)
        MSG1 DB 'ENTER THE STRING:','$'
        MSG2 DB CR,LF,'THE REVERSE OF THE STRING IS:','$'
        MSG3 DB CR,LF,'IT IS A PALINDROME','$'
        MSG4 DB CR,LF,'IT IS NOT A PALINDROME','$'
DATA ENDS
CODE SEGMENT
        ASSUME CS:CODE,DS:DATA
        START:
                MOV AX,DATA
                MOV DS,AX
                STRING MSG1
                        MOV SI,OFFSET BUFF
        RDCHART:
                MOV AH,01H
                INT 21H
                MOV [SI],AL
                INC SI
                CMP AL,CR
                JNE RDCHART
                MOV SI,OFFSET BUFF
                MOV BX,00
        LABEL3:
                MOV AL,[SI]
                CMP AL,CR
                JE LABEL2
                MOV [SI],AL
                INC SI
                INC BX
                JMP LABEL3
        LABEL2:
                MOV SI,OFFSET BUFF
                ADD SI,BX
                MOV DI,OFFSET REVBUFF
                MOV CX,BX
        LABEL4:
                DEC SI
                MOV AL,[SI]
                MOV [DI],AL
                INC DI
                LOOP LABEL4
                MOV AL,'$'
                MOV [DI],AL

                STRING MSG2
                STRING REVBUFF
                MOV SI,OFFSET BUFF
                MOV DI,OFFSET REVBUFF
                MOV CX,BX
        NEXTCHAR:
                MOV AL,[SI]
                CMP AL,[DI]
                JNE NOTPALI
                INC SI
                INC DI
                LOOP NEXTCHAR
        PALINDROME:
                STRING MSG3
                JMP SKIP
        NOTPALI:
                STRING MSG4
        SKIP:
                MOV AX,4C00H
                INT 21H
        CODE ENDS
                END START
