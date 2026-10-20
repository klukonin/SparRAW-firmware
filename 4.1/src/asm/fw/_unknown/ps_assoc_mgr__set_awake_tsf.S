/* ps_assoc_mgr__set_awake_tsf @ 0x8dd268, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_assoc_mgr:: set m_awake_tsf_64 0x%08x:%08x
 * Зовёт сам: TX_API__awake_peer_ntf, __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__inject_event, conn_mgr__awake_peer_ntf, fw_log__emit2, ps_assoc_mgr__aw_ie_reception, ps_conn_mgr__dispatch, vring_schd__find_runnable, vring_schd__prohibit_cids
 */
	.section .text.ps_assoc_mgr__set_awake_tsf,"ax",@progbits
	.global ps_assoc_mgr__set_awake_tsf
ps_assoc_mgr__set_awake_tsf:
L_8dd268:
	push_s blink
L_8dd26a:
	bl L_8c02c0
L_8dd26e:
	mov_s r14,r0
L_8dd270:
	mov_s r15,r1
L_8dd272:
	mov_s r13,r2
L_8dd274:
	mov_s r0,r1
L_8dd276:
	bl.d L_8dd300
L_8dd27a:
	mov_s r1,r2
L_8dd27c:
	sub.f r15,r15,0x2
L_8dd280:
	beq_s L_8dd29a
L_8dd282:
	breq r15,0x1,L_8dd2b4
L_8dd286:
	breq r15,0x2,L_8dd2d8
L_8dd28a:
	cmp_s r15,0x3
L_8dd28c:
	mov.eq r0,r14
L_8dd290:
	bl.eq.d L_8c34f4
L_8dd294:
	mov.eq r1,r13
L_8dd298:
	b_s L_8dd2e8
	.global L_8dd29a
L_8dd29a:
	ldb_s r0,[r13,0x1]
L_8dd29c:
	bl.d L_8dd0b4
L_8dd2a0:
	not_s r0,r0
L_8dd2a2:
	bl.d L_8c2fe4
L_8dd2a6:
	ldb_s r0,[r13,0x1]
L_8dd2a8:
	bl.d L_8c3658
L_8dd2ac:
	ldb_s r0,[r13,0x1]
L_8dd2ae:
	bl L_8c36e0
L_8dd2b2:
	b_s L_8dd2e8
	.global L_8dd2b4
L_8dd2b4:
	ld_s r1,[r13]
L_8dd2b6:
	mov_s r2,0x100266c
L_8dd2bc:
	ld_s r0,[r13,0x4]
L_8dd2be:
	st_s r1,[r14]
L_8dd2c0:
	st_s r0,[r14,0x4]
L_8dd2c2:
	ld r4,[r14]
L_8dd2c6:
	mov_s r0,0xe
L_8dd2c8:
	mov_s r1,0x2
L_8dd2ca:
	bl.d L_8edff8
L_8dd2ce:
	ld_s r3,[r14,0x4]
L_8dd2d0:
	add r0,r14,0xc
L_8dd2d4:
	mov_s r1,0x3
L_8dd2d6:
	b_s L_8dd2de
	.global L_8dd2d8
L_8dd2d8:
	add r0,r14,0xc
L_8dd2dc:
	mov_s r1,0x4
	.global L_8dd2de
L_8dd2de:
	mov_s r2,0x0
L_8dd2e0:
	mov_s r3,r2
L_8dd2e2:
	bl.d L_8d6a1c
L_8dd2e6:
	mov_s r4,r2
	.global L_8dd2e8
L_8dd2e8:
	b L_8c032c
