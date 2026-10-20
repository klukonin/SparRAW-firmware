/* fwq_tx__long_retry_handler @ 0x8dce84, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::long_retry_handler add_packet for packet 0x%x
 *   fwq_tx::long_retry_handler:add_packet() failure
 *   fwq_tx::long_retry_handler add_packet but connection is pending flush
 * Зовут его: basic_sm__do_transition, basic_sm__error_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r16_to_r13_ret, __st_r14_to_r13, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, fwq_tx__add_packet, mac_read_tsf64, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__long_retry_handler
fwq_tx__long_retry_handler:
	.global L_8dce84
L_8dce84:
	push_s blink
L_8dce86:
	bl L_8c01dc
L_8dce8a:
	sub_s sp,sp,0x8
L_8dce8c:
	bmsk r14,r0,0x3
L_8dce90:
	lsr_s r0,r0,0x4
L_8dce92:
	mov_s r13,0x843900
L_8dce98:
	add_s r15,r13,0x4
L_8dce9a:
	ldb_s r14,[r15,r14]
L_8dce9c:
	bmsk_s r0,r0,0x1
L_8dce9e:
	mov_s r16,r1
L_8dcea0:
	mov_s r1,r4
L_8dcea2:
	bbit0 r14,r0,L_8dcf0c
L_8dcea6:
	ld_s r0,[r13]
L_8dcea8:
	add_s r14,r0,0x4
L_8dceaa:
	bmsk_s r14,r14,0x9
L_8dceac:
	add2 r14,r13,r14
L_8dceb0:
	st_s r1,[r14,0x14]
L_8dceb2:
	add_s r1,r0,0x3
L_8dceb4:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dceb6:
	bmsk_s r1,r1,0x9
L_8dceb8:
	bmsk_s r0,r0,0x9
L_8dceba:
	add2 r1,r13,r1
L_8dcebe:
	st_s r3,[r1,0x14]
L_8dcec0:
	add2 r0,r13,r0
L_8dcec4:
	st_s r2,[r0,0x14]
L_8dcec6:
	mov_s r1,sp
L_8dcec8:
	mov_s r0,0x0
L_8dceca:
	bl.d L_8e9900
L_8dcece:
	mov_s r2,r0
L_8dced0:
	ld_s r1,[sp,0x4]
L_8dced2:
	mov_s r0,0xff
L_8dced4:
	cmp_s r1,r0
L_8dced6:
	mov.cc r2,r0
L_8dceda:
	ld_s r0,[r13]
L_8dcedc:
	mov.cs r2,r1
L_8dcee0:
	add_s r1,r0,0x1
L_8dcee2:
	bmsk_s r1,r1,0x9
L_8dcee4:
	ld_s r3,[sp,0x0]
L_8dcee6:
	add2 r1,r13,r1
L_8dceea:
	st_s r3,[r1,0x14]
L_8dceec:
	bmsk r1,r16,0x13
L_8dcef0:
	or r1,r1,0xbc000000
L_8dcef8:
	extb_s r2,r2
L_8dcefa:
	asl_s r2,r2,0x12
L_8dcefc:
	or_s r1,r1,r2
L_8dcefe:
	bmsk r2,r0,0x9
L_8dcf02:
	add2 r2,r13,r2
L_8dcf06:
	st_s r1,[r2,0x14]
L_8dcf08:
	/* add_s r0,0x5 */
	.byte 0x05,0xe0
L_8dcf0a:
	st_s r0,[r13]
	.global L_8dcf0c
L_8dcf0c:
	b.d L_8c0244
L_8dcf10:
	add_s sp,sp,0x8
L_8dcf12:
	nop_s
L_8dcf14:
	push_s blink
L_8dcf16:
	bl L_8c01e4
L_8dcf1a:
	mov_s r14,r0
L_8dcf1c:
	mov_s r13,r1
L_8dcf1e:
	mov_s r0,0x0
L_8dcf20:
	st_s r0,[r1,0x14]
L_8dcf22:
	ld_s r1,[r14,0x14]
L_8dcf24:
	breq_s r1,0,L_8dcf36
L_8dcf26:
	ldb_s r2,[r13,0xa]
L_8dcf28:
	mov_s r1,0x1
L_8dcf2a:
	asl.f 0x0,0x1,r2
L_8dcf32:
	mov.ne r0,r1
	.global L_8dcf36
L_8dcf36:
	extb.f 0x0,r0
L_8dcf3a:
	bne_s L_8dcf70
L_8dcf3c:
	mov_s r1,0x1018b68
L_8dcf42:
	mov_s r0,0x27
L_8dcf44:
	bl.d L_8dcc10
L_8dcf48:
	mov_s r2,r13
L_8dcf4a:
	add3 r0,r14,0x8
L_8dcf4e:
	bl.d L_8e2884
L_8dcf52:
	mov_s r1,r13
L_8dcf54:
	ldb_s r2,[r13,0xb]
L_8dcf56:
	mov_s r0,r14
L_8dcf58:
	lsr_s r2,r2,0x6
L_8dcf5a:
	bl.d L_8c2af4
L_8dcf5e:
	mov_s r1,r13
L_8dcf60:
	brne_s r0,0,L_8dcf7e
L_8dcf62:
	mov_s r1,0x1018ba0
L_8dcf68:
	bl.d L_8dcba8
L_8dcf6c:
	mov_s r0,0x17
L_8dcf6e:
	b_s L_8dcf7e
	.global L_8dcf70
L_8dcf70:
	mov_s r1,0x1018bd0
L_8dcf76:
	mov_s r0,0x17
L_8dcf78:
	bl.d L_8dcc10
L_8dcf7c:
	mov_s r2,r13
	.global L_8dcf7e
L_8dcf7e:
	b L_8c0254
L_8dcf82:
	nop_s
