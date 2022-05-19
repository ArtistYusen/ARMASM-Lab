; Author: Yusen Zheng
; Date:   2022-05-14
	
	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

  ; Please write your code below that will implement:
  ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);

	LDR	r3, [r1, #4]	; source1->columns
	LDR	r4, [r2]	; source2->rows
	CMP r3, r4
	BEQ	success
	MOV r0, #1
	B return

success
	LDR	r3, [r1]	; source1->rows
	LDR	r4, [r2, #4]	; source2->columns
	LDR	r5, [r2]	; source1->columns == source2->rows
	STR	r3, [r0]	; results->rows
	STR	r4, [r0, #4]	; results->columns
	LDR r0, [r0, #8]	; 0->data
	LDR r1, [r1, #8]	; 1->data
	LDR r2, [r2, #8]	; 2->data
	MOV r6, #0	; i
	MOV r7, #0	; j
	MOV r8, #0	; k
	MOV r9, #0	; mul_data1
	MOV r10, #0	;	mul_data2
	B loop1

loop1
	CMP r6, r3
	BEQ return
	PUSH {LR}
	BL loop2
	POP {LR}
	ADD r6, #1
	MOV r7, #0
	B loop1

loop2
	CMP r7, r4
	BXEQ LR
	PUSH {LR}
	BL loop3
	POP {LR}
	ADD r7, #1
	MOV r8, #0
	B loop2

loop3
	CMP r8, r5
	BXEQ LR
	MLA r9, r6, r5, r8
	MLA r10, r8, r4, r7
	LSL r9, r9, #2
	LSL r10, r10, #2
	ADD r9, r1
	ADD r10, r2
	LDR r9, [r9]
	LDR r10, [r10]
	MUL r9, r9, r10
	MLA r10, r6, r5, r7
	LSL r10, R10, #2
	ADD r10, r0
	LDR r10, [r10]
	ADD r9, r9, r10
	MLA r10, r6, r5, r7
	LSL r10, R10, #2
	ADD r10, r0
	STR r9, [r10]
	ADD r8, #1
	B loop3

return
	CMP r3, r4
	MOVEQ r0, #0
	BX LR
	END
