/* state_sm_8030f4__action_8f9994 @ 0x8f9994, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND_SM:: Start search
 *   FIND_SM:: free dband info when start SRCH
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, find_mng__add_bcon, find_mngr__search_end, free_dband_info, fw_log_emit0, llist__pop_front
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global state_sm_8030f4__action_8f9994
state_sm_8030f4__action_8f9994:
	.global L_8f9994
L_8f9994:
	push_s blink
L_8f9996:
	bl L_8c01e4
L_8f999a:
	mov_s r14,r0
L_8f999c:
	mov_s r1,0x1017b70
L_8f99a2:
	bl.d L_8dcba8
L_8f99a6:
	mov_s r0,0x2c
L_8f99a8:
	b_s L_8f99c0
	.global L_8f99aa
L_8f99aa:
	mov_s r1,0x1017b88
L_8f99b0:
	bl.d L_8dcba8
L_8f99b4:
	mov_s r0,0x1c
L_8f99b6:
	bl.d L_8e2674
L_8f99ba:
	mov_s r0,r13
L_8f99bc:
	bl L_8f31a0
	.global L_8f99c0
L_8f99c0:
	add r13,r14,0x18
L_8f99c4:
	ld_s r0,[r13]
L_8f99c6:
	sub.f r0,r0,0x0
L_8f99ca:
	mov.ne r0,0x1
L_8f99ce:
	extb.f 0x0,r0
L_8f99d2:
	bne_s L_8f99aa
L_8f99d4:
	bl.d L_8c2870
L_8f99d8:
	ld_s r0,[r14,0x10]
L_8f99da:
	bl.d L_8e4c8c
L_8f99de:
	ld_s r0,[r14,0x10]
L_8f99e0:
	b L_8c0254
