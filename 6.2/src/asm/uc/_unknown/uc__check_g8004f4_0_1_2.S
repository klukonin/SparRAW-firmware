/* uc__check_g8004f4_0_1_2 @ 0x92cd0c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: l1__on_event4, l1_fixed_sched__event_entry
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc__check_g8004f4_0_1_2
uc__check_g8004f4_0_1_2:
	.global L_92cd0c
L_92cd0c:
	ld_s r0,[gp,-0x34]
L_92cd0e:
	cmp_s r0,0x0
L_92cd10:
	beq L_92cd20
L_92cd14:
	cmp_s r0,0x1
L_92cd16:
	cmp.ne r0,0x2
L_92cd1a:
	beq L_92cd94
L_92cd1e:
	j_s [blink]
