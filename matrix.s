; Author: Yusen Zheng
	
	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

  ; Please write your code below that will implement:
  ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);

	LDR r3, [r1, #4]	; source1->columns
	LDR r4, [r2]	; source2->rows
	CMP r3, r4
	BEQ success
	MOV r0, #1 ; fail
	B return

success
	LDR r3, [r1]	; source1->rows
	LDR r4, [r2, #4]	; source2->columns
	LDR r5, [r2]	; source1->columns == source2->rows
	STR r3, [r0]	; results->rows
	STR r4, [r0, #4]	; results->columns
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
	CMP r6, r3	; i < source1->rows
	BEQ return
	PUSH {LR}
	BL loop2
	POP {LR}
	ADD r6, #1	; i++
	MOV r7, #0	; j = 0
	B loop1

loop2
	CMP r7, r4	; j < source2->columns
	BXEQ LR
	PUSH {LR}
	BL loop3
	POP {LR}
	ADD r7, #1	; j++
	MOV r8, #0	; k = 0
	B loop2

loop3
	CMP r8, r5	; k < source1->columns <=> k < source2->rows
	BXEQ LR
	MLA r9, r6, r5, r8	; mul_data1_address = i * col1 + j (i * r5 + j)
	MLA r10, r8, r4, r7	; mul_data2_address = j * col2 + k (j * r4 + k)
	LSL r9, r9, #2	; mul_data1_address *= 4
	LSL r10, r10, #2	; mul_data2_address *= 4
	ADD r9, r1, r9	; mul_data1_address += source1_data_address
	ADD r10, r2, r10	; mul_data2_address += source2_data_address
	LDR r9, [r9]	; mul_data1 = source1[i,j]
	LDR r10, [r10]	; mul_data2 = source2[j,k]
	MUL r9, r9, r10	; mul_data1 *= source2[j,k]
	MLA r10, r6, r4, r7	; res_data_address = i * col2 + j (i * r4 + j)
	LSL r10, R10, #2	; res_data_address *= 4
	ADD r10, r0, r10	; res_data_address += results_data_address
	LDR r10, [r10]	; res_data = results[i,j]
	ADD r9, r9, r10	; res_data += source[i,k] * source2[j,k]
	MLA r10, r6, r4, r7	; res_data_address = i * col2 + j (i * r4 + j)
	LSL r10, R10, #2	; res_data_address *= 4
	ADD r10, r0, r10	; res_data_address += results_data_address
	STR r9, [r10]	; results[i,j] = res_data
	ADD r8, #1	; k++
	B loop3

return
	CMP r3, r4
	MOVEQ r0, #0 ; success
	BX LR
	END
