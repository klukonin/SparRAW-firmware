/* state_is_2_8d7450 @ 0x8d7450, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.state_is_2_8d7450,"ax",@progbits
	.global state_is_2_8d7450
state_is_2_8d7450:
L_8d7450:
	ldb_s r0,[r0]
L_8d7452:
	cmp_s r0,0x2
L_8d7454:
	mov_s r0,0x1
L_8d7456:
	j_s.d [blink]
