#include <stdio.h>

extern unsigned char bcd_add(unsigned char a, unsigned char b);
extern unsigned char bcd_sub(unsigned char a, unsigned char b);

int main() {
    unsigned char a, b;
    
    // Solicita entrada do usuário
    printf("Digite o primeiro numero BCD (em hexadecimal, ex: 41 para 4 1): ");
    scanf("%hhx", &a);
    
    printf("Digite o segundo numero BCD (em hexadecimal, ex: 60 para 6 0): ");
    scanf("%hhx", &b);
    
    unsigned char sum = bcd_add(a, b);
    printf("Soma BCD: %02x\n", sum);
    
    unsigned char diff = bcd_sub(a, b);
    printf("Subtracao BCD: %02x\n", diff);
    
    return 0;
}
