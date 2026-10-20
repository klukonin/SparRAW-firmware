/* swc_psc_sm__action_kick_channel_sw_sm @ 0x8c21a0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   swc_psc_sm::action_kick_channel_sw_sm - Entry
 *   swc_psc_sm::action_kick_channel_sw_sm - Exit
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global swc_psc_sm__action_kick_channel_sw_sm
swc_psc_sm__action_kick_channel_sw_sm:
	.global L_8c21a0
L_8c21a0:
	push_s blink
L_8c21a2:
	bl L_8c01e4
L_8c21a6:
	mov_s r13,r0
L_8c21a8:
	mov_s r1,0x1017784
L_8c21ae:
	bl.d L_8dcba8
L_8c21b2:
	mov_s r0,0x29
L_8c21b4:
	ld_s r0,[r13,0x8]
L_8c21b6:
	ld r14,[r0, 0x80]
L_8c21ba:
	bl.d L_8c8de0
L_8c21be:
	ld_s r0,[r13,0xc]
L_8c21c0:
	mov_s r0,r14
L_8c21c2:
	mov_s r1,0x0
L_8c21c4:
	mov_s r2,r1
L_8c21c6:
	mov_s r3,r1
L_8c21c8:
	bl.d L_8d9b6c
L_8c21cc:
	mov_s r4,r1
L_8c21ce:
	mov_s r1,0x10177b4
L_8c21d4:
	bl.d L_8dcba8
L_8c21d8:
	mov_s r0,0x29
L_8c21da:
	b L_8c0254
L_8c21de:
	nop_s
