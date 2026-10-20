/* xpm__read_data_byte @ 0x8d45e0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_read_byte
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_rfc_xpm_get_data_output, xpm__write_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__read_data_byte
xpm__read_data_byte:
	.global L_8d45e0
L_8d45e0:
	push_s blink
L_8d45e2:
	bl L_8c01e4
L_8d45e6:
	mov_s r13,r0
L_8d45e8:
	bl.d L_8d4600
L_8d45ec:
	mov_s r14,r2
L_8d45ee:
	mov_s r0,r13
L_8d45f0:
	mov_s r1,r14
L_8d45f2:
	mov_s r2,0x1
L_8d45f4:
	mov_s r3,0x7d
L_8d45f6:
	/* bl.d 0x008d44e4 */
	.byte 0xf2,0x0e,0xef,0xff
L_8d45fa:
	/* _asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8d45fc:
	b L_8c0254
