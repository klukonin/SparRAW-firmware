/* xpm__wave_rd_set @ 0x8d4670, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_rf_xpm_cfg_set
 * Зовёт сам: rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__wave_rd_set
xpm__wave_rd_set:
	.global L_8d4670
L_8d4670:
	mov r3,0x378
L_8d4674:
	add2 r1,r3,r1
L_8d4678:
	b.d L_8d4308
L_8d467c:
	extb_s r0,r0
L_8d467e:
	nop_s
