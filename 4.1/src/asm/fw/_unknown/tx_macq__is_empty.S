/* tx_macq__is_empty @ 0x8d7084, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_macq::is_empty mac_pld:0x%x, pal:0x%x
 *   tx_macq::is_empty mac_mpdu:0x%x, pal:0x%x
 * Зовут его: l2mgr__vring_drained, sm_pring__all_wb_done_evt, sm_pring__bind_vring, sm_pring__eop_evt, sm_pring__timeout, vring__wait_macq_delete
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, vring__write_macq_desc
 */
	.section .text.tx_macq__is_empty,"ax",@progbits
	.global tx_macq__is_empty
tx_macq__is_empty:
	.global L_8d7084
L_8d7084:
	push_s blink
L_8d7086:
	bl.d L_8c02c4
L_8d708a:
	mov_s r3,0x0
L_8d708c:
	sub_s sp,sp,0x10
L_8d708e:
	mov_s r13,r1
L_8d7090:
	mov_s r2,sp
L_8d7092:
	ldb_s r1,[r0]
L_8d7094:
	mov_s r0,r2
L_8d7096:
	mov_s r2,0x2
L_8d7098:
	bl.d L_8c4768
L_8d709c:
	mov r4,0x1
L_8d70a0:
	ldw r3,[sp]
L_8d70a4:
	ldw r4,[sp, 0x2]
L_8d70a8:
	brne_s r13,0,L_8d70be
	.global L_8d70aa
L_8d70aa:
	ldw r0,[sp, 0x2]
L_8d70ae:
	ldw r1,[sp]
L_8d70b2:
	cmp_s r1,r0
L_8d70b4:
	mov_s r0,0x1
L_8d70b6:
	sub_s.ne r0,r0,r0
L_8d70b8:
	b.d L_8c0334
L_8d70bc:
	add_s sp,sp,0x10
	.global L_8d70be
L_8d70be:
	mov_s r2,0x1015ad4
L_8d70c4:
	mov_s r0,0x0
L_8d70c6:
	bl.d L_8edff8
L_8d70ca:
	mov_s r1,0x2
L_8d70cc:
	ld_s r3,[sp,0x8]
L_8d70ce:
	mov_s r2,0x1015b00
L_8d70d4:
	lsr_s r3,r3,0xc
L_8d70d6:
	ld_s r14,[sp,0xc]
L_8d70d8:
	bmsk_s r3,r3,0xb
L_8d70da:
	bmsk_s r14,r14,0x3
L_8d70dc:
	asl_s r14,r14,0x8
L_8d70de:
	ldb r13,[sp, 0xb]
L_8d70e2:
	mov_s r0,0x0
L_8d70e4:
	mov_s r1,0x2
L_8d70e6:
	bl.d L_8edff8
L_8d70ea:
	or r4,r13,r14
L_8d70ee:
	b_s L_8d70aa
