/* channels_switch_sm__action_abort_dwelling @ 0x8c203c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_abort_dwelling() while dwelling!!!
 * Зовут его: scan_mngr__prob_done, scan_mngr__stop_dwelling
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_abort_dwelling
channels_switch_sm__action_abort_dwelling:
	.global L_8c203c
L_8c203c:
	push_s blink
L_8c203e:
	push_s r13
L_8c2040:
	mov_s r13,r0
L_8c2042:
	mov_s r1,0x1017560
L_8c2048:
	bl.d L_8dcba8
L_8c204c:
	mov_s r0,0x29
L_8c204e:
	ld_s r0,[r13,0x14]
L_8c2050:
	cmp_s r0,0x0
L_8c2052:
	bl.ne L_8c8de0
L_8c2056:
	mov_s r0,r13
L_8c2058:
	mov_s r1,0x4
L_8c205a:
	mov_s r2,0x0
L_8c205c:
	mov_s r3,r2
L_8c205e:
	bl.d L_8d9b6c
L_8c2062:
	mov_s r4,r2
L_8c2064:
	b L_8c025c
