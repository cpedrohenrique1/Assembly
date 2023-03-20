segment .data
mens db "Entre com uma string" , 10
tam equ $-mens
mens1 db "Igual" ,10
tam1 equ $-mens1
mens2 db "Diferente",10
tam2 equ $-mens2

segment .bss
buffer resb 50
qde resd 1

segment .text
global _start
_start:

print:
mov eax,4
mov ebx,1
mov ecx,mens
mov edx,tam
int 0x80

read:
mov eax,3
mov ebx,0
mov ecx,buffer
mov edx,50
int 0x80
mov [qde],eax

teste:
cmp [buffer], byte "A"
je printigual
jmp fim
int 0x80

printigual:
mov eax,4
mov ebx,1
mov ecx,mens1
mov edx,tam1
int 0x80

fim:
mov eax,1
mov ebx,0
int 0x80