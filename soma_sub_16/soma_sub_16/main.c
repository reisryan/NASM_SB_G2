#include <stdio.h>

// Declaração das funções em NASM para 16 bits
extern unsigned short bcd_add_16(unsigned short a, unsigned short b);

int main() {
    unsigned short a = 0x1234; // Representa 12 34 em BCD
    unsigned short b = 0x5678; // Representa 56 78 em BCD

    // Soma BCD de 16 bits
    unsigned short sum = bcd_add_16(a, b);
    printf("Soma BCD: %04x\n", sum); // Saída esperada: 6912 (BCD)

    return 0;
}
