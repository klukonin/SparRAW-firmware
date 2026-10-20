/* hwd_abif__set_88af10 @ 0x8cca78, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_mngr_step_a, power_mngr_on_unassoc_start
 */
	.section .text.hwd_abif__set_88af10,"ax",@progbits
	.global hwd_abif__set_88af10
hwd_abif__set_88af10:
	.global L_8cca78
L_8cca78:
	mov lp_count,0x8
L_8cca7c:
	mov_s r1,0x0
L_8cca7e:
	lp L_8cca92
L_8cca82:
	mov_s r2,0x88af10
L_8cca88:
	mov_s r0,0x0
L_8cca8a:
	add2_s r2,r2,r1
L_8cca8c:
	st_s r0,[r2]
L_8cca8e:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8cca90:
	extb_s r1,r1
	.global L_8cca92
L_8cca92:
	j_s [blink]
