#!bin/bash
nasm -f elf64 l2.asm
ld -o l2 l2.o
./l2
