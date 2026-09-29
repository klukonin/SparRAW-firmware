/* get_reg88b0c0_s2_w32 @ 0x8ce6f0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, link_lost_diag__dump_pcie, power_halt_seq
 */
	.section .text.get_reg88b0c0_s2_w32,"ax",@progbits
	.global get_reg88b0c0_s2_w32
get_reg88b0c0_s2_w32:
	.global L_8ce6f0
L_8ce6f0:
	mov_s r0,0x88b080
L_8ce6f6:
	ld_s r0,[r0,0x40]
L_8ce6f8:
	lsr_s r0,r0,0x2
L_8ce6fa:
	j_s.d [blink]
L_8ce6fc:
	bmsk_s r0,r0,0x3
L_8ce6fe:
	nop_s
