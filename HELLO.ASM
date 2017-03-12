PRINTSTRING MACRO MSG
 mov ah,09h
 mov dx,offset msg
 int 21h
ENDM 

data segment
 cr equ 0dh
 lf equ 0ah
 msg1 db 'HELLO WORLD','$'
 MSG2 DB 'HOW ARE YOU','$'
 MSG3 DB 'I AM GOOD','$'
data ends

code segment
 assume cs:code, ds:data
start: 
 mov ax,data
 mov ds,ax
 PRINTSTRING msg1
        
 PRINTSTRING MSG2
        
PRINTSTRING MSG3

 MOV AX, 4C00H
 INT 21H

 code ends
 end start

