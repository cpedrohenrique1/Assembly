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
        xor eax, eax  ; Limpa eax antes do cálculo
        xor ecx, ecx  ; Limpa ecx para servir de contador
    converternum1:
        mov edx, 10
        mul edx       ; Multiplica eax por 10
        movzx edx, byte [entrada + ecx]  ; Lê o dígito em edx
        sub dl, '0'   ; Converte o dígito em valor numérico
        add eax, edx  ; Adiciona o dígito em eax
        inc ecx       ; Incrementa o contador
        cmp ecx, [qde]
        jl converternum1 ; Se o contador for menor, continua o laço
        ret

    global _start
    _start:

    print1:
        mov ecx, mens1
        mov edx, tammens1
        call print

    read1:
        mov ecx, entrada
        mov edx, 10
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
        mov edx, 10
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
        ; Converte a soma em uma string
        xor ecx, ecx        ; Zera ecx para servir de contador
        mov ebx, 10         ; Base decimal
        mov edi, 9          ; Tamanho máximo da string (10 dígitos - 1)
        lea esi, [entrada + edi]  ; Ponteiro para o último dígito na string
    convertloop:
        xor edx, edx        ; Zera edx para dividir eax por ebx
        div ebx             ; Divide eax por ebx (resto em edx)
        add dl, '0'         ; Converte o resto em caractere ASCII
        dec esi             ; Move o ponteiro para a esquerda na string
        mov [esi], dl       ; Armazena o dígito na string
        inc ecx             ; Incrementa o contador
        test eax, eax       ; Verifica se eax é zero (fim da divisão)
        jnz convertloop     ; Se não for zero, continua o loop
        mov edx, ecx        ; Armazena o tamanho da string em edx
        mov ecx, esi        ; Ponteiro para o início da string
        call print

    fim:
        mov eax, 1 ; servico exit
        int 80h