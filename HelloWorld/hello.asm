section .data
mens db "Hello World!", 0xA

segment .text
global _start
_start:

imprimir:
    mov edx, 0xD
    mov ecx,mens
    mov ebx, 0x1
    mov eax, 0x4
    int 0x80

fim:
  mov eax, 0x1
  mov ebx, 0x0
  int 0x80
