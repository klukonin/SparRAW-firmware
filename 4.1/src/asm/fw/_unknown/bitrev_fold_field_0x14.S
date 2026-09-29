/* bitrev_fold_field_0x14 @ 0x8ca8e4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bit_reverse32
 */
	.section .text.bitrev_fold_field_0x14,"ax",@progbits
	.global bitrev_fold_field_0x14
bitrev_fold_field_0x14:
L_8ca8e4:
	push_s blink
L_8ca8e6:
	bl.d L_8c02c4
L_8ca8ea:
	mov_s r2,0x0
L_8ca8ec:
	mov_s r14,r0
L_8ca8ee:
	mov_s r13,r2
	.global L_8ca8f0
L_8ca8f0:
	add3 r1,r14,r13
L_8ca8f4:
	mov_s r0,r14
L_8ca8f6:
	bl.d L_8da448
L_8ca8fa:
	ld_s r1,[r1,0x14]
L_8ca8fc:
	add.f r13,r13,0x1
L_8ca900:
	or_s r2,r2,r0
L_8ca902:
	beq_s L_8ca8f0
L_8ca904:
	b.d L_8c0334
L_8ca908:
	mov_s r0,r2
L_8ca90a:
	nop_s
