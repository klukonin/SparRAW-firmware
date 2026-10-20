/* hwd_abif__get_88af10 @ 0x8cbf5c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step2, ut_hw_flows_cmd_0x404
 */
	.section .text.hwd_abif__get_88af10,"ax",@progbits
	.global hwd_abif__get_88af10
hwd_abif__get_88af10:
	.global L_8cbf5c
L_8cbf5c:
	rsub r3,r0,0x7
L_8cbf60:
	extb_s r3,r3
L_8cbf62:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8cbf64:
	add1_s r1,r1,r2
L_8cbf66:
	asr_s r0,r3,0x2
L_8cbf68:
	add_s r0,r0,r1
L_8cbf6a:
	extb_s r0,r0
L_8cbf6c:
	bmsk r1,r3,0x1
L_8cbf70:
	mov_s r2,0x88af10
L_8cbf76:
	ld.as r0,[r2,r0]
L_8cbf7a:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8cbf7c:
	lsr_s r0,r0,r1
L_8cbf7e:
	j_s.d [blink]
L_8cbf80:
	bmsk_s r0,r0,0x4
L_8cbf82:
	nop_s
