/* uc_ap__read_triggered_mask @ 0x920f9c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_vector_02
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_ap__read_triggered_mask
uc_ap__read_triggered_mask:
	.global L_920f9c
L_920f9c:
	lr r0,[0x5]
L_920fa0:
	lsr_s r0,r0,0x3
L_920fa2:
	j_s.d [blink]
L_920fa4:
	extb_s r0,r0
L_920fa6:
	nop_s
