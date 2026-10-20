/* hwd_abif__rx_prepared_rvga_pwdn_get @ 0x8ceed0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_prepared_rvga_pwdn_get
hwd_abif__rx_prepared_rvga_pwdn_get:
	.global L_8ceed0
L_8ceed0:
	mov_s r0,0x88ae00
L_8ceed6:
	ld_s r0,[r0,0x60]
L_8ceed8:
	lsr_s r0,r0,0x2
L_8ceeda:
	j_s.d [blink]
L_8ceedc:
	extb_s r0,r0
L_8ceede:
	nop_s
