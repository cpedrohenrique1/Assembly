section .data
mens1 db "Insira um numero: ", 10
tammens1 equ $- mens1
mens2 db "Insira outro numero: ", 10
tammens2 equ $- mens2
resultado db "A soma eh: "
tamresultado equ $- resultado
nmr1 dd 0
nmr2 dd 0
soma dd 0

section .bss
entrada resb 10
qde resd 1

section .text
print:
mov eax, 4 ; servico print
mov ebx, 1 ; fd tela
int 80h
ret

readver:
mov eax, 3 ; servico read
mov ebx, 0 ; fd teclado
mov ecx, entrada
mov edx, 10
int 80h
mov [qde], eax
dec dword [qde]
cmp dword [qde], 0
je readver

xor esi, esi
lacover:
mov al, [entrada + esi]
sub al, 48
cmp al, 9
ja readver
inc esi
cmp esi, [qde]
je saidolaco
jmp lacover

saidolaco:
ret

converternum:
mov eax, [entrada + esi]
sub eax, 48
inc esi

converternum2:
mov ecx, 10
mul ecx
mov [nmr1], eax
mov eax, [entrada + esi]
sub eax, 48
add eax, [nmr1]
inc esi
cmp esi, [qde]
je saidolaco
jmp converternum2

global _start
_start:

print1:
mov ecx, mens1
mov edx, tammens1
call print

read1:
mov ecx, entrada
mov edx,10
call readver

xor esi, esi
call converternum
mov [nmr1], eax

print2:
mov ecx, mens2
mov edx, tammens2
call print

read2:
mov ecx, entrada
mov edx,10
call readver

xor esi, esi
call converternum
mov [nmr2], eax

printresult:
mov ecx, resultado
mov edx, tamresultado
call print

somar:
mov eax, [nmr1]
add eax, [nmr2]
mov [soma], eax

printsoma:
mov eax, [soma]
add eax, 48
mov [soma], eax
mov ecx, soma
mov edx, 10
call print

fim:
mov eax, 1 ; servico exit
int 80h