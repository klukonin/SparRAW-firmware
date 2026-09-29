/* xpm__write_3cc @ 0x8d4694, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_cfg_set
 * Зовёт сам: rfc_field_write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__write_3cc
xpm__write_3cc:
	.global L_8d4694
L_8d4694:
	mov_s r2,r1
L_8d4696:
	extb_s r0,r0
L_8d4698:
	b.d L_8d4308
L_8d469c:
	mov r1,0x3cc
