/* vring__teardown @ 0x8c5b94, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__all_wb_done_evt, sm_pring__eop_evt, sm_pring__timeout
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_dma__reset_ring, mac_ring_disable, u_schd__cancel, vring__cache_stats, vring__notify_delete, vring_schd__disconnect_notify
 */
	.section .text.vring__teardown,"ax",@progbits
	.global vring__teardown
vring__teardown:
	.global L_8c5b94
L_8c5b94:
	push_s blink
L_8c5b96:
	bl L_8c02c4
L_8c5b9a:
	bl.d L_8e73ec
L_8c5b9e:
	mov_s r13,r0
L_8c5ba0:
	bl.d L_8e508c
L_8c5ba4:
	ldw_s r0,[r13,0x2]
L_8c5ba6:
	bl.d L_8cd908
L_8c5baa:
	ldw_s r0,[r13]
L_8c5bac:
	mov_s r0,0x18
L_8c5bae:
	stw_s r0,[r13,0x2]
L_8c5bb0:
	ld_s r0,[r13,0x28]
L_8c5bb2:
	mov_s r14,0x0
L_8c5bb4:
	st_s r14,[r13,0xc]
L_8c5bb6:
	breq_s r0,0,L_8c5bbe
L_8c5bb8:
	bl L_8c7794
L_8c5bbc:
	st_s r14,[r13,0x28]
	.global L_8c5bbe
L_8c5bbe:
	ld_s r0,[r13,0x1c]
L_8c5bc0:
	breq_s r0,0,L_8c5bc8
L_8c5bc2:
	bl L_8c7794
L_8c5bc6:
	st_s r14,[r13,0x1c]
	.global L_8c5bc8
L_8c5bc8:
	ld_s r0,[r13,0x24]
L_8c5bca:
	breq_s r0,0,L_8c5bd2
L_8c5bcc:
	bl L_8c7794
L_8c5bd0:
	st_s r14,[r13,0x24]
	.global L_8c5bd2
L_8c5bd2:
	ld_s r0,[r13,0x20]
L_8c5bd4:
	breq_s r0,0,L_8c5bdc
L_8c5bd6:
	bl L_8c7794
L_8c5bda:
	st_s r14,[r13,0x20]
	.global L_8c5bdc
L_8c5bdc:
	mov_s r0,0x1
L_8c5bde:
	bl.d L_8d6a08
L_8c5be2:
	st_s r0,[r13,0x18]
L_8c5be4:
	bl.d L_8c7b0c
L_8c5be8:
	ldw_s r0,[r13]
L_8c5bea:
	b L_8c0334
L_8c5bee:
	nop_s
