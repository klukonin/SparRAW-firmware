/* hwd_abif__rx_rgf_read_sar_dc @ 0x8cefa0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_rgf_read_sar_dc
hwd_abif__rx_rgf_read_sar_dc:
	.global L_8cefa0
L_8cefa0:
	rsub r3,r0,0x7
L_8cefa4:
	extb_s r3,r3
L_8cefa6:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8cefa8:
	add1_s r1,r1,r2
L_8cefaa:
	asr_s r0,r3,0x2
L_8cefac:
	add_s r0,r0,r1
L_8cefae:
	extb_s r0,r0
L_8cefb0:
	bmsk r1,r3,0x1
L_8cefb4:
	mov_s r2,0x88af10
L_8cefba:
	ld.as r0,[r2,r0]
L_8cefbe:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8cefc0:
	lsr_s r0,r0,r1
L_8cefc2:
	j_s.d [blink]
L_8cefc4:
	bmsk_s r0,r0,0x4
L_8cefc6:
	nop_s
