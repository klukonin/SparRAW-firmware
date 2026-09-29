/* mlme_sm__data_port_open_ev_handle_8f21c0 @ 0x8f21c0, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DATA PORT OPEN event.
 *   mlme_sm::data_port_open_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 *   data_port_open_timeout_cb
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, fw_log_emit2, radio_mgr__call_method_10, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm__data_port_open_ev_handle_8f21c0
mlme_sm__data_port_open_ev_handle_8f21c0:
	.global L_8f21c0
L_8f21c0:
	push_s blink
L_8f21c2:
	push_s r13
L_8f21c4:
	mov_s r13,r0
L_8f21c6:
	mov_s r1,0x10117dc
L_8f21cc:
	bl.d L_8dcba8
L_8f21d0:
	mov_s r0,0x2a
L_8f21d2:
	ld_s r0,[r13,0x14]
L_8f21d4:
	breq_s r0,0,L_8f21de
L_8f21d6:
	bl L_8c8de0
L_8f21da:
	mov_s r0,0x0
L_8f21dc:
	st_s r0,[r13,0x14]
	.global L_8f21de
L_8f21de:
	ld_s r2,[r13,0x10]
L_8f21e0:
	mov_s r1,0x10117f4
L_8f21e6:
	mov_s r0,0x20
L_8f21e8:
	bl.d L_8dcc80
L_8f21ec:
	ld_s r3,[r13,0x8]
L_8f21ee:
	ld_s r2,[r13,0x10]
L_8f21f0:
	breq_s r2,0,L_8f221c
L_8f21f2:
	ld_s r0,[r13,0x8]
L_8f21f4:
	breq_s r0,0,L_8f220a
L_8f21f6:
	mov_s r1,0x101159c
L_8f21fc:
	bl.d L_8dcc10
L_8f2200:
	mov_s r0,0x2c
L_8f2202:
	bl.d L_8ea800
L_8f2206:
	ld_s r0,[r13,0x10]
L_8f2208:
	b_s L_8f221c
	.global L_8f220a
L_8f220a:
	mov_s r1,0x10115c8
L_8f2210:
	bl.d L_8dcc10
L_8f2214:
	mov_s r0,0x2c
L_8f2216:
	bl.d L_8e2798
L_8f221a:
	ld_s r0,[r13,0x10]
	.global L_8f221c
L_8f221c:
	mov_s r0,0x0
L_8f221e:
	st_s r0,[r13,0x10]
L_8f2220:
	b.d L_8c025c
L_8f2224:
	st_s r0,[r13,0x8]
L_8f2226:
	nop_s
L_8f2228:
	push_s blink
L_8f222a:
	push_s r13
L_8f222c:
	mov_s r13,r0
L_8f222e:
	mov_s r1,0x101135c
L_8f2234:
	bl.d L_8dcba8
L_8f2238:
	mov_s r0,0x1a
L_8f223a:
	mov_s r2,0x0
L_8f223c:
	st_s r2,[r13,0x14]
L_8f223e:
	mov_s r0,r13
L_8f2240:
	mov_s r1,0x5
L_8f2242:
	mov_s r3,r2
L_8f2244:
	bl.d L_8d9b6c
L_8f2248:
	mov_s r4,r2
L_8f224a:
	b L_8c025c
L_8f224e:
	nop_s
