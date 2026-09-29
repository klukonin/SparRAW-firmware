/* xpm__read_3c8 @ 0x8d45c0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_cfg_get
 * Зовёт сам: hwd_rfc_read_rgf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__read_3c8
xpm__read_3c8:
	.global L_8d45c0
L_8d45c0:
	push_s blink
L_8d45c2:
	extb_s r0,r0
L_8d45c4:
	bl.d L_8d3588
L_8d45c8:
	mov r1,0x3c8
L_8d45cc:
	bmsk_s r0,r0,0x17
L_8d45ce:
	pop_s blink
L_8d45d0:
	j_s [blink]
L_8d45d2:
	nop_s
