/* hwd_phy__rgf_885000_8cfc0c @ 0x8cfc0c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step2, hwf_calib_sar_alg
 */
	.section .text.hwd_phy__rgf_885000_8cfc0c,"ax",@progbits
	.global hwd_phy__rgf_885000_8cfc0c
hwd_phy__rgf_885000_8cfc0c:
	.global L_8cfc0c
L_8cfc0c:
	mov_s r1,0x885000
L_8cfc12:
	ld_s r0,[r1]
L_8cfc14:
	bset_s r0,r0,0x6
L_8cfc16:
	st_s r0,[r1]
L_8cfc18:
	j_s [blink]
L_8cfc1a:
	nop_s
