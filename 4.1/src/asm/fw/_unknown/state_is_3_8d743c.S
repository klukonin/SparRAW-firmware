/* state_is_3_8d743c @ 0x8d743c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.state_is_3_8d743c,"ax",@progbits
	.global state_is_3_8d743c
state_is_3_8d743c:
L_8d743c:
	ldb_s r0,[r0]
L_8d743e:
	cmp_s r0,0x3
L_8d7440:
	mov_s r0,0x1
L_8d7442:
	j_s.d [blink]
