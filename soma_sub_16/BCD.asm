section .text
    global bcd_add_16

; Função para soma BCD
bcd_add_16:
    ; Entrada: CX = primeiro número BCD (16 bits), DX = segundo número BCD (16 bits)
    ; Saída: AX = resultado da soma em BCD (16 bits)

    ; ====================
    ; SOMA DO BYTE INFERIOR (CL + DL)
    ; ====================
    mov al, cl
    add al, dl          ; Soma os dois primeiros dígitos BCD (parte baixa)
    mov ah, al          ; Copia resultado para AH para ajuste
    and ah, 0xF0        ; Isola o nibble superior
    and al, 0x0F        ; Isola o nibble inferior

    cmp al, 9
    jbe .adjust_high_low
    add al, 6           ; Ajusta o nibble inferior para BCD
    and al, 0x0F        ; Mantém apenas 4 bits
    add ah, 0x10        ; Propaga carry para o nibble superior

.adjust_high_low:
    cmp ah, 0x90
    jbe .store_lower
    add ah, 0x60        ; Ajusta o nibble superior, se necessário
    
.store_lower:
    setc cl             ; Salva o CF no bit 0 de CL (CL = 1 se CF = 1, senão CL = 0)
    or al, ah           ; Combina nibbles ajustados da parte baixa
    mov bl, al          ; Guarda resultado da parte baixa

    ; ====================
    ; SOMA DO BYTE SUPERIOR (CH + DH + Carry)
    ; ====================
    mov al, ch
    add al, dh          ; Soma CH e DH
    add al, cl          ; Adiciona manualmente o valor do CF salvo

    mov ah, al          ; Copia resultado para AH
    and ah, 0xF0        ; Isola o nibble superior
    and al, 0x0F        ; Isola o nibble inferior

    cmp al, 9
    jbe .adjust_high_high
    add al, 6           ; Ajusta o nibble inferior
    and al, 0x0F        ; Mantém apenas 4 bits
    add ah, 0x10        ; Propaga carry para o nibble superior

.adjust_high_high:
    cmp ah, 0x90
    jbe .done
    add ah, 0x60        ; Ajusta o nibble superior, se necessário

.done:
    or al, ah           ; Combina os nibbles ajustados
    mov bh, al          ; Guarda resultado da parte alta

    ; Combina os dois bytes no registrador de saída
    mov ah, bh
    mov al, bl
    ret