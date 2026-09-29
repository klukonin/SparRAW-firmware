/* ba_sm__action_8e21c4 @ 0x8e21c4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rcp_delba.
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8e21c4
ba_sm__action_8e21c4:
	.global L_8e21c4
L_8e21c4:
	push_s blink
L_8e21c6:
	bl L_8c01e4
L_8e21ca:
	mov_s r13,r0
L_8e21cc:
	mov_s r14,r1
L_8e21ce:
	mov_s r1,0x1013554
L_8e21d4:
	bl.d L_8dcba8
L_8e21d8:
	mov_s r0,0x2b
L_8e21da:
	add r0,r13,0x2c
L_8e21de:
	mov_s r1,0x3
L_8e21e0:
	mov_s r2,r14
L_8e21e2:
	mov_s r3,0x0
L_8e21e4:
	bl.d L_8d9b6c
L_8e21e8:
	mov_s r4,r3
L_8e21ea:
	b L_8c0254
L_8e21ee:
	nop_s
