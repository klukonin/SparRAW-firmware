/* xpm__write_3c8 @ 0x8d45d4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_cfg_set
 * Зовёт сам: rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__write_3c8
xpm__write_3c8:
	.global L_8d45d4
L_8d45d4:
	mov_s r2,r1
L_8d45d6:
	extb_s r0,r0
L_8d45d8:
	b.d L_8d4308
L_8d45dc:
	mov r1,0x3c8
