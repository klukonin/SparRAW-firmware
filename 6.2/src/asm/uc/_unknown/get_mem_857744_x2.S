/* get_mem_857744_x2 @ 0x927a34, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__arm_slot_from_cfg, l1_fixed_sched_sta_sm
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global get_mem_857744_x2
get_mem_857744_x2:
	.global L_927a34
L_927a34:
	mov_s r0,0x857700
L_927a3a:
	ld_s r0,[r0,0x44]
L_927a3c:
	j_s.d [blink]
L_927a3e:
	ldw r0,[r0, 0xa0]
L_927a42:
	nop_s
