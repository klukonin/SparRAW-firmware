/* mac__tsf_lo_after_n_bi @ 0x8e9874, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__update_aw_ie, ps_assoc_mgr__aw_ie_reception
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__tsf_lo_after_n_bi
mac__tsf_lo_after_n_bi:
	.global L_8e9874
L_8e9874:
	mov_s r1,r0
L_8e9876:
	mov_s r2,0x887000
L_8e987c:
	ld r0,[r2, -0x3c]
L_8e9880:
	ld.as r2,[r2,-0xa7]
L_8e9884:
	extw_s r2,r2
L_8e9886:
	asl_s r2,r2,0xa
L_8e9888:
	mul64_s r2,r1
L_8e988a:
	j_s.d [blink]
L_8e988c:
	add_s r0,r0,mlo
L_8e988e:
	nop_s
