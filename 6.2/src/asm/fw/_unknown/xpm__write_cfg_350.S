/* xpm__write_cfg_350 @ 0x8d4650, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_rf_xpm_cfg_set
 * Зовёт сам: rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__write_cfg_350
xpm__write_cfg_350:
	.global L_8d4650
L_8d4650:
	mov r3,0x350
L_8d4654:
	add2 r1,r3,r1
L_8d4658:
	b.d L_8d4308
L_8d465c:
	extb_s r0,r0
L_8d465e:
	nop_s
