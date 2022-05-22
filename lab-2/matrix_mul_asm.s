// Author: Yusen Zheng

	.text
	.global matrix_mul_asm

matrix_mul_asm:
    // Please write your code below that will implement:
    //       int matrix_mul_asm(Matrix* results, Matrix* source1, Matrix* source2);

		// Notes:
		// Data in the matrix is ranging from 0 to 255. 8 bits.

//	LDR X0, [R1]
//	LDR X1, [R2, #4]
//	STR X0, [R0]
//	STR X1, [R0, #4]

	// return 0;
	MOV		R0, #0
	
	RET
