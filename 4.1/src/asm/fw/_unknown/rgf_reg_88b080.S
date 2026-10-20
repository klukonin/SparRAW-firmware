/* rgf_reg_88b080 @ 0x8cee78, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__send_traffic_deferral_evt, l2mgr__send_traffic_resume_evt
 */
	.section .text.rgf_reg_88b080,"ax",@progbits
	.global rgf_reg_88b080
rgf_reg_88b080:
	.global L_8cee78
L_8cee78:
	mov_s r1,0x88b080
L_8cee7e:
	cmp_s r0,0x0
L_8cee80:
	ld_s r0,[r1,0x3c]
L_8cee82:
	bic r0,r0,0x7
L_8cee86:
	bset.ne r0,r0,0x0
L_8cee8a:
	st_s r0,[r1,0x3c]
L_8cee8c:
	j_s [blink]
L_8cee8e:
	nop_s
