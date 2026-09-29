/* rm_main_sm__kick_channel_switch_sm @ 0x8d75dc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::kick_channel_switch_sm. channelID=%d
 * Зовут его: radio_manager_main_sm__on_sec_tune, radio_manager_main_sm__on_switch_2_primary, switch_2_secondary
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit1, tail_basic_sm__defer_event
 */
	.section .text.rm_main_sm__kick_channel_switch_sm,"ax",@progbits
	.global rm_main_sm__kick_channel_switch_sm
rm_main_sm__kick_channel_switch_sm:
	.global L_8d75dc
L_8d75dc:
	push_s blink
L_8d75de:
	bl L_8c02c4
L_8d75e2:
	mov_s r13,r0
L_8d75e4:
	ld_s r0,[r0,0x28]
L_8d75e6:
	add3 r14,r13,0x10
L_8d75ea:
	breq_s r0,0,L_8d75fc
L_8d75ec:
	mov_s r2,0x1015d20
L_8d75f2:
	mov_s r0,0x8
L_8d75f4:
	mov_s r1,0x2
L_8d75f6:
	bl.d L_8edfcc
L_8d75fa:
	ld_s r3,[r14,0x1c]
	.global L_8d75fc
L_8d75fc:
	ld_s r0,[r14,0x5c]
L_8d75fe:
	breq_s r0,0,L_8d7616
L_8d7600:
	ld_s r0,[r14,0x60]
L_8d7602:
	breq_s r0,0,L_8d7628
L_8d7604:
	ldb r4,[r13, 0xc0]
L_8d7608:
	mov_s r0,r13
L_8d760a:
	ld_s r2,[r14,0x1c]
L_8d760c:
	mov_s r1,0x2
L_8d760e:
	bl.d L_8e2118
L_8d7612:
	ld_s r3,[r14,0x20]
L_8d7614:
	b_s L_8d7628
	.global L_8d7616
L_8d7616:
	add r0,r13,0x34
L_8d761a:
	add2 r2,r13,0x27
L_8d761e:
	mov_s r1,0x0
L_8d7620:
	mov_s r3,r1
L_8d7622:
	bl.d L_8d6a1c
L_8d7626:
	mov_s r4,r1
	.global L_8d7628
L_8d7628:
	b L_8c0334
