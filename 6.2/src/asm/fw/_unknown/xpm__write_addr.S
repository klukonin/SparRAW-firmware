/* xpm__write_addr @ 0x8d4600, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: xpm__read_data_byte
 * Зовёт сам: hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global xpm__write_addr
xpm__write_addr:
	.global L_8d4600
L_8d4600:
	extw_s r3,r1
L_8d4602:
	extb_s r0,r0
L_8d4604:
	mov_s r1,0xc
L_8d4606:
	b.d L_8d415c
L_8d460a:
	mov_s r2,0x0
