/* bit_iter__has_more_uc @ 0x928aac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_powerup_deep_all_rfs
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bit_iter__has_more_uc
bit_iter__has_more_uc:
	.global L_928aac
L_928aac:
	ld_s r0,[r0]
L_928aae:
	sub.f r0,r0,0x0
L_928ab2:
	j_s.d [blink]
L_928ab4:
	mov.ne r0,0x1
