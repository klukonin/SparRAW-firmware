/* fsched_slot__clear_f3 @ 0x924f94, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__run_tx_slot_twice
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_slot__clear_f3
fsched_slot__clear_f3:
	.global L_924f94
L_924f94:
	ldb r1,[r0, 0x28]
L_924f98:
	mov_s r2,0x0
L_924f9a:
	add2_s r1,r1,r1
L_924f9c:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_924f9e:
	add_s r0,r0,r1
L_924fa0:
	j_s.d [blink]
L_924fa2:
	stb_s r2,[r0]
