/* hwd_rfc__write_xpm_cmd @ 0x8d0438, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc__read_xpm_with_delay
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.hwd_rfc__write_xpm_cmd,"ax",@progbits
	.global hwd_rfc__write_xpm_cmd
hwd_rfc__write_xpm_cmd:
	.global L_8d0438
L_8d0438:
	mov_s r3,r1
L_8d043a:
	extb_s r0,r0
L_8d043c:
	mov_s r1,0xc
L_8d043e:
	b.d L_8d0f80
L_8d0442:
	mov_s r2,0x0
