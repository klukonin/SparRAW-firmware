/* xpm__read_cfg_350 @ 0x8d4640, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_rf_xpm_cfg_get
 * Зовёт сам: hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__read_cfg_350
xpm__read_cfg_350:
	.global L_8d4640
L_8d4640:
	mov r2,0x350
L_8d4644:
	add2 r1,r2,r1
L_8d4648:
	b.d L_8d3588
L_8d464c:
	extb_s r0,r0
L_8d464e:
	nop_s
