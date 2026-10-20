/* conn_mgr__awake_peer_ntf @ 0x8c36e0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::awake_peer_ntf CID %d.
 * Зовут его: ps_assoc_mgr__set_awake_tsf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__start_detector_services, conn_mgr__by_cid, fw_log__emit1
 */
	.section .text.conn_mgr__awake_peer_ntf,"ax",@progbits
	.global conn_mgr__awake_peer_ntf
conn_mgr__awake_peer_ntf:
	.global L_8c36e0
L_8c36e0:
	push_s blink
L_8c36e2:
	bl L_8c02c4
L_8c36e6:
	mov_s r13,0x0
L_8c36e8:
	b_s L_8c3718
	.global L_8c36ea
L_8c36ea:
	bl.d L_8c9e44
L_8c36ee:
	mov_s r0,r13
L_8c36f0:
	mov.f r14,r0
L_8c36f4:
	beq_s L_8c3716
L_8c36f6:
	ldb r0,[r14, 0xb0]
L_8c36fa:
	brne r0,0x2,L_8c3716
L_8c36fe:
	mov_s r2,0x100ae74
L_8c3704:
	mov_s r0,0xb
L_8c3706:
	mov_s r1,0x2
L_8c3708:
	bl.d L_8edfcc
L_8c370c:
	mov_s r3,r13
L_8c370e:
	mov_s r0,r14
L_8c3710:
	bl.d L_8de764
L_8c3714:
	mov_s r1,0x1
	.global L_8c3716
L_8c3716:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c3718
L_8c3718:
	brlo r13,0x8,L_8c36ea
L_8c371c:
	b L_8c0334
