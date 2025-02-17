#include <stdio.h>

extern unsigned char bcd_add(unsigned char a, unsigned char b);
extern unsigned char bcd_sub(unsigned char a, unsigned char b);

int main() {
    unsigned char a = 0x50;
    unsigned char b = 0x60;

    unsigned char sum = bcd_add(a, b);
    printf("Soma BCD: %02x\n", sum);

    unsigned char diff = bcd_sub(a, b);
    printf("Subtracao BCD: %02x\n", diff);

    return 0;
}