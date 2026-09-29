/* get_reg88265c_s1_w32 @ 0x8ce6c8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 */
	.section .text.get_reg88265c_s1_w32,"ax",@progbits
	.global get_reg88265c_s1_w32
get_reg88265c_s1_w32:
	.global L_8ce6c8
L_8ce6c8:
	mov_s r0,0x882600
L_8ce6ce:
	ld_s r0,[r0,0x5c]
L_8ce6d0:
	lsr_s r0,r0
L_8ce6d2:
	j_s.d [blink]
L_8ce6d4:
	bmsk_s r0,r0,0x0
L_8ce6d6:
	nop_s
