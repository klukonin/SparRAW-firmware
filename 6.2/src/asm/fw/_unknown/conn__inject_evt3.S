/* conn__inject_evt3 @ 0x8dc4cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm__inject_conn_evt3
 * Зовёт сам: conn__sm_handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__inject_evt3
conn__inject_evt3:
	.global L_8dc4cc
L_8dc4cc:
	mov_s r1,0x3
L_8dc4ce:
	mov_s r2,0x0
L_8dc4d0:
	mov_s r3,r2
L_8dc4d2:
	b.d L_8d9cc0
L_8dc4d6:
	mov_s r4,r2
