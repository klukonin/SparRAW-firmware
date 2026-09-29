/* field_set_0x00__8db2fc @ 0x8db2fc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_bcon_del_0b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8db2fc
field_set_0x00__8db2fc:
	.global L_8db2fc
L_8db2fc:
	mov_s r1,0x1
L_8db2fe:
	j_s.d [blink]
L_8db300:
	st_s r1,[r0]
L_8db302:
	nop_s
