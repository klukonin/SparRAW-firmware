/* hwd_abif__rgf_88a200_8cca94 @ 0x8cca94, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_a, calib_sar__vt18, hwf_calib__release_hw
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_88a200_8cca94,"ax",@progbits
	.global hwd_abif__rgf_88a200_8cca94
hwd_abif__rgf_88a200_8cca94:
	.global L_8cca94
L_8cca94:
	push_s blink
L_8cca96:
	push_s r13
L_8cca98:
	mov_s r13,r0
L_8cca9a:
	bclr.f r0,r0,0x0
L_8cca9e:
	bne_s L_8ccab4
	.global L_8ccaa0
L_8ccaa0:
	mov_s r1,0x88a200
L_8ccaa6:
	ld_s r0,[r1,0x4]
L_8ccaa8:
	asl_s r13,r13,0x19
L_8ccaaa:
	bclr_s r0,r0,0x19
L_8ccaac:
	or_s r13,r13,r0
L_8ccaae:
	st_s r13,[r1,0x4]
L_8ccab0:
	b L_8c033c
	.global L_8ccab4
L_8ccab4:
	mov_s r0,blink
L_8ccab6:
	mov_s r2,0x1019954
L_8ccabc:
	mov_s r1,0xac
L_8ccabe:
	bl.d L_8c82c0
L_8ccac2:
	mov r3,0x268
L_8ccac6:
	b_s L_8ccaa0
