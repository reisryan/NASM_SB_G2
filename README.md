# Tarefa com código em C e NASM
## Disciplina de Software Básico UnB - Prof. Marcelo Ladeira
### Grupo 02

Alunos:  Arthur Mota Furtado - @BomDia12
         Filipe de Sousa Fernandes - @maldisco
         João Vitor Dickmann - @Dickmann25
         Paulo Henrique Borges Martins - @phbm2003
         Ryan Reis Fontenele - @reisryan

## Exercícios implementados

1. Construa macros para simular o comando switch em C.
2.  Construa um programa em NASM que seja chamado por um programa em C para realizar aritmética BCD 
(soma e subtração) (use instruções especiais, não vistas em sala para as operações em BCD) 

### Como executar macros

```bash
nasm -felf64 switch.nasm && ld switch.o && ./a.out
```

### Como executar soma e subtração

````bash
nasm -f elf64 -o BCD.o BCD.asm
gcc -o bcd_program main.c BCD.o

./bcd_program
```
