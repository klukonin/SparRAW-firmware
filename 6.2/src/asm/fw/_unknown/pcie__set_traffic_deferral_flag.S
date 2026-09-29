/* pcie__set_traffic_deferral_flag @ 0x8d1b10, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__send_traffic_deferral_evt, l2mgr__send_traffic_resume_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_traffic_deferral_flag
pcie__set_traffic_deferral_flag:
	.global L_8d1b10
L_8d1b10:
	mov_s r1,0x88b080
L_8d1b16:
	cmp_s r0,0x0
L_8d1b18:
	ld_s r0,[r1,0x3c]
L_8d1b1a:
	bic r0,r0,0x7
L_8d1b1e:
	bset.ne r0,r0,0x0
L_8d1b22:
	st_s r0,[r1,0x3c]
L_8d1b24:
	j_s [blink]
L_8d1b26:
	nop_s
