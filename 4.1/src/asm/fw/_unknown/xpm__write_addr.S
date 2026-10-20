/* xpm__write_addr @ 0x8d13a4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: xpm__read_data_byte
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.xpm__write_addr,"ax",@progbits
	.global xpm__write_addr
xpm__write_addr:
	.global L_8d13a4
L_8d13a4:
	extw_s r3,r1
L_8d13a6:
	extb_s r0,r0
L_8d13a8:
	mov_s r1,0xc
L_8d13aa:
	b.d L_8d0f80
L_8d13ae:
	mov_s r2,0x0
