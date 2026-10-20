/* sdp__program_880b00 @ 0x8d16b8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp__init_int_ctrl
 * Зовёт сам: set_reg_880b00_8d16a8, set_reg_880b00_8d16cc
 */
	.section .text.sdp__program_880b00,"ax",@progbits
	.global sdp__program_880b00
sdp__program_880b00:
	.global L_8d16b8
L_8d16b8:
	push_s blink
L_8d16ba:
	bl.d L_8d16a8
L_8d16be:
	mov_s r2,r0
L_8d16c0:
	bl.d L_8d16cc
L_8d16c4:
	mov_s r0,r2
L_8d16c6:
	pop_s blink
L_8d16c8:
	j_s [blink]
L_8d16ca:
	nop_s
