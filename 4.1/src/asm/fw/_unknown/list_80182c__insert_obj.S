/* list_80182c__insert_obj @ 0x8c1a60, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: init_globals_sweep
 * Зовёт сам: list_80182c__insert_sorted
 */
	.section .text.list_80182c__insert_obj,"ax",@progbits
	.global list_80182c__insert_obj
list_80182c__insert_obj:
	.global L_8c1a60
L_8c1a60:
	push_s blink
L_8c1a62:
	ldb_s r1,[r0,0x8]
L_8c1a64:
	bl.d L_8dd000
L_8c1a68:
	mov_s r2,0x0
L_8c1a6a:
	mov_s r0,0x0
L_8c1a6c:
	pop_s blink
L_8c1a6e:
	j_s [blink]
