section .data
mens1 db "Digite a frase: ", 0xA
tam1 equ $-mens1
mens2 db "A frase possui "
tam2 equ $-mens2
mens3 db " letras z", 0xA
tam3 equ $-mens3
cont db "0"

section .bss
entrada resb 50
qde resd 1

section .text

print:
mov eax, 4
mov ebx, 1
int 0x80
ret

read:
mov eax, 3
mov ebx, 0
int 0x80
ret

global _start
_start:

print1:
mov ecx, mens1
mov edx, tam1
call print

read1:
mov ecx, entrada
mov edx, 50
call read
mov [qde], eax

xor esi,esi
jmp verificarletra

contar:
mov eax, [cont]
sub eax, '0'
inc eax
add eax, '0'
inc esi
mov [cont], eax
int 0x80

verificarletra:
cmp [entrada + esi], byte "z"
je contar
inc esi
cmp esi, [qde]
je print2
jmp verificarletra

print2:
mov ecx, mens2
mov edx, tam2
call print

printresult:
mov ecx, cont
mov edx, 1
call print

print3:
mov ecx, mens3
mov edx, tam3
call print

fim:
mov eax, 1
mov ebx, 0
int 0x80
