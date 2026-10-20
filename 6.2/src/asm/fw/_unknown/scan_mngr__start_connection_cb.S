/* scan_mngr__start_connection_cb @ 0x8f95b0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::start_connection_cb() connect to: ADDR-%04X%08X m_active_probs=%d
 *   scan_mngr::start_dwell_event_cb()
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit3, fw_sysassert_fatal, scan_mngr__connect
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__start_connection_cb
scan_mngr__start_connection_cb:
	.global L_8f95b0
L_8f95b0:
	ld_s r0,[r0,0x20]
L_8f95b2:
	ld_s r0,[r0,0x40]
L_8f95b4:
	ld_s r1,[r0,0x68]
L_8f95b6:
	ld_s r1,[r1,0xc]
L_8f95b8:
	j_s [r1]
L_8f95ba:
	nop_s
L_8f95bc:
	push_s blink
L_8f95be:
	bl L_8c01e4
L_8f95c2:
	mov.f r13,r1
L_8f95c6:
	mov_s r14,r0
L_8f95c8:
	beq_s L_8f95ee
	.global L_8f95ca
L_8f95ca:
	ldb r4,[r14,0x215]
L_8f95d2:
	mov_s r1,0x10166f4
L_8f95d8:
	ldw_s r2,[r13,0xc]
L_8f95da:
	mov_s r0,0x29
L_8f95dc:
	bl.d L_8dcd00
L_8f95e0:
	ld_s r3,[r13,0x8]
L_8f95e2:
	mov_s r0,r14
L_8f95e4:
	bl.d L_8f1f2c
L_8f95e8:
	mov_s r1,r13
L_8f95ea:
	b L_8c0254
	.global L_8f95ee
L_8f95ee:
	mov_s r0,blink
L_8f95f0:
	mov_s r1,0x1441
L_8f95f6:
	bl L_8c9b28
L_8f95fa:
	b_s L_8f95ca
L_8f95fc:
	push_s blink
L_8f95fe:
	push_s r13
L_8f9600:
	mov_s r13,r0
L_8f9602:
	mov_s r1,0x101666c
L_8f9608:
	bl.d L_8dcba8
L_8f960c:
	mov_s r0,0x29
L_8f960e:
	mov_s r2,0x0
L_8f9610:
	st.as r2,[r13,0x78]
L_8f9614:
	ld r0,[r13, 0x80]
L_8f9618:
	mov_s r1,0x3
L_8f961a:
	mov_s r3,r2
L_8f961c:
	bl.d L_8d9b6c
L_8f9620:
	mov_s r4,r2
L_8f9622:
	b L_8c025c
L_8f9626:
	nop_s
