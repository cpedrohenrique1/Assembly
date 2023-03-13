section .data ; seção de dados constantes
mens db "Digite uma frase: ", 10 ; cria mensagem do tipo byte
tam equ $-mens ; pega tamanho de mens
mens2 db "A frase digitada foi: "
tam2 equ $-mens2

section .bss
buff resb 50
qde resd 1

segment .text ; seção de código
global _start ; simbolo visto de fora (ld)
_start: ; rotina principal (ponto de entrada)

imprimir:
  mov eax, 0x4 ; código de chamada para sys_write < 4 ->(serviço print)
  mov ebx, 0x1 ; código de chamada para stdout < 1 ->(FD da tela)
  mov ecx, mens ; endereço da mensagem (ponteiro da origem)
  mov edx, tam ; tamanho da mensagem
  int 0x80 ; chama o sistema

read:
  mov eax,3 ; serviço read
  mov ebx,0 ; fd teclado
  mov ecx,buff ; destino entrada
  mov edx,50 ; 50 é o limite de entrada
  mov [qde],eax ; quantidade de caracteres lidos
  int 0x80 ; chama o sistema

printMens2:
  mov eax, 0x4
  mov ebx, 0x1
  mov ecx,mens2
  mov edx,tam2
  int 0x80

printOutput:
  mov eax, 0x4
  mov ebx, 0x1
  mov ecx,buff
  mov edx,qde
  int 0x80

fim: ; ponto de saida
  mov eax, 0x1 ; código de chamada para sys_exit < 1 ->(serviço exit)
  mov ebx, 0x0 ; código de chamada para sucesso (retorna 0)
  int 0x80 ; chama o sistema
