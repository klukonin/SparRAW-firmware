/* channels_switch_sm__action_scan_complete @ 0x8c230c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_scan_complete() ,scan_success %d
 *   channels_switch_sm::action_scan_complete() unlocking radio 0x%X
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, radio_mgr__call_method_10, scan_mngr__dwelling_done, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_scan_complete
channels_switch_sm__action_scan_complete:
	.global L_8c230c
L_8c230c:
	push_s blink
L_8c230e:
	bl L_8c01e4
L_8c2312:
	mov_s r13,r0
L_8c2314:
	mov_s r14,r1
L_8c2316:
	mov_s r1,0x1017460
L_8c231c:
	mov_s r0,0x29
L_8c231e:
	bl.d L_8dcc10
L_8c2322:
	mov_s r2,r14
L_8c2324:
	ld_s r0,[r13,0x18]
L_8c2326:
	breq_s r0,0,L_8c2330
L_8c2328:
	bl L_8c8de0
L_8c232c:
	mov_s r0,0x0
L_8c232e:
	st_s r0,[r13,0x18]
	.global L_8c2330
L_8c2330:
	mov_s r1,0x101749c
L_8c2336:
	mov_s r0,0x29
L_8c2338:
	bl.d L_8dcc10
L_8c233c:
	ld_s r2,[r13,0xc]
L_8c233e:
	bl.d L_8ea800
L_8c2342:
	ld_s r0,[r13,0xc]
L_8c2344:
	cmp_s r14,0x0
L_8c2346:
	mov_s r1,0x1
L_8c2348:
	sub_s.ne r1,r1,r1
L_8c234a:
	bl.d L_8f2b88
L_8c234e:
	ld_s r0,[r13,0x8]
L_8c2350:
	b L_8c0254
