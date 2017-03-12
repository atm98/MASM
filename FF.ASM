data segment
 cr equ 0dh
 lf equ 0ah
 msg db cr,lf,'Hello world!!','$'
data ends

code segment
 assume cs:code, ds:data
start: 
 mov ax,data
 mov ds,ax

 mov ah,09h
 mov dx,offset msg
 int 21h

 code ends
 end start

