/* state_is_1_8d7428 @ 0x8d7428, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.state_is_1_8d7428,"ax",@progbits
	.global state_is_1_8d7428
state_is_1_8d7428:
L_8d7428:
	ldb_s r0,[r0]
L_8d742a:
	cmp_s r0,0x1
L_8d742c:
	mov_s r0,0x1
L_8d742e:
	j_s.d [blink]
