aarch64-linux-gnu-as matrix_mul_asm.s -o matrix_mul_asm.o
aarch64-linux-gnu-gcc -O3 -c main.c
aarch64-linux-gnu-gcc -O3 -c matrix_mul.c
aarch64-linux-gnu-gcc -O3 -o matrix_mul matrix_mul.o matrix_mul_asm.o main.o
qemu-aarch64-static -L /usr/aarch64-linux-gnu ./matrix_mul