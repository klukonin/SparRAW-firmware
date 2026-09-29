/* fwq_tx__flush_list_packets_by_cid @ 0x8c8f78, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::flush_list_packets_by_cid marking tx_metadata_p=0x%06x with FWQ_TX_FLUSH_STATUS
 * Зовут его: fwq_tx__flush_by_prio
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, iter__has_more, iter__init, iter__next, llist__insert, llist__remove, u_schd__cancel
 */
	.section .text.fwq_tx__flush_list_packets_by_cid,"ax",@progbits
	.global fwq_tx__flush_list_packets_by_cid
fwq_tx__flush_list_packets_by_cid:
	.global L_8c8f78
L_8c8f78:
	push_s blink
L_8c8f7a:
	bl L_8c02b0
L_8c8f7e:
	sub_s sp,sp,0x4
L_8c8f80:
	mov_s r17,r1
L_8c8f82:
	mov_s r19,r2
L_8c8f84:
	mov_s r18,r3
L_8c8f86:
	mov_s r13,0x0
L_8c8f88:
	mov_s r15,sp
L_8c8f8a:
	mov_s r0,r15
L_8c8f8c:
	bl.d L_8e1138
L_8c8f90:
	mov_s r1,r3
L_8c8f92:
	mov_s r16,r13
L_8c8f94:
	b_s L_8c8fc2
	.global L_8c8f96
L_8c8f96:
	ld_s r0,[r13,0x14]
L_8c8f98:
	breq_s r0,0,L_8c8fa2
L_8c8f9a:
	bl L_8c7794
L_8c8f9e:
	mov_s r0,0x0
L_8c8fa0:
	st_s r0,[r13,0x14]
	.global L_8c8fa2
L_8c8fa2:
	ldb_s r0,[r13,0x11]
L_8c8fa4:
	cmp r0,0xfd
L_8c8fa8:
	beq_s L_8c8fbe
L_8c8faa:
	mov_s r2,0x10156d8
L_8c8fb0:
	mov_s r0,0x7
L_8c8fb2:
	mov_s r1,0x2
L_8c8fb4:
	bl.d L_8edfcc
L_8c8fb8:
	mov_s r3,r13
L_8c8fba:
	mov_s r0,0xff
L_8c8fbc:
	stb_s r0,[r13,0x11]
	.global L_8c8fbe
L_8c8fbe:
	mov r16,0x1
	.global L_8c8fc2
L_8c8fc2:
	mov_s r14,r13
L_8c8fc4:
	b_s L_8c8fe8
	.global L_8c8fc6
L_8c8fc6:
	bl.d L_8db188
L_8c8fca:
	mov_s r0,r15
L_8c8fcc:
	mov_s r13,r0
L_8c8fce:
	breq_s r14,0,L_8c8fe2
L_8c8fd0:
	mov_s r0,r18
L_8c8fd2:
	bl.d L_8de4ec
L_8c8fd6:
	mov_s r1,r14
L_8c8fd8:
	mov_s r0,r19
L_8c8fda:
	bl.d L_8c1fc4
L_8c8fde:
	mov_s r1,r14
L_8c8fe0:
	mov_s r14,0x0
	.global L_8c8fe2
L_8c8fe2:
	ldb_s r0,[r13,0xa]
L_8c8fe4:
	breq r0,r17,L_8c8f96
	.global L_8c8fe8
L_8c8fe8:
	bl.d L_8cb674
L_8c8fec:
	mov_s r0,r15
L_8c8fee:
	brne_s r0,0,L_8c8fc6
L_8c8ff0:
	breq_s r14,0,L_8c9002
L_8c8ff2:
	mov_s r0,r18
L_8c8ff4:
	bl.d L_8de4ec
L_8c8ff8:
	mov_s r1,r14
L_8c8ffa:
	mov_s r0,r19
L_8c8ffc:
	bl.d L_8c1fc4
L_8c9000:
	mov_s r1,r14
	.global L_8c9002
L_8c9002:
	mov_s r0,r16
L_8c9004:
	b.d L_8c030c
L_8c9008:
	add_s sp,sp,0x4
L_8c900a:
	nop_s
