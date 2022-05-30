./arm2gas.pl -i -c matrix.s
mv matrix.s.out matrix_gnu.s
arm-linux-gnueabi-gcc matrix_gnu.s main.c -static -g -o matrix
python3 ./grade.py
