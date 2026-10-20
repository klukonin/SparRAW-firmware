/* pcie__dbi_transfer @ 0x8c828c, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dbi_write, mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, pcie__ack__8e026c, pcie__dbi_ack_done, pcie__dbi_set_addr, pcie__dbi_set_data, pcie__dbi_start_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__dbi_transfer
pcie__dbi_transfer:
	.global L_8c828c
L_8c828c:
	push_s blink
L_8c828e:
	bl L_8c01cc
L_8c8292:
	mov_s r20,r1
L_8c8294:
	mov_s r14,r2
L_8c8296:
	mov_s r15,r3
L_8c8298:
	mov r19,r4
L_8c829c:
	mov r17,r5
L_8c82a0:
	mov_s r13,r6
L_8c82a2:
	mov r18,r7
L_8c82a6:
	bl.d L_8d1220
L_8c82aa:
	mov r16,0x0
L_8c82ae:
	bl.d L_8d1464
L_8c82b2:
	mov_s r0,r20
L_8c82b4:
	brne r19,0x0,L_8c82ce
L_8c82b8:
	cmp_s r15,0x0
L_8c82ba:
	mov.ne r0,r16
L_8c82be:
	bne_s L_8c82d8
L_8c82c0:
	breq_s r14,0,L_8c82ce
L_8c82c2:
	breq r14,0x1,L_8c82d2
L_8c82c6:
	breq r14,0x2,L_8c82d6
L_8c82ca:
	mov_s r0,r16
L_8c82cc:
	b_s L_8c8332
	.global L_8c82ce
L_8c82ce:
	mov_s r0,0x1
L_8c82d0:
	b_s L_8c82d8
	.global L_8c82d2
L_8c82d2:
	mov_s r0,0x2
L_8c82d4:
	b_s L_8c82d8
	.global L_8c82d6
L_8c82d6:
	mov_s r0,0x4
	.global L_8c82d8
L_8c82d8:
	bmsk_s r0,r0,0x2
L_8c82da:
	bmsk_s r15,r15,0x0
L_8c82dc:
	/* asl_s r15,r15,0x3 */
	.byte 0x03,0xbf
L_8c82de:
	or r1,r15,r0
L_8c82e2:
	bmsk r0,r19,0x0
L_8c82e6:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c82e8:
	or_s r1,r1,r0
L_8c82ea:
	bmsk r0,r17,0x1
L_8c82ee:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8c82f0:
	or_s r1,r1,r0
L_8c82f2:
	bmsk r0,r18,0x0
L_8c82f6:
	asl_s r0,r0,0x8
L_8c82f8:
	or_s r1,r1,r0
L_8c82fa:
	bmsk r0,r13,0x0
L_8c82fe:
	asl_s r0,r0,0xb
L_8c8300:
	or_s r1,r1,r0
L_8c8302:
	ldb_s r0,[sp,0x24]
L_8c8304:
	mov_s r14,0x1
L_8c8306:
	bmsk_s r0,r0,0x0
L_8c8308:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_8c830a:
	or_s r1,r1,r0
L_8c830c:
	mov_s r0,r14
L_8c830e:
	and r1,r1,0x9ff
L_8c8316:
	bl.d L_8d122c
L_8c831a:
	mov_s r2,0xf
L_8c831c:
	brne r13,0x1,L_8c8326
L_8c8320:
	bl L_8e026c
L_8c8324:
	b_s L_8c8332
	.global L_8c8326
L_8c8326:
	cmp_s r13,0x0
L_8c8328:
	sub_s.ne r0,r0,r0
L_8c832a:
	bne_s L_8c8332
L_8c832c:
	bl L_8d11e8
L_8c8330:
	mov_s r0,r14
	.global L_8c8332
L_8c8332:
	b L_8c0224
L_8c8336:
	nop_s
