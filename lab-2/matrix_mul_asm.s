// Author: Yusen Zheng

	.text
	.global matrix_mul_asm

matrix_mul_asm:
    // Please write your code below that will implement:
    //       int matrix_mul_asm(Matrix* results, Matrix* source1, Matrix* source2);

		// My Notes:
		// Data in the matrix is ranging from 0 to 255. 8 bits.
		// 512 * 256 & 256 *512
		// Remember that in AArch64 the stack-pointer must be 128-bit aligned.

	LDR X3, [X1]	// source1.rows
	LDR X4, [X2, #4]	// source2.columns
	LDR X5, [X1, #4]	// source1.columns == source2.rows
	
	STR X3, [X0]	// results.rows	== source1.rows
	STR X4, [X0, #4]	// results.columns == source2.columns
	
	LDR X0, [X0, #8]	// X0 store address of results.data
	LDR X1, [x1, #8]	// X1 store address of source1.data
	LDR X2, [X2, #8]	// X2 store address of source2.data
 
	MOV X6, #0	// 4 * i
	MOV X7, #0	// 4 * j
	MOV X8, #0	// 4 * k
 
	B loop1
 
loop1:
	B finish
	CMP X6, X3
	BEQ finish
	B loop2
 
ctd1:
	ADD X6, X6, #4
	MOV X7, #0
	B loop1
 
loop2:
	CMP X7, X4
	BEQ ctd1
	B loop3
	
ctd2:
	ADD X7, X7, #4
	MOV X8, #0
	B loop2
 
loop3:
	CMP X8, X5
	BEQ ctd2
	B block_mul
	
ctd3:
	ADD X8, X8, #4
	B loop3
 
block_mul:
	MUL X9, X6, X5
	ADD X9, X9, X8
	LSL X9, X9, #2
	ADD X9, X9, X1 // X9 store address of source1.data[i][k]
 
	MUL X10, X8, X4
	ADD X10, X10, X7
	LSL X10, X10, #2
	ADD X10, X10, X2 // X10 store address of source2.data[k][j]
 
	MUL X11, X6, X4
	ADD X11, X11, X7
	LSL X11, X11, #2
	ADD X11, X11, X0 // X11 store address of results.data[i][j]
 
	// Load datas
	LSL X12, X5, #2
	LD1 {V0.4s}, [X9]
	ADD X9, X9, X12
	LD1 {V1.4s}, [X9]
	ADD X9, X9, X12
	LD1 {V2.4s}, [X9]
	ADD X9, X9, X12
	LD1 {V3.4s}, [X9]
 
	LSL X12, X4, #2
	LD1 {V4.4s}, [X10]
	ADD X10, X10, X12
	LD1 {V5.4s}, [X10]
	ADD X10, X10, X12
	LD1 {V6.4s}, [X10]
	ADD X10, X10, X12
	LD1 {V7.4s}, [X10]
	
	// Block multiply
	FMUL V8.4s, V4.4s, V0.4s[0]
	FMLA V8.4s, V5.4s, V0.4s[1]
	FMLA V8.4s, V6.4s, V0.4s[2]
	FMLA V8.4s, V7.4s, V0.4s[3]
 
	FMUL V9.4s, V4.4s, V1.4s[0]
	FMLA V9.4s, V5.4s, V1.4s[1]
	FMLA V9.4s, V6.4s, V1.4s[2]
	FMLA V9.4s, V7.4s, V1.4s[3]
 
	FMUL V10.4s, V4.4s, V2.4s[0]
	FMLA V10.4s, V5.4s, V2.4s[1]
	FMLA V10.4s, V6.4s, V2.4s[2]
	FMLA V10.4s, V7.4s, V2.4s[3]
 
	FMUL V11.4s, V4.4s, V3.4s[0]
	FMLA V11.4s, V5.4s, V3.4s[1]
	FMLA V11.4s, V6.4s, V3.4s[2]
	FMLA V11.4s, V7.4s, V3.4s[3]
 
	// Store datas
	LSL X12, X4, #2
	ST1 {V8.4s}, [X11]
	ADD X11, X11, X12
	ST1 {V9.4s}, [X11]
	ADD X11, X11, X12
	ST1 {V10.4s}, [X11]
	ADD X11, X11, X12
	ST1 {V11.4s}, [X11]
 
	B ctd3
 
finish:
	MOV X0, #0
	RET
