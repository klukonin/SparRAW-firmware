/* hwd_pcie__get_88b0c0_state4 @ 0x8d13ec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, link_lost_diag__dump_pcie, power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__get_88b0c0_state4
hwd_pcie__get_88b0c0_state4:
	.global L_8d13ec
L_8d13ec:
	mov_s r0,0x88b080
L_8d13f2:
	ld_s r0,[r0,0x40]
L_8d13f4:
	lsr_s r0,r0,0x2
L_8d13f6:
	j_s.d [blink]
L_8d13f8:
	bmsk_s r0,r0,0x3
L_8d13fa:
	nop_s
