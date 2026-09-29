/* rm_main_sm__kick_channel_switch_sm @ 0x8da6e4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::kick_channel_switch_sm. channelID=%d
 * Зовут его: rm_sm__action_8e4ee4, rm_sm__action_8e83f4, switch_2_secondary
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit1, sm__defer_call_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_main_sm__kick_channel_switch_sm
rm_main_sm__kick_channel_switch_sm:
	.global L_8da6e4
L_8da6e4:
	push_s blink
L_8da6e6:
	push_s r13
L_8da6e8:
	mov_s r13,r0
L_8da6ea:
	ldb_s r0,[r0,0x3]
L_8da6ec:
	breq_s r0,0,L_8da6fc
L_8da6ee:
	mov_s r1,0x1019090
L_8da6f4:
	mov_s r0,0x28
L_8da6f6:
	bl.d L_8dcc10
L_8da6fa:
	ld_s r2,[r13,0x54]
	.global L_8da6fc
L_8da6fc:
	ld r0,[r13, 0x94]
L_8da700:
	breq_s r0,0,L_8da71a
L_8da702:
	ld r0,[r13, 0x98]
L_8da706:
	breq_s r0,0,L_8da72c
L_8da708:
	ldb r4,[r13, 0x78]
L_8da70c:
	mov_s r0,r13
L_8da70e:
	ld_s r2,[r13,0x54]
L_8da710:
	mov_s r1,0x2
L_8da712:
	bl.d L_8e70c0
L_8da716:
	ld_s r3,[r13,0x58]
L_8da718:
	b_s L_8da72c
	.global L_8da71a
L_8da71a:
	add r0,r13,0x10
L_8da71e:
	add2 r2,r13,0x15
L_8da722:
	mov_s r1,0x0
L_8da724:
	mov_s r3,r1
L_8da726:
	bl.d L_8d9b6c
L_8da72a:
	mov_s r4,r1
	.global L_8da72c
L_8da72c:
	b L_8c025c
