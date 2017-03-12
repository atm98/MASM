printstring MACRO MSG
 mov ah,09h
 mov dx,offset msg
 int 21h
ENDM   
readnum macro num
        mov ah,01h
        int 21h
        Sub al,'0'
        mov bh,0ah
        mul bh
        mov num , al
        mov ah,01h
        int 21h
        Sub al,'0'
        add num,al
        endm
data segment
        cr equ 0dh
        eh equ 0dh
        msg1 db,'Enter  the Number:','$'
        msg2 db,'The number is Even:','$'
        msg3 db,'The number is Odd:','$'
        num db ?
data ends
Code segment
        assume cs :code,ds:data
        start:
                mov ax,data
                mov ds,ax
                printstring msg1
                readnum num
                mov ah,00
                mov al,num
                mov bl,02
                div bl
                Cmp ah,00
                je evennum
                printstring msg3
                jmp skip
                evennum:
                        printstring msg2
                skip:
                        mov ax,4C00h
                        int 21H
                        code ends
                        end start
