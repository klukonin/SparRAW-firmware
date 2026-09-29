/* rm_ch_switch_sm__check_turn_completed @ 0x8c57b0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::check_turn_completed. pend flags = 0x%x, recvd flags = 0x%x
 * Зовут его: rm_ch_switch_sm__turn_step, rm_chan_sw_sm__on_ucode_rx_off_evt, rm_chan_sw_sm__on_ucode_rx_on_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__store_pending_event, fw_log__emit2
 */
	.section .text.rm_ch_switch_sm__check_turn_completed,"ax",@progbits
	.global rm_ch_switch_sm__check_turn_completed
rm_ch_switch_sm__check_turn_completed:
	.global L_8c57b0
L_8c57b0:
	push_s blink
L_8c57b2:
	bl L_8c02c4
L_8c57b6:
	mov_s r13,r0
L_8c57b8:
	ld_s r0,[r0,0x28]
L_8c57ba:
	mov_s r14,r1
L_8c57bc:
	ld_s r3,[r13,0x34]
L_8c57be:
	ld r4,[r13, 0x38]
L_8c57c2:
	breq_s r0,0,L_8c57d2
L_8c57c4:
	mov_s r2,0x10160c4
L_8c57ca:
	mov_s r0,0x8
L_8c57cc:
	bl.d L_8edff8
L_8c57d0:
	mov_s r1,0x2
	.global L_8c57d2
L_8c57d2:
	ld_s r1,[r13,0x38]
L_8c57d4:
	ld_s r0,[r13,0x34]
L_8c57d6:
	brne r0,r1,L_8c57fe
L_8c57da:
	mov_s r0,0x0
L_8c57dc:
	st_s r0,[r13,0x34]
L_8c57de:
	st_s r0,[r13,0x38]
L_8c57e0:
	brne_s r14,0,L_8c57f0
L_8c57e2:
	ld_s r0,[r13,0x30]
L_8c57e4:
	ld_s r0,[r0,0x4]
L_8c57e6:
	cmp_s r0,0x0
L_8c57e8:
	mov.ne r0,r13
L_8c57ec:
	mov_s r1,0x4
L_8c57ee:
	bne_s L_8c57f4
	.global L_8c57f0
L_8c57f0:
	mov_s r0,r13
L_8c57f2:
	mov_s r1,0x6
	.global L_8c57f4
L_8c57f4:
	mov_s r2,0x0
L_8c57f6:
	mov_s r3,r2
L_8c57f8:
	bl.d L_8e20c0
L_8c57fc:
	mov_s r4,r2
	.global L_8c57fe
L_8c57fe:
	b L_8c0334
L_8c5802:
	nop_s
