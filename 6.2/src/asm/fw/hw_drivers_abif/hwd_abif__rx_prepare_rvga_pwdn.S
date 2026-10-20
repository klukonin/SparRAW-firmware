/* hwd_abif__rx_prepare_rvga_pwdn @ 0x8cee94, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_prepare_rvga_pwdn
hwd_abif__rx_prepare_rvga_pwdn:
	.global L_8cee94
L_8cee94:
	push_s blink
L_8cee96:
	push_s r13
L_8cee98:
	mov_s r13,r0
L_8cee9a:
	bic.f r0,r0,0xff
L_8cee9e:
	bne_s L_8ceeb6
	.global L_8ceea0
L_8ceea0:
	mov_s r1,0x88ae00
L_8ceea6:
	ld_s r0,[r1,0x60]
L_8ceea8:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ceeaa:
	bic r0,r0,0x3fc
L_8ceeae:
	or_s r13,r13,r0
L_8ceeb0:
	st_s r13,[r1,0x60]
L_8ceeb2:
	b L_8c025c
	.global L_8ceeb6
L_8ceeb6:
	mov_s r0,blink
L_8ceeb8:
	bl.d L_8c9b28
L_8ceebc:
	mov_s r1,0xac
L_8ceebe:
	b_s L_8ceea0
