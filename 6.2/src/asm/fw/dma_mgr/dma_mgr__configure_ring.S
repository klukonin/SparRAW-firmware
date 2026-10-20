/* dma_mgr__configure_ring @ 0x8c6e90, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: disc_sm__sw_data_stopped, dma_mgr__setup_queue_pair, rx_pool__configure_ring, wmi_cfg_rx_chain, wmi_pmc
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, field_set_0x00__8d0a44, fw_sysassert_fatal, hwd_dma__set_ring_base, hwd_dma__set_ring_field_99e0, hwd_dma__set_ring_field_9a10, hwd_dma__uses_rgf_881000, macq_hw__set_low_nibble, vring__reg_write_locked_20
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__configure_ring
dma_mgr__configure_ring:
	.global L_8c6e90
L_8c6e90:
	push_s blink
L_8c6e92:
	bl L_8c01c8
L_8c6e96:
	mov_s r14,r0
L_8c6e98:
	mov_s r20,r1
L_8c6e9a:
	mov_s r19,r2
L_8c6e9c:
	mov_s r16,r3
L_8c6e9e:
	cmp_s r0,0x7
L_8c6ea0:
	mov r18,0x1
L_8c6ea4:
	sub.ne r18,r18,r18
L_8c6ea8:
	cmp_s r0,0x8
L_8c6eaa:
	mov r21,0x1
L_8c6eae:
	mov_s r13,0x802c34
L_8c6eb4:
	add2_s r13,r13,r0
L_8c6eb6:
	ldb_s r0,[r13,0x2]
L_8c6eb8:
	sub.ne r21,r21,r21
L_8c6ebc:
	mov r17,r4
L_8c6ec0:
	mov_s r15,r7
L_8c6ec2:
	brne r0,0x1,L_8c6eda
L_8c6ec6:
	ldb_s r0,[r13,0x3]
L_8c6ec8:
	cmp_s r0,0x0
L_8c6eca:
	mov.eq r0,blink
L_8c6ece:
	mov.eq r1,0x120b
L_8c6ed6:
	bl.eq L_8c9b28
	.global L_8c6eda
L_8c6eda:
	ldb_s r0,[r13,0x2]
L_8c6edc:
	cmp_s r0,0x1
L_8c6ede:
	cmp.eq r14,0x3
L_8c6ee2:
	mov.eq r0,blink
L_8c6ee6:
	mov.eq r1,0x120c
L_8c6eee:
	bl.eq L_8c9b28
L_8c6ef2:
	ldb r4,[r13, 0x3]
L_8c6ef6:
	mov_s r0,r14
L_8c6ef8:
	ldb_s r1,[r13]
L_8c6efa:
	mov r5,r18
L_8c6efe:
	ldb_s r2,[r13,0x1]
L_8c6f00:
	ldb_s r3,[r13,0x2]
L_8c6f02:
	bl.d L_8d0a44
L_8c6f06:
	mov r6,r21
L_8c6f0a:
	breq r18,0x0,L_8c6f2c
L_8c6f0e:
	bic.f 0x0,r14,0xf
L_8c6f12:
	bne_s L_8c6f3e
	.global L_8c6f14
L_8c6f14:
	mov_s r0,0x886800
L_8c6f1a:
	ld_s r2,[r0,0x38]
L_8c6f1c:
	asl r1,r14,0x8
L_8c6f20:
	and r2,r2,0xfffff0ff
L_8c6f28:
	or_s r1,r1,r2
L_8c6f2a:
	st_s r1,[r0,0x38]
	.global L_8c6f2c
L_8c6f2c:
	ldb_s r0,[r13,0x2]
L_8c6f2e:
	brne_s r0,0,L_8c6fa2
L_8c6f30:
	mov_s r0,0x0
L_8c6f32:
	breq r14,0x4,L_8c6f48
L_8c6f36:
	brne r18,0x0,L_8c6f48
L_8c6f3a:
	mov_s r4,r0
L_8c6f3c:
	b_s L_8c6f4c
	.global L_8c6f3e
L_8c6f3e:
	mov_s r0,blink
L_8c6f40:
	bl.d L_8c9b28
L_8c6f44:
	mov_s r1,0xac
L_8c6f46:
	b_s L_8c6f14
	.global L_8c6f48
L_8c6f48:
	sub r4,r16,0x1
	.global L_8c6f4c
L_8c6f4c:
	ldb r5,[r13]
L_8c6f50:
	mov_s r0,r14
L_8c6f52:
	mov_s r1,r20
L_8c6f54:
	mov_s r2,r19
L_8c6f56:
	bl.d L_8d0468
L_8c6f5a:
	mov_s r3,r16
L_8c6f5c:
	brne r18,0x0,L_8c6f72
L_8c6f60:
	mov_s r0,r14
L_8c6f62:
	bl.d L_8d0a80
L_8c6f66:
	mov_s r1,0x1
L_8c6f68:
	mov_s r0,r14
L_8c6f6a:
	bl.d L_8d0c48
L_8c6f6e:
	mov_s r1,0x1
L_8c6f70:
	b_s L_8c6f82
	.global L_8c6f72
L_8c6f72:
	cmp r17,0x0
L_8c6f76:
	mov.ne r0,r14
L_8c6f7a:
	bl.ne.d L_8d0a80
L_8c6f7e:
	mov.ne r1,r17
	.global L_8c6f82
L_8c6f82:
	brlt r15,0x3,L_8c6f9c
L_8c6f86:
	cmp_s r15,0x1f28
L_8c6f8c:
	mov.lt r0,r14
L_8c6f90:
	mov.lt r1,0x1
L_8c6f94:
	bl.lt.d L_8d0ba4
L_8c6f98:
	mov.lt r2,r15
	.global L_8c6f9c
L_8c6f9c:
	bl.d L_8d0708
L_8c6fa0:
	mov_s r0,r14
	.global L_8c6fa2
L_8c6fa2:
	sub_s r0,r14,0x3
L_8c6fa4:
	cmp_s r0,0x3
L_8c6fa6:
	mov.ls r0,0x0
L_8c6faa:
	bset.ls r0,r0,r14
L_8c6fae:
	bl.ls.d L_8d0508
L_8c6fb2:
	mov.ls r1,0x0
L_8c6fb6:
	b L_8c021c
L_8c6fba:
	nop_s
