/* stream_mgr__macq_removed @ 0x8c774c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR: TX MACQ [%d] REMOVED.
 * Зовут его: lmac_if_queue_deleted_handler
 * Зовёт сам: STREAM_MGR__2, __ld_r13_ret, fw_log__emit1
 */
	.section .text.stream_mgr__macq_removed,"ax",@progbits
	.global stream_mgr__macq_removed
stream_mgr__macq_removed:
	.byte 0x4f
	.byte 0xfc
	.global fwlog_STREAM_MGR_TX_MACQ_d_REMOVED
fwlog_STREAM_MGR_TX_MACQ_d_REMOVED:
L_8c774e:
	nop_s
	.global L_8c7750
L_8c7750:
	push_s blink
L_8c7752:
	push_s r13
L_8c7754:
	mov_s r3,r0
L_8c7756:
	mov_s r1,0x0
L_8c7758:
	b_s L_8c775c
	.global L_8c775a
L_8c775a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8c775c
L_8c775c:
	brhs r1,0xa,L_8c7790
L_8c7760:
	mov_s r0,0x8485dc
L_8c7766:
	sub3 r0,r0,0x100
L_8c776a:
	add2_s r0,r0,r1
L_8c776c:
	ld r13,[r0,0x818]
L_8c7774:
	breq_s r13,0,L_8c775a
L_8c7776:
	ldb_s r0,[r13,0x5]
L_8c7778:
	brne r3,r0,L_8c775a
L_8c777c:
	mov_s r2,0x100ea0c
L_8c7782:
	mov_s r0,0xb
L_8c7784:
	bl.d L_8edfcc
L_8c7788:
	mov_s r1,0x2
L_8c778a:
	bl.d L_8e30cc
L_8c778e:
	mov_s r0,r13
	.global L_8c7790
L_8c7790:
	b L_8c033c
