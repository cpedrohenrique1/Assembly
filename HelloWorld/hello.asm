section .data ; seção de dados constantes
mens db "Hello World!", 0xA ; cria mensagem do tipo byte
tam equ $- mens ; pega tamanho de mens

segment .text ; seção de código
global _start
_start: ; rotina principal

imprimir:
  mov eax, 0x4 ; código de chamada para sys_write
  mov ebx, 0x1 ; código de chamada para stdout
  mov ecx, mens ; endereço da mensagem
  mov edx, tam ; tamanho da mensagem
  int 0x80 ; chama o sistema

fim:
  mov eax, 0x1 ; código de chamada para sys_exit
  mov ebx, 0x0 ; código de chamada para sucesso (retorna 0)
  int 0x80 ; chama o sistema