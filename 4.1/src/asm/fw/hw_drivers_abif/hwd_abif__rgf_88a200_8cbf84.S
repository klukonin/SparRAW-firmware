/* hwd_abif__rgf_88a200_8cbf84 @ 0x8cbf84, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_a, calib_sar_step
 */
	.section .text.hwd_abif__rgf_88a200_8cbf84,"ax",@progbits
	.global hwd_abif__rgf_88a200_8cbf84
hwd_abif__rgf_88a200_8cbf84:
	.global L_8cbf84
L_8cbf84:
	mov_s r1,0x88a200
L_8cbf8a:
	ld_s r0,[r1,0x4]
L_8cbf8c:
	bclr_s r0,r0,0x0
L_8cbf8e:
	st_s r0,[r1,0x4]
L_8cbf90:
	ld_s r0,[r1,0x4]
L_8cbf92:
	bset_s r0,r0,0x0
L_8cbf94:
	st_s r0,[r1,0x4]
L_8cbf96:
	j_s [blink]
