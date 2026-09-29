/* field_set_0x00__8d8db8 @ 0x8d8db8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__timer_init
 * Зовёт сам: u_schd__hw_timer_load_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__8d8db8
field_set_0x00__8d8db8:
	.global L_8d8db8
L_8d8db8:
	st_s r1,[r0]
L_8d8dba:
	b.d L_8e9178
L_8d8dbe:
	mov_s r0,r1
