/* state_is_2_8d7414 @ 0x8d7414, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.state_is_2_8d7414,"ax",@progbits
	.global state_is_2_8d7414
state_is_2_8d7414:
L_8d7414:
	ldb_s r0,[r0]
L_8d7416:
	cmp_s r0,0x2
L_8d7418:
	mov_s r0,0x1
L_8d741a:
	j_s.d [blink]
