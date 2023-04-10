segment .data
mens1 db "Insira a frase: ", 0xA
tam1 equ $-mens1
mens2 db "A letra u esta na mensagem digitada", 0xA
tam2 equ $-mens2
mens3 db "A letra u nao esta na mensagem inserida", 0xA
tam3 equ $-mens3

segment .bss
entrada resb 50
qde resd 1

segment .text

read:
mov eax,3
mov ebx,0
int 0x80
ret

print:
mov eax, 4
mov ebx, 1
int 0x80
ret

global _start
_start:

printmens1:
mov ecx,mens1
mov edx,tam1
call print

readentrada:
mov ecx,entrada
mov edx,50
call read
mov [qde],eax

xor esi,esi ; variavel contador recebe 0

verificarletra:
mov al,[entrada + esi]
cmp al, byte "u"
je printmens2
inc esi
cmp esi, [qde]
je printmens3
jmp verificarletra

printmens3:
mov ecx,mens3
mov edx,tam3
call print
jmp fim

printmens2:
mov ecx,mens2
mov edx,tam2
call print

fim:
mov eax,1
mov ebx,0
int 0x80
