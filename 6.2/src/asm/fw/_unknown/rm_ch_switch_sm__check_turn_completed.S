/* rm_ch_switch_sm__check_turn_completed @ 0x8c6484, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_ch_switch_sm::check_turn_completed. pend flags = 0x%x, recvd flags = 0x%x
 * Зовут его: rm_ch_switch_sm__action_8c7f14, rm_ch_switch_sm__action_8e3a9c, rm_ch_switch_sm__action_8e3ac8
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2, sm__defer_call
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__check_turn_completed
rm_ch_switch_sm__check_turn_completed:
	.global L_8c6484
L_8c6484:
	push_s blink
L_8c6486:
	bl L_8c01e4
L_8c648a:
	mov_s r13,r0
L_8c648c:
	ldb_s r0,[r0,0x3]
L_8c648e:
	mov_s r14,r1
L_8c6490:
	ld_s r2,[r13,0x10]
L_8c6492:
	ld_s r3,[r13,0x14]
L_8c6494:
	breq_s r0,0,L_8c64a2
L_8c6496:
	mov_s r1,0x101946c
L_8c649c:
	bl.d L_8dcc80
L_8c64a0:
	mov_s r0,0x28
	.global L_8c64a2
L_8c64a2:
	ld_s r1,[r13,0x14]
L_8c64a4:
	ld_s r0,[r13,0x10]
L_8c64a6:
	brne r0,r1,L_8c64ce
L_8c64aa:
	mov_s r0,0x0
L_8c64ac:
	st_s r0,[r13,0x10]
L_8c64ae:
	st_s r0,[r13,0x14]
L_8c64b0:
	brne_s r14,0,L_8c64c0
L_8c64b2:
	ld_s r0,[r13,0xc]
L_8c64b4:
	ld_s r0,[r0,0x4]
L_8c64b6:
	cmp_s r0,0x0
L_8c64b8:
	mov.ne r0,r13
L_8c64bc:
	mov_s r1,0x4
L_8c64be:
	bne_s L_8c64c4
	.global L_8c64c0
L_8c64c0:
	mov_s r0,r13
L_8c64c2:
	mov_s r1,0x6
	.global L_8c64c4
L_8c64c4:
	mov_s r2,0x0
L_8c64c6:
	mov_s r3,r2
L_8c64c8:
	bl.d L_8e7044
L_8c64cc:
	mov_s r4,r2
	.global L_8c64ce
L_8c64ce:
	b L_8c0254
L_8c64d2:
	nop_s
