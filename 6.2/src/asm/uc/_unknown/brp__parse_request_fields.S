/* brp__parse_request_fields @ 0x92e1e4, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__exchange_request, brp_initiator_brp_transaction_flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brp__bits_uc_set32_s4_w5
 * Глобалы (через gp): 0x8005b6, 0x8005b8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__parse_request_fields
brp__parse_request_fields:
	.global L_92e1e4
L_92e1e4:
	push_s blink
L_92e1e6:
	bl.d L_920234
L_92e1ea:
	mov_s r2,r0
L_92e1ec:
	mov_s r13,0x804010
L_92e1f2:
	ldb r3,[r13, 0x21]
L_92e1f6:
	ldb r1,[r13, 0x20]
L_92e1fa:
	asl_s r3,r3,0x8
L_92e1fc:
	or_s r1,r1,r3
L_92e1fe:
	lsr_s r1,r1,0xa
L_92e200:
	bmsk r3,r1,0x0
L_92e204:
	ldw_s r1,[r13,0x24]
L_92e206:
	mov_s r0,0x0
L_92e208:
	lsr_s r1,r1,0xa
L_92e20a:
	bmsk_s r1,r1,0x0
L_92e20c:
	asl_s r14,r1,0x3
L_92e20e:
	ldb_s r1,[r13,0x1b]
L_92e210:
	sub_s sp,sp,0x4
L_92e212:
	lsr r13,r1,0x5
L_92e216:
	bmsk_s r13,r13,0x0
L_92e218:
	asl_s r13,r13
L_92e21a:
	bclr_s r3,r3,0x1
L_92e21c:
	bclr_s r14,r14,0x1
L_92e21e:
	bmsk.f 0x0,r1,0x4
L_92e222:
	or_s r3,r3,r14
L_92e224:
	or_s r3,r3,r13
L_92e226:
	beq_s L_92e22e
L_92e228:
	btst_s r3,0x3
L_92e22a:
	mov.eq r0,0x1
	.global L_92e22e
L_92e22e:
	bmsk_s r0,r0,0x0
L_92e230:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_92e232:
	bclr_s r3,r3,0x2
L_92e234:
	or_s r3,r3,r0
L_92e236:
	bmsk_s r1,r1,0x4
L_92e238:
	mov_s r0,sp
L_92e23a:
	bl.d L_93e3fc
L_92e23e:
	st_s r3,[sp,0x0]
L_92e240:
	mov_s r1,0x0
L_92e242:
	ldw_s r0,[gp,0x90]
L_92e244:
	bset r1,r1,r2
L_92e248:
	bic_s r0,r0,r1
L_92e24a:
	stw.as r0,[gp,0x48]
L_92e24e:
	ldw_s r0,[gp,0x8e]
L_92e250:
	or_s r1,r1,r0
L_92e252:
	ld_s r0,[sp,0x0]
L_92e254:
	stw.as r1,[gp,0x47]
L_92e258:
	b.d L_9202a4
L_92e25c:
	add_s sp,sp,0x4
L_92e25e:
	nop_s
