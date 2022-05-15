matrix: main.c matrix_gnu.s
	arm-linux-gnueabi-gcc matrix_gnu.s main.c -static -g -o matrix
matrix_gnu.s: matrix.s
	./arm2gas.pl -i -c matrix.s
	mv matrix.s.out matrix_gnu.s
clean:
	rm matrix_gnu.s
	rm matrix