/* stream_mgr__addba_req_tx_complete @ 0x8c28ec, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr::addba_req_tx_complete after disconnection
 * Зовёт сам: TX_API__free_memory, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, stream_mgr__find_vring_by_cid, ul_stream__ba_sm_evt
 */
	.section .text.stream_mgr__addba_req_tx_complete,"ax",@progbits
	.global stream_mgr__addba_req_tx_complete
stream_mgr__addba_req_tx_complete:
L_8c28ec:
	push_s blink
L_8c28ee:
	bl L_8c02c4
L_8c28f2:
	mov_s r13,r0
L_8c28f4:
	ldb_s r0,[r0,0x1b]
L_8c28f6:
	mov_s r14,r1
L_8c28f8:
	lsr_s r0,r0,0x2
L_8c28fa:
	bmsk_s r0,r0,0x3
L_8c28fc:
	bl.d L_8cab10
L_8c2900:
	ldb_s r1,[r2,0x8]
L_8c2902:
	cmp_s r14,0x0
L_8c2904:
	mov_s r2,0x1
L_8c2906:
	sub_s.ne r2,r2,r2
L_8c2908:
	brne_s r0,0,L_8c291a
L_8c290a:
	mov_s r2,0x100e750
L_8c2910:
	mov_s r0,0xb
L_8c2912:
	bl.d L_8edfb0
L_8c2916:
	mov_s r1,0x1
L_8c2918:
	b_s L_8c2924
	.global L_8c291a
L_8c291a:
	mov_s r1,0x3
L_8c291c:
	mov_s r3,0x0
L_8c291e:
	bl.d L_8d6afc
L_8c2922:
	mov_s r4,r3
	.global L_8c2924
L_8c2924:
	bl.d L_8c94c4
L_8c2928:
	mov_s r0,r13
L_8c292a:
	.byte 0x0d,0x02
