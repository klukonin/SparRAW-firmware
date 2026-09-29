/* mac_bringup__set_886a80_ctl_bit0 @ 0x8f6c34, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: low_sme__termination_check
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__set_886a80_ctl_bit0
mac_bringup__set_886a80_ctl_bit0:
	.global L_8f6c34
L_8f6c34:
	mov_s r1,0x886a80
L_8f6c3a:
	ld_s r0,[r1,0x20]
L_8f6c3c:
	bset_s r0,r0,0x0
L_8f6c3e:
	st_s r0,[r1,0x20]
L_8f6c40:
	j_s [blink]
L_8f6c42:
	nop_s
L_8f6c44:
	b.d L_8e9110
L_8f6c48:
	mov_s r0,0x0
L_8f6c4a:
	nop_s
