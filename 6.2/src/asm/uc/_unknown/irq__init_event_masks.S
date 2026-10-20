/* irq__init_event_masks @ 0x9364a0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_substep
 * Зовёт сам: uc_irq_set_level
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global irq__init_event_masks
irq__init_event_masks:
	.global L_9364a0
L_9364a0:
	st.as 0x98f3f,[gp,-0x1b]
L_9364a8:
	mov_s r1,0x886e00
L_9364ae:
	mov r2,-0x1
L_9364b2:
	st_s r2,[r1,0x24]
L_9364b4:
	st_s r2,[r1,0x40]
L_9364b6:
	ld_s r0,[gp,-0x6c]
L_9364b8:
	not_s r0,r0
L_9364ba:
	st_s r0,[r1,0x30]
L_9364bc:
	st_s r2,[r1,0x4c]
L_9364be:
	mov_s r0,0x6
L_9364c0:
	b.d L_921018
L_9364c4:
	mov_s r1,0x1
L_9364c6:
	nop_s
