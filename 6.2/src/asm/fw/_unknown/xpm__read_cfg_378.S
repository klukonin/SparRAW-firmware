/* xpm__read_cfg_378 @ 0x8d4660, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_rf_xpm_cfg_get
 * Зовёт сам: hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__read_cfg_378
xpm__read_cfg_378:
	.global L_8d4660
L_8d4660:
	mov r2,0x378
L_8d4664:
	add2 r1,r2,r1
L_8d4668:
	b.d L_8d3588
L_8d466c:
	extb_s r0,r0
L_8d466e:
	nop_s
