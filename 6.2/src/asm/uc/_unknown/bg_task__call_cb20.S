/* bg_task__call_cb20 @ 0x925040, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bg_task__call_cb20
bg_task__call_cb20:
	.global L_925040
L_925040:
	push_s blink
L_925042:
	ld_s r1,[r0,0x20]
L_925044:
	cmp_s r1,0x0
L_925046:
	jlne [r1]
L_92504a:
	pop_s blink
L_92504c:
	j_s [blink]
L_92504e:
	nop_s
