/* xpm__read_data_byte @ 0x8d1384, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_read_byte
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_rfc_xpm_get_data_output, xpm__write_addr
 */
	.section .text.xpm__read_data_byte,"ax",@progbits
	.global xpm__read_data_byte
xpm__read_data_byte:
	.global L_8d1384
L_8d1384:
	push_s blink
L_8d1386:
	bl L_8c02c4
L_8d138a:
	mov_s r13,r0
L_8d138c:
	bl.d L_8d13a4
L_8d1390:
	mov_s r14,r2
L_8d1392:
	mov_s r0,r13
L_8d1394:
	mov_s r1,r14
L_8d1396:
	mov_s r2,0x1
L_8d1398:
	mov_s r3,0x7d
L_8d139a:
	/* bl.d 0x008d1300 */
	.byte 0x6a,0x0f,0xef,0xff
L_8d139e:
	/* _asl_s r3,r3,0x5 */
	.byte 0x05,0xbb
L_8d13a0:
	b L_8c0334
