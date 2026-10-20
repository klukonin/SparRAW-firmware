/* fwq_tx__flush_list_packets_by_cid @ 0x8cac6c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::flush_list_packets_by_cid marking tx_metadata_p=0x%06x with FWQ_TX_FLUSH_STATUS
 * Зовут его: fwq_tx__flush_by_prio
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit1, iter__init, iter__next, list__find_entry_d, list__has_items, tx_list__remove, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__flush_list_packets_by_cid
fwq_tx__flush_list_packets_by_cid:
	.global L_8cac6c
L_8cac6c:
	push_s blink
L_8cac6e:
	bl L_8c01d0
L_8cac72:
	sub_s sp,sp,0x4
L_8cac74:
	mov_s r17,r1
L_8cac76:
	mov_s r19,r2
L_8cac78:
	mov_s r18,r3
L_8cac7a:
	mov_s r13,0x0
L_8cac7c:
	mov_s r15,sp
L_8cac7e:
	mov_s r0,r15
L_8cac80:
	bl.d L_8e5df4
L_8cac84:
	mov_s r1,r3
L_8cac86:
	mov_s r16,r13
L_8cac88:
	b_s L_8cacb4
	.global L_8cac8a
L_8cac8a:
	ld_s r0,[r13,0x14]
L_8cac8c:
	breq_s r0,0,L_8cac96
L_8cac8e:
	bl L_8c8de0
L_8cac92:
	mov_s r0,0x0
L_8cac94:
	st_s r0,[r13,0x14]
	.global L_8cac96
L_8cac96:
	ldb_s r0,[r13,0x11]
L_8cac98:
	cmp r0,0xfd
L_8cac9c:
	beq_s L_8cacb0
L_8cac9e:
	mov_s r1,0x1018a68
L_8caca4:
	mov_s r0,0x27
L_8caca6:
	bl.d L_8dcc10
L_8cacaa:
	mov_s r2,r13
L_8cacac:
	mov_s r0,0xff
L_8cacae:
	stb_s r0,[r13,0x11]
	.global L_8cacb0
L_8cacb0:
	mov r16,0x1
	.global L_8cacb4
L_8cacb4:
	mov_s r14,r13
L_8cacb6:
	b_s L_8cacda
	.global L_8cacb8
L_8cacb8:
	bl.d L_8df438
L_8cacbc:
	mov_s r0,r15
L_8cacbe:
	mov_s r13,r0
L_8cacc0:
	breq_s r14,0,L_8cacd4
L_8cacc2:
	mov_s r0,r18
L_8cacc4:
	bl.d L_8e2884
L_8cacc8:
	mov_s r1,r14
L_8cacca:
	mov_s r0,r19
L_8caccc:
	bl.d L_8c25f4
L_8cacd0:
	mov_s r1,r14
L_8cacd2:
	mov_s r14,0x0
	.global L_8cacd4
L_8cacd4:
	ldb_s r0,[r13,0xa]
L_8cacd6:
	breq r0,r17,L_8cac8a
	.global L_8cacda
L_8cacda:
	bl.d L_8cdcb8
L_8cacde:
	mov_s r0,r15
L_8cace0:
	brne_s r0,0,L_8cacb8
L_8cace2:
	breq_s r14,0,L_8cacf4
L_8cace4:
	mov_s r0,r18
L_8cace6:
	bl.d L_8e2884
L_8cacea:
	mov_s r1,r14
L_8cacec:
	mov_s r0,r19
L_8cacee:
	bl.d L_8c25f4
L_8cacf2:
	mov_s r1,r14
	.global L_8cacf4
L_8cacf4:
	mov_s r0,r16
L_8cacf6:
	b.d L_8c022c
L_8cacfa:
	add_s sp,sp,0x4
