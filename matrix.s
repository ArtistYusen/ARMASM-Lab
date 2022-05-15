; Author: Yusen Zheng
; Date:   2022-05-14

	AREA	program, CODE, READONLY
matrix_mul
	EXPORT	matrix_mul

  ; Please write your code below that will implement:
  ;       int matrix_mul(Matrix *results, const Matrix *source1, const Matrix *source2);
	
	LDR		r3, [r1,#4]				; source1->columns
	LDR		r4, [r2]					; source2->rows
	CMP		r3, [r4]
	BNE		matrix_mul_fail		; can't be multiplied, not save PC+4 to LR, directly return
	; can be multiplied
	LDR		r3, [r1]					; source1->rows
	LDR		r4, [r2,#4]				; source2->columns
	LDR		r5, [r2] 					; source1->columns == source2->rows
	STR		r3, [r0]					; results->rows
	STR		r4, [r0,#4]				; results->columns
	MOV		r6, #0						; i = 0
	MOV		r7, #0						; j = 0
	MOV		r8, #0						; k = 0
; -------------------------------------------------------------------------------------------------

; loop1
; 	CMP 	r6, r3
; 	BEQ 	finish
; 	MOV		r7, #0
; 	BL		loop2
; 	ADD		r6, #1
; 	B			loop1
; ; -------------------------------------------------------------------------------------------------

; loop2
; 	CMP		r7, r4
; 	BXEQ 	LR
; 	MOV		r8, #0
; 	BL		loop3
; 	ADD		r7, #1
; 	B			loop2
; ; -------------------------------------------------------------------------------------------------


; loop3
; 	CMP		r8, r5
; 	BXEQ	LR
; 	LDR		r9, [r1, r6, LSL #2]		; source1->data[i][j]
; 	ADD		r8, #1
; 	B			loop3
; ; -------------------------------------------------------------------------------------------------

finish
	MOV		r0, #0						; r0 = 0, success
	MOV   PC, LR						; return //TODO: need to check
	BX		LR
	END
; -------------------------------------------------------------------------------------------------

matrix_mul_fail
	MOV		r0, #1						; r0 = 1, failed
	MOV   PC, LR						; return //TODO: need to check
	BX		LR
	END