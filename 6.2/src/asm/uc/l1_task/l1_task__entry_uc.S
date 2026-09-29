/* l1_task__entry_uc @ 0x92cae0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: l1_task__main_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__entry_uc
l1_task__entry_uc:
	.global L_92cae0
L_92cae0:
	ld_s r0,[gp,-0x34]
L_92cae2:
	cmp_s r0,0x0
L_92cae4:
	beq L_92caf4
L_92cae8:
	cmp_s r0,0x1
L_92caea:
	cmp.ne r0,0x2
L_92caee:
	beq L_92cc48
L_92caf2:
	j_s [blink]
