/* bi_mode__unmask_all_events @ 0x9315c0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_substep
 * Зовёт сам: uc_irq_set_level
 */
	.section .text.bi_mode__unmask_all_events,"ax",@progbits
	.global bi_mode__unmask_all_events
bi_mode__unmask_all_events:
	.global L_9315c0
L_9315c0:
	st.as 0x98f3f,[gp,-0x19]
L_9315c8:
	mov_s r1,0x886e00
L_9315ce:
	mov r2,-0x1
L_9315d2:
	st_s r2,[r1,0x24]
L_9315d4:
	st_s r2,[r1,0x40]
L_9315d6:
	ld_s r0,[gp,-0x64]
L_9315d8:
	not_s r0,r0
L_9315da:
	st_s r0,[r1,0x30]
L_9315dc:
	st_s r2,[r1,0x4c]
L_9315de:
	mov_s r0,0x6
L_9315e0:
	b.d L_9219b4
L_9315e4:
	mov_s r1,0x1
L_9315e6:
	nop_s
