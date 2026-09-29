/* mac__mul_886fc4_by_886d64 @ 0x8e47b4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_scheduled_dti__update_ie, mid__update_aw_ie, ps_assoc_mgr__aw_ie_reception
 */
	.section .text.mac__mul_886fc4_by_886d64,"ax",@progbits
	.global mac__mul_886fc4_by_886d64
mac__mul_886fc4_by_886d64:
	.global L_8e47b4
L_8e47b4:
	mov_s r1,r0
L_8e47b6:
	mov_s r2,0x887000
L_8e47bc:
	ld r0,[r2, -0x3c]
L_8e47c0:
	ld.as r2,[r2,-0xa7]
L_8e47c4:
	extw_s r2,r2
L_8e47c6:
	asl_s r2,r2,0xa
L_8e47c8:
	mul64_s r2,r1
L_8e47ca:
	j_s.d [blink]
L_8e47cc:
	add_s r0,r0,mlo
L_8e47ce:
	nop_s
