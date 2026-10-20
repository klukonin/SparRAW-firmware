/* rgf_reg_886a80 @ 0x8ee890, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.rgf_reg_886a80,"ax",@progbits
	.global rgf_reg_886a80
rgf_reg_886a80:
	.global L_8ee890
L_8ee890:
	mov_s r1,0x886a80
L_8ee896:
	ld_s r0,[r1,0x20]
L_8ee898:
	bset_s r0,r0,0x0
L_8ee89a:
	st_s r0,[r1,0x20]
