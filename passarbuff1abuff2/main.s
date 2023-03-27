segment .data
mens db "Digite uma frase:", 0xA
tam equ $-mens
mens2 db "A frase digitada foi: ", 0xA
tam2 equ $-mens2

segment .bss
buff1 resb 50
buff2 resb 50
qde resd 1

segment .text
global _start
_start:

print:
mov eax, 4
mov ebx, 1 ; FD da Tela
mov ecx, mens
mov edx, tam
int 0x80

read:
mov eax, 3
mov ebx, 0 ; FD do teclado
mov ecx, buff1
mov edx, 50
int 0x80

mov [qde], eax
xor esi, esi ; esi = 0

iniloop:
mov al, [buff1 + esi] ; al recebe buff1 na posição 0 / [base + indice]
mov [buff2 + esi], al ; buff2 na posição 0 vai receber al
inc esi ; incrementa 1 em esi = esi++
cmp esi,[qde] ; compara esi com qde (quantidade de caracteres digitados)
je print2 ; se for o mesmo tamanho vai para print2
jmp iniloop ; se nao volta para o loop
int 0x80

print2:
mov eax, 4
mov ebx, 1
mov ecx, mens2
mov edx, tam2
int 0x80

print3:
mov eax, 4
mov ebx, 1
mov ecx, buff2
mov edx, qde
int 0x80

fim:
mov eax, 1
mov ebx, 0
int 0x80