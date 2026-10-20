/* mid__connect @ 0x8c6354, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid::connect() to %04X%04X%04X.
 * Зовут его: l2_mgr__channel_locked_cb
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3, mid__link_acquisition_action, tail_conn_mgr__ranking_remove
 */
	.section .text.mid__connect,"ax",@progbits
	.global mid__connect
mid__connect:
	.global L_8c6354
L_8c6354:
	push_s blink
L_8c6356:
	bl L_8c02bc
L_8c635a:
	mov_s r16,r0
L_8c635c:
	mov_s r14,r1
L_8c635e:
	mov_s r15,r2
L_8c6360:
	mov_s r13,0x0
L_8c6362:
	push_s r13
L_8c6364:
	ldw r4,[r1, 0x2]
L_8c6368:
	mov_s r2,0x100b6e0
L_8c636e:
	ldw r5,[r1]
L_8c6372:
	mov_s r0,0xb
L_8c6374:
	mov_s r1,0x2
L_8c6376:
	bl.d L_8ee034
L_8c637a:
	ldw_s r3,[r14,0x4]
L_8c637c:
	mov r4,sp
L_8c6380:
	mov_s r0,r16
L_8c6382:
	mov_s r1,r14
L_8c6384:
	mov_s r2,r13
L_8c6386:
	mov_s r3,0x1
L_8c6388:
	bl.d L_8d7838
L_8c638c:
	mov_s r5,r13
L_8c638e:
	brne r0,0x1,L_8c639c
L_8c6392:
	ld_s r0,[sp,0x0]
L_8c6394:
	st_s r15,[r0,0x38]
L_8c6396:
	bl.d L_8e2758
L_8c639a:
	ld_s r0,[sp,0x0]
	.global L_8c639c
L_8c639c:
	b.d L_8c0324
L_8c63a0:
	add_s sp,sp,0x4
L_8c63a2:
	nop_s
