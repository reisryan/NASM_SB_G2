%macro SWITCH 1
    mov eax, %1                     ; valor a ser comparado em rax
    %push switch                    ; contexto switch
    %assign next 1                  ; valor 1 (inicial) em next
    mov ebx, 1
    cmp ebx, 0                      ; cmp inicial diferente para não ignorar o primeiro caso
    jmp %$case %+ next              ; jump para label local caso1
%endmacro

%macro CASE 1
    %ifctx switch
        %$case %+ next:             ; label com caso atual
        %assign next next+1         ; acrescenta 1 ao next
        je %$cmp %+ next            ; se a última comparação for igual, pula a comparação desse caso
        cmp eax, %1                 ; compara o valor (que foi armazenado em switch) com argumento do case
        jne %$case %+ next          ; se não for igual, próximo case
        %$cmp %+ next:              ; label com comparação
    %endif
%endmacro

%macro DEFAULT 0
    %ifctx switch
        %$case %+ next:
    %endif
%endmacro

%macro BREAK 0
    jmp %$endswitch                 ; pula para endswitch local
%endmacro

%macro CLOSE 0
    %ifctx switch                   ; se no contexto switch
        %$endswitch:                ; label local endswitch
        %pop                        ; finaliza contexto switch
    %endif
%endmacro

%macro PRINTCHAR 1
    mov [char], byte %1             ; guarda o valor recebido em memória
    mov eax, 1                      ; syscall write
    mov edi, 1                      ; stdout
    mov esi, char                   ; print buffer como argumento
    mov edx, 1                      ; tamanho do print buffer (1 char)
    syscall
%endmacro


section   .data
char:  db 0                         ; print buffer

global    _start
section   .text
_start:
    mov edx, 1                      ; valor inicial a ser somado

    SWITCH 4
    CASE 1
        PRINTCHAR 66                ; print 'B'
    CASE 2
        PRINTCHAR 111               ; print 'o'
    CASE 3
        PRINTCHAR 109               ; print 'm'
        BREAK
    CASE 4
        PRINTCHAR 100               ; print 'd'
    CASE 5
        PRINTCHAR 105               ; print 'i'
    CASE 6
        PRINTCHAR 97                ; print 'a'
    DEFAULT
        PRINTCHAR 33                ; print '!'
    CLOSE

    PRINTCHAR 10                    ; print '\n'

    mov eax, 60                     ; syscall exit
    mov edi, 0                      ; exit 0 
    syscall
