/* channels_switch_sm__action_pop_ch_and_tune @ 0x8c2228, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_pop_ch_and_tune() Stop SCAN RM LOCK WD if running
 *   channels_switch_sm::action_pop_ch_and_tune() Scan channel #%d start. Current channel: %d
 *   channels_switch_sm::action_pop_ch_and_tune() No need to switch - working channel #%d
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, ftm_main_sm__radio_args, fw_log_emit0, fw_log_emit1, fw_log_emit2, llist__pop_front, radio_mgr__get_current_channel, scan_mngr__free_with_842c74, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_pop_ch_and_tune
channels_switch_sm__action_pop_ch_and_tune:
	.global L_8c2228
L_8c2228:
	push_s blink
L_8c222a:
	push_s r13
L_8c222c:
	mov_s r13,r0
L_8c222e:
	ld_s r0,[r0,0x10]
L_8c2230:
	sub_s sp,sp,0x4
L_8c2232:
	breq_s r0,0,L_8c2248
L_8c2234:
	bl L_8c8de0
L_8c2238:
	mov_s r0,0x0
L_8c223a:
	st_s r0,[r13,0x10]
L_8c223c:
	mov_s r1,0x1017268
L_8c2242:
	bl.d L_8dcba8
L_8c2246:
	mov_s r0,0x29
	.global L_8c2248
L_8c2248:
	ld_s r1,[r13,0x1c]
L_8c224a:
	ld_s r0,[r13,0x8]
L_8c224c:
	breq_s r1,0,L_8c2256
L_8c224e:
	bl L_8f3154
L_8c2252:
	mov_s r0,0x0
L_8c2254:
	st_s r0,[r13,0x1c]
	.global L_8c2256
L_8c2256:
	ld_s r0,[r13,0x8]
L_8c2258:
	ld_s r0,[r0,0x18]
L_8c225a:
	cmp_s r0,0x0
L_8c225c:
	mov_s r0,0x1
L_8c225e:
	sub_s.ne r0,r0,r0
L_8c2260:
	extb.f 0x0,r0
L_8c2264:
	mov.ne r0,r13
L_8c2268:
	mov.ne r1,0x6
L_8c226c:
	mov.ne r2,0x1
L_8c2270:
	sub_s.ne r3,r3,r3
L_8c2272:
	sub.ne r4,r4,r4
L_8c2276:
	bne_s L_8c22e0
L_8c2278:
	bl.d L_8cc130
L_8c227c:
	mov_s r0,sp
L_8c227e:
	ld_s r0,[r13,0x8]
L_8c2280:
	bl.d L_8e2674
L_8c2284:
	add_s r0,r0,0x18
L_8c2286:
	st_s r0,[r13,0x1c]
L_8c2288:
	mov_s r1,0x10172b8
L_8c228e:
	ld_s r2,[r0,0x8]
L_8c2290:
	mov_s r0,0x29
L_8c2292:
	bl.d L_8dcc80
L_8c2296:
	ld_s r3,[sp,0x0]
L_8c2298:
	ld_s r0,[r13,0x1c]
L_8c229a:
	ld_s r1,[r0,0x8]
L_8c229c:
	mov_s r0,0x805514
L_8c22a2:
	stw_s r1,[r0]
L_8c22a4:
	ld_s r0,[r13,0x1c]
L_8c22a6:
	ld r4,[r0, 0x8]
L_8c22aa:
	ld_s r0,[sp,0x0]
L_8c22ac:
	breq r0,r4,L_8c22c8
L_8c22b0:
	ld_s r0,[r13,0x20]
L_8c22b2:
	mov_s r1,r13
L_8c22b4:
	ldb r5,[r0, 0x10]
L_8c22b8:
	mov_s r0,L_8c5ed4-0x8c0000
L_8c22be:
	ld_s r2,[r13,0xc]
L_8c22c0:
	bl.d L_8e4e18
L_8c22c4:
	mov_s r3,0x1
L_8c22c6:
	b_s L_8c22e4
	.global L_8c22c8
L_8c22c8:
	mov_s r1,0x1017314
L_8c22ce:
	mov_s r0,0x29
L_8c22d0:
	bl.d L_8dcc10
L_8c22d4:
	mov_s r2,r4
L_8c22d6:
	mov_s r0,r13
L_8c22d8:
	mov_s r1,0x2
L_8c22da:
	mov_s r2,0x0
L_8c22dc:
	mov_s r3,r2
L_8c22de:
	mov_s r4,r2
	.global L_8c22e0
L_8c22e0:
	bl L_8d9b6c
	.global L_8c22e4
L_8c22e4:
	b.d L_8c025c
L_8c22e8:
	add_s sp,sp,0x4
L_8c22ea:
	nop_s
