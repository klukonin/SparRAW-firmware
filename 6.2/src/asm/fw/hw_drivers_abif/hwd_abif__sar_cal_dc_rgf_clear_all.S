/* hwd_abif__sar_cal_dc_rgf_clear_all @ 0x8cf900, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sar_cal_dc_rgf_clear_all
hwd_abif__sar_cal_dc_rgf_clear_all:
	.global L_8cf900
L_8cf900:
	mov lp_count,0x8
L_8cf904:
	mov_s r1,0x0
L_8cf906:
	lp L_8cf91a
L_8cf90a:
	mov_s r2,0x88af10
L_8cf910:
	mov_s r0,0x0
L_8cf912:
	add2_s r2,r2,r1
L_8cf914:
	st_s r0,[r2]
L_8cf916:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8cf918:
	extb_s r1,r1
	.global L_8cf91a
L_8cf91a:
	j_s [blink]
