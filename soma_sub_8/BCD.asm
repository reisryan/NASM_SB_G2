section .text
    global bcd_add
    global bcd_sub

; Função para somar dois números BCD
bcd_add:
    ; Entrada: CL = primeiro número BCD, DL = segundo número BCD
    ; Saída: AL = resultado da soma em BCD
    mov al, cl          ; Move o primeiro número para AL
    add al, dl          ; Soma AL e DL (segundo número)
    mov ah, al          ; Copia AL para AH
    and ah, 0xF0        ; Isola o nibble superior (ex: 0x70 em AH)
    and al, 0x0F        ; Isola o nibble inferior (ex: 0x0C em AL)

    ; Ajuste do nibble inferior
    cmp al, 9
    jbe .check_high
    add al, 6           ; Adiciona 6 ao nibble inferior
    and al, 0x0F        ; Mantém apenas 4 bits
    add ah, 0x10        ; Adiciona 1 ao nibble superior (carry)

.check_high:
    ; Ajuste do nibble superior
    cmp ah, 0x90        ; Verifica se o nibble superior > 9 (0x90 = 9 << 4)
    jbe .done
    add ah, 0x60        ; Ajusta o nibble superior (ex: 0xA0 → 0x00 + carry)

.done:
    or al, ah           ; Combina os nibbles ajustados
    ret

; Função para subtrair dois números BCD
bcd_sub:
    ; Entrada: CL = primeiro número BCD, DL = segundo número BCD
    ; Saída: AL = resultado da subtração em BCD
    mov al, cl          ; Move o primeiro número para AL
    sub al, dl          ; Subtrai DL (segundo número) de AL
    mov ah, al          ; Copia AL para AH
    and ah, 0xF0        ; Isola o nibble superior
    and al, 0x0F        ; Isola o nibble inferior

    ; Ajuste do nibble inferior
    cmp al, 9
    jbe .check_high
    sub al, 6           ; Subtrai 6 do nibble inferior
    and al, 0x0F        ; Mantém apenas 4 bits
    sub ah, 0x10        ; Subtrai 1 do nibble superior (borrow)

.check_high:
    ; Ajuste do nibble superior
    cmp ah, 0x90
    jbe .done
    sub ah, 0x60        ; Ajusta o nibble superior

.done:
    or al, ah           ; Combina os nibbles ajustados
    ret