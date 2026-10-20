/* field_set_0x00__8dbcb0 @ 0x8dbcb0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x03
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8dbcb0
field_set_0x00__8dbcb0:
	.global L_8dbcb0
L_8dbcb0:
	mov_s r1,0x1
L_8dbcb2:
	j_s.d [blink]
L_8dbcb4:
	st_s r1,[r0]
L_8dbcb6:
	nop_s
