/* memset0_words @ 0x8c1cd8, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: FWQ_TX_AVAILABILITY__init, TX_API__alloc_tx_payload, UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, alloc_dband_info, boot__clear_object_48, boot__clear_object_tail, boot__install_handler_ptrs, calib_engine__init_all
 * Зовёт сам: __ld_r13_to_r13_ret, memset_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global memset0_words
memset0_words:
	.global L_8c1cd8
L_8c1cd8:
	mov.f r2,r1
L_8c1cdc:
	push_s blink
L_8c1cde:
	push_s r13
L_8c1ce0:
	beq_s L_8c1d62
L_8c1ce2:
	bmsk.f 0x0,r0,0x1
L_8c1ce6:
	bne_s L_8c1cf8
L_8c1ce8:
	bmsk.f 0x0,r2,0x1
L_8c1cec:
	bne_s L_8c1cf8
L_8c1cee:
	lsr_s r2,r2,0x2
L_8c1cf0:
	brhs r2,0x8,L_8c1d00
L_8c1cf4:
	mov_s r1,0x0
L_8c1cf6:
	b_s L_8c1d06
	.global L_8c1cf8
L_8c1cf8:
	bl.d L_8ddf84
L_8c1cfc:
	mov_s r1,0x0
L_8c1cfe:
	b_s L_8c1d62
	.global L_8c1d00
L_8c1d00:
	sub_s r1,r2,0x1
L_8c1d02:
	lsr_s r1,r1,0x3
L_8c1d04:
	bmsk_s r2,r2,0x2
	.global L_8c1d06
L_8c1d06:
	brhs r2,0x8,L_8c1d62
L_8c1d0a:
	ldb.x r2,[0x803b68,r2]
L_8c1d12:
	add r13,pcl,0xc
L_8c1d16:
	add1_s r13,r13,r2
L_8c1d18:
	j_s.d [r13]
L_8c1d1a:
	mov_s r3,0x0
L_8c1d1c:
	mov_s r2,r0
L_8c1d1e:
	b_s L_8c1d56
L_8c1d20:
	mov_s r2,r0
L_8c1d22:
	b_s L_8c1d52
L_8c1d24:
	mov_s r2,r0
L_8c1d26:
	b_s L_8c1d4e
L_8c1d28:
	mov_s r2,r0
L_8c1d2a:
	b_s L_8c1d4a
L_8c1d2c:
	mov_s r2,r0
L_8c1d2e:
	b_s L_8c1d46
L_8c1d30:
	mov_s r2,r0
L_8c1d32:
	b_s L_8c1d42
L_8c1d34:
	mov_s r2,r0
L_8c1d36:
	b_s L_8c1d3e
L_8c1d38:
	mov_s r2,r0
	.global L_8c1d3a
L_8c1d3a:
	st.ab r3,[r2,0x4]
	.global L_8c1d3e
L_8c1d3e:
	st.ab r3,[r2,0x4]
	.global L_8c1d42
L_8c1d42:
	st.ab r3,[r2,0x4]
	.global L_8c1d46
L_8c1d46:
	st.ab r3,[r2,0x4]
	.global L_8c1d4a
L_8c1d4a:
	st.ab r3,[r2,0x4]
	.global L_8c1d4e
L_8c1d4e:
	st.ab r3,[r2,0x4]
	.global L_8c1d52
L_8c1d52:
	st.ab r3,[r2,0x4]
	.global L_8c1d56
L_8c1d56:
	cmp_s r1,0x0
L_8c1d58:
	st.ab r3,[r2,0x4]
L_8c1d5c:
	sub.gt r1,r1,0x1
L_8c1d60:
	bgt_s L_8c1d3a
	.global L_8c1d62
L_8c1d62:
	b L_8c025c
L_8c1d66:
	nop_s
	.global L_8c1d68
L_8c1d68:
	j_s [blink]
L_8c1d6a:
	nop_s
