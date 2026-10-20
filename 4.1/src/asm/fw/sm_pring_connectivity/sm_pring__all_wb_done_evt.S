/* sm_pring__all_wb_done_evt @ 0x8c29f4, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PRING#%d V-Ring %d, ALL WB DONE and DMA or MAC isn't empty.
 *   sm_pring_connectivity.cpp
 *   Spurious event of ALL WB DONE  at <%d>.
 * Зовут его: pring__on_all_wb_done
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, dma_is_idle, fw_log__emit1, fw_log__emit2, fw_read_timer, fw_sysassert_fatal, tx_macq__is_empty, u_schd__cancel, vring__teardown, vring_by_index
 */
	.section .text.sm_pring__all_wb_done_evt,"ax",@progbits
	.global sm_pring__all_wb_done_evt
sm_pring__all_wb_done_evt:
L_8c29f4:
	mov_s r1,0x1
	.global fwlog_PRING_d_V_Ring_d_ALL_WB_DONE_and_DMA_or_
fwlog_PRING_d_V_Ring_d_ALL_WB_DONE_and_DMA_or_:
L_8c29f6:
	nop_s
	.global L_8c29f8
L_8c29f8:
	push_s blink
L_8c29fa:
	bl L_8c02bc
L_8c29fe:
	mov_s r13,r0
L_8c2a00:
	bl.d L_8cacc0
L_8c2a04:
	ldw_s r0,[r0,0x2]
L_8c2a06:
	mov_s r14,0x0
L_8c2a08:
	mov_s r16,r0
L_8c2a0a:
	ldw_s r0,[r13]
L_8c2a0c:
	bl.d L_8cdaf8
L_8c2a10:
	mov_s r1,r14
L_8c2a12:
	breq_s r0,0,L_8c2a1e
L_8c2a14:
	mov_s r0,r16
L_8c2a16:
	bl.d L_8d7084
L_8c2a1a:
	mov_s r1,r14
L_8c2a1c:
	brne_s r0,0,L_8c2a34
	.global L_8c2a1e
L_8c2a1e:
	mov_s r2,0x100edc8
L_8c2a24:
	ldw r4,[r13, 0x2]
L_8c2a28:
	mov_s r0,0x7
L_8c2a2a:
	mov_s r1,0x2
L_8c2a2c:
	bl.d L_8edff8
L_8c2a30:
	ldw_s r3,[r13]
L_8c2a32:
	b_s L_8c2ac2
	.global L_8c2a34
L_8c2a34:
	ld_s r0,[r13,0x20]
L_8c2a36:
	breq_s r0,0,L_8c2a3e
L_8c2a38:
	bl L_8c7794
L_8c2a3c:
	st_s r14,[r13,0x20]
	.global L_8c2a3e
L_8c2a3e:
	ld_s r1,[r13,0x18]
L_8c2a40:
	brhs r1,0x5,L_8c2aac
L_8c2a44:
	ldb.x r1,[0x801f4c,r1]
L_8c2a4c:
	add r0,pcl,0x8
L_8c2a50:
	add1_s r0,r0,r1
L_8c2a52:
	j_s [r0]
L_8c2a54:
	mov_s r0,r16
L_8c2a56:
	bl.d L_8d7084
L_8c2a5a:
	mov_s r1,0x0
L_8c2a5c:
	breq_s r0,0,L_8c2a66
	.global L_8c2a5e
L_8c2a5e:
	bl.d L_8c5b94
L_8c2a62:
	mov_s r0,r13
L_8c2a64:
	b_s L_8c2ac2
	.global L_8c2a66
L_8c2a66:
	mov_s r0,blink
L_8c2a68:
	mov_s r2,0x100ec18
L_8c2a6e:
	mov_s r1,0x12ac
L_8c2a74:
	bl.d L_8c82c0
L_8c2a78:
	mov r3,0x1d9
L_8c2a7c:
	b_s L_8c2a5e
L_8c2a7e:
	bl L_8e4694
L_8c2a82:
	mov_s r2,0x100ee04
L_8c2a88:
	mov_s r3,r0
L_8c2a8a:
	mov_s r0,0x7
L_8c2a8c:
	mov_s r1,0x2
L_8c2a8e:
	/* bl.d 0x008edfcc */
	.byte 0x42,0x0d,0xa0,0x15
L_8c2a92:
	/* _asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_8c2a94:
	b_s L_8c2ac2
L_8c2a96:
	bl L_8e4694
L_8c2a9a:
	mov_s r2,0x100ee04
L_8c2aa0:
	mov_s r3,r0
L_8c2aa2:
	mov_s r0,0x7
L_8c2aa4:
	mov_s r1,0x2
L_8c2aa6:
	/* bl.d 0x008edfcc */
	.byte 0x2a,0x0d,0xa0,0x15
L_8c2aaa:
	/* _asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
	.global L_8c2aac
L_8c2aac:
	mov_s r0,blink
L_8c2aae:
	mov_s r2,0x100ec18
L_8c2ab4:
	mov_s r1,0x12ad
L_8c2aba:
	bl.d L_8c82c0
L_8c2abe:
	mov r3,0x1e4
	.global L_8c2ac2
L_8c2ac2:
	.byte 0x65,0x00
