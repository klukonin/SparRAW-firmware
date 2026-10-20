/* conn__inject_evt3 @ 0x8d8ea0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_main_sm__inject_conn_evt3
 * Зовёт сам: conn_sm__inject_event
 */
	.section .text.conn__inject_evt3,"ax",@progbits
	.global conn__inject_evt3
conn__inject_evt3:
	.global L_8d8ea0
L_8d8ea0:
	mov_s r1,0x3
L_8d8ea2:
	mov_s r2,0x0
L_8d8ea4:
	mov_s r3,r2
L_8d8ea6:
	b.d L_8d6b78
L_8d8eaa:
	mov_s r4,r2
