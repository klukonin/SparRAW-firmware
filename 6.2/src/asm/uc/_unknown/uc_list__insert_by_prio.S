/* uc_list__insert_by_prio @ 0x920a00, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_structs
 * Зовёт сам: timer_list__insert_sorted
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_list__insert_by_prio
uc_list__insert_by_prio:
	.global L_920a00
L_920a00:
	push_s blink
L_920a02:
	ldb_s r1,[r0,0x8]
L_920a04:
	bl.d L_92e788
L_920a08:
	mov_s r2,0x0
L_920a0a:
	mov_s r0,0x0
L_920a0c:
	pop_s blink
L_920a0e:
	j_s [blink]
