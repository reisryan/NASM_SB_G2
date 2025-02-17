#include <stdio.h>

// Declaração das funções em NASM para 16 bits
extern unsigned short bcd_add_16(unsigned short a, unsigned short b);

int main() {
    unsigned short a, b;
    
    // Solicita entrada do usuário
    printf("Digite o primeiro numero BCD (em hexadecimal, ex: 1274 para 12 34): ");
    scanf("%hx", &a);
    
    printf("Digite o segundo numero BCD (em hexadecimal, ex: 5678 para 56 78): ");
    scanf("%hx", &b);
    
    // Soma BCD de 16 bits
    unsigned short sum = bcd_add_16(a, b);
    printf("Soma BCD: %04x\n", sum);
    
    return 0;
}
