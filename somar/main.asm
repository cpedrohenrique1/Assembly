section .data
mens1 db "Insira um numero: ", 10
tam1 equ $- mens1
mens2 db "Insira outro numero: ", 10
tam2 equ $- mens2
result db "A soma eh: "
tamresultado equ $- result
nmr1 dd 0
nmr2 dd 0
soma dd 0

section .bss
str1 resb 10
qde resd 1

section .text
print:
mov eax, 4 ; servico print
mov ebx, 1 ; fd tela
int 80h
ret

read:
mov eax, 3 ; servico read
mov ebx, 0 ; fd teclado
int 80h
ret

addnum:
mul eax, 10
add eax, [str1 + esi]
mov [nmr1], eax
jmp verificarnum

caracter:
cmp eax, byte "0"
je addnum
cmp eax, byte "1"
je addnum
cmp eax, byte "2"
je addnum
cmp eax, byte "3"
je addnum
cmp eax, byte "4"
je addnum
cmp eax, byte "5"
je addnum
cmp eax, byte "6"
je addnum
cmp eax, byte "7"
je addnum
cmp eax, byte "8"
je addnum
cmp eax, byte "9"
je addnum
jmp print1

caracter2:
cmp eax, byte "0"
je verificarnum2
cmp eax, byte "1"
je verificarnum2
cmp eax, byte "2"
je verificarnum2
cmp eax, byte "3"
je verificarnum2
cmp eax, byte "4"
je verificarnum2
cmp eax, byte "5"
je verificarnum2
cmp eax, byte "6"
je verificarnum2
cmp eax, byte "7"
je verificarnum2
cmp eax, byte "8"
je verificarnum2
cmp eax, byte "9"
je verificarnum2
jmp print2

multnumber:
mul eax, 10
add eax, [nmr1 + esi]
jmp numero1

multnumber2:
mul eax, 10
add eax, [nmr2 + esi]
jmp printsoma

global _start
_start:

print1:
mov ecx, mens1
mov edx, tam1
call print

read1:
mov ecx,str1
mov edx,10
call read
mov [qde], eax
cmp eax, 1
je print1

xor esi, esi
verificarnum:
mov eax, [str1 + esi]
inc esi
cmp esi, [qde]
je print2
jmp caracter

print2:
mov ecx, mens2
mov edx, tam2
call print

read2:
mov ecx, nmr2
mov edx,10
call read
mov [qde2], eax
cmp eax,1
je print2

xor esi, esi
verificarnum2:
mov al, [nmr2 + esi]
inc esi
cmp esi, [qde2]
je printresult
jmp caracter2

printresult:
mov ecx, result
mov edx, tamresultado
call print

xor esi, esi
xor eax, eax
numero1:
mov eax, [nmr1 + esi]
sub eax, "0"
inc esi
cmp esi, [qde]
je numero2
jmp multnumber

mov [qde], eax

xor eax, eax
xor esi, esi
numero2:
mov eax, [nmr2 + esi]
sub eax, "0"
inc esi
cmp esi, [qde2]
je printsoma
jmp multnumber2

printsoma:
add eax, [qde]
call print

fim:
mov eax, 1 ; servico exit
int 80h
