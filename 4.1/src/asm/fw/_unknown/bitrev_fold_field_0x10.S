/* bitrev_fold_field_0x10 @ 0x8ca8b4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bit_reverse32
 */
	.section .text.bitrev_fold_field_0x10,"ax",@progbits
	.global bitrev_fold_field_0x10
bitrev_fold_field_0x10:
L_8ca8b4:
	push_s blink
L_8ca8b6:
	bl.d L_8c02c4
L_8ca8ba:
	mov_s r2,0x0
L_8ca8bc:
	mov_s r14,r0
L_8ca8be:
	mov_s r13,r2
	.global L_8ca8c0
L_8ca8c0:
	add3 r1,r14,r13
L_8ca8c4:
	mov_s r0,r14
L_8ca8c6:
	bl.d L_8da448
L_8ca8ca:
	ld_s r1,[r1,0x10]
L_8ca8cc:
	add.f r13,r13,0x1
L_8ca8d0:
	or_s r2,r2,r0
L_8ca8d2:
	beq_s L_8ca8c0
L_8ca8d4:
	b.d L_8c0334
L_8ca8d8:
	mov_s r0,r2
L_8ca8da:
	nop_s
