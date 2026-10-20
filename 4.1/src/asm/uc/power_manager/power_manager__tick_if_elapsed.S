/* power_manager__tick_if_elapsed @ 0x92b220, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: __ld_r13_ret_uc, power_manager__snapshot_marks, power_manager__update_deltas, uc_read_tsf_lo
 */
	.section .text.power_manager__tick_if_elapsed,"ax",@progbits
	.global power_manager__tick_if_elapsed
power_manager__tick_if_elapsed:
	.global L_92b220
L_92b220:
	push_s blink
L_92b222:
	bl.d L_9315e8
L_92b226:
	push_s r13
L_92b228:
	mov_s r13,r0
L_92b22a:
	mov_s r0,0x800724
L_92b230:
	ld_s r1,[r0]
L_92b232:
	sub r0,r13,r1
L_92b236:
	brlo r0,0x17ed0,L_92b24a
L_92b23e:
	bl.d L_92b1f0
L_92b242:
	mov_s r0,r13
L_92b244:
	bl.d L_92b20c
L_92b248:
	mov_s r0,r13
	.global L_92b24a
L_92b24a:
	b L_92028c
L_92b24e:
	nop_s
