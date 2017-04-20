.model small
.stack 100
.data
prompt db  0ah,0dh,"Enter a number: $"
prompt1 db  0ah,0dh,"Eneter a number: $"
resmes db 0ah,0dh,"Sum of the number is: $"
result db ?,0ah,0dh,"$"
    .code
start:
    mov ax,@data
    mov ds,ax
        lea dx,prompt
        mov ah,9
        int 21h
        mov ah,1
        int 21h
        mov bl,al
        sub bl, 30h
        lea dx,prompt1
        mov ah,9
        int 21h
        mov ah,1
        int 21h
        sub al, 30h
        add al,bl
        add al,30h
        mov result,al
        lea dx,resmes
        mov ah,9
        int 21h
        mov ax,4c00h
        int 21h
        end start
