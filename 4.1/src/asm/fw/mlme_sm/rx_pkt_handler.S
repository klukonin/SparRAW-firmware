/* rx_pkt_handler @ 0x8df208, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_pkt_handler invalid cid , stype %x length %d- drop pkt
 *   Received  ASSOC_REQ while disconnecting - packet will be dropped.
 *   Received redundant ASSOC_REQ with retry bit set - packet will be dropped
 *   Unknown stype... cid %d, stype %x, length %d
 *   mlme_sm.cpp
 * Зовут его: rx_mgmt_srvs__distribute
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__inject_event, conn_mgr__by_cid, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, mgmt_buf__free, mgmt_pkt__release, mid_list__by_mid, tail_rx_mgmt_prs__alloc_ei
 */
	.section .text.rx_pkt_handler,"ax",@progbits
	.global rx_pkt_handler
rx_pkt_handler:
	.global L_8df208
L_8df208:
	push_s blink
L_8df20a:
	bl L_8c02b8
L_8df20e:
	mov_s r14,r0
L_8df210:
	bl.d L_8ca1b0
L_8df214:
	ldb r0,[r0, 0x35]
L_8df218:
	bl.d L_8c9e44
L_8df21c:
	ldb r0,[r14, 0x36]
L_8df220:
	mov_s r13,r0
L_8df222:
	bl.d L_8df0e8
L_8df226:
	mov_s r0,r14
L_8df228:
	ld_s r0,[r14,0x8]
L_8df22a:
	ldw_s r0,[r0]
L_8df22c:
	lsr_s r0,r0,0x4
L_8df22e:
	bmsk r6,r0,0x3
L_8df232:
	brne_s r13,0,L_8df24a
L_8df234:
	mov_s r2,0x100f124
L_8df23a:
	ld r4,[r14, 0x30]
L_8df23e:
	mov_s r0,0xa
L_8df240:
	mov_s r1,0x1
L_8df242:
	bl.d L_8edff8
L_8df246:
	mov_s r3,r6
L_8df248:
	b_s L_8df2d6
	.global L_8df24a
L_8df24a:
	brhs r6,0xb,L_8df30a
L_8df24e:
	ldb.x r10,[0x801ff4,r6]
L_8df256:
	add r0,pcl,0xc
L_8df25a:
	add1 r0,r0,r10
L_8df25e:
	j_s [r0]
L_8df260:
	ldb r1,[r13, 0xfc]
L_8df264:
	mov_s r0,0x0
L_8df266:
	cmp_s r1,0x8
L_8df268:
	mov.ne r17,r0
L_8df26c:
	bne_s L_8df280
L_8df26e:
	mov_s r15,0x1
L_8df270:
	mov_s r2,0x100f160
L_8df276:
	mov_s r0,0xa
L_8df278:
	bl.d L_8edfb0
L_8df27c:
	mov_s r1,r15
L_8df27e:
	mov_s r17,r15
	.global L_8df280
L_8df280:
	add3 r15,r13,0x16
L_8df284:
	ld_s r0,[r15,0x30]
L_8df286:
	brne_s r0,0,L_8df28c
	.global L_8df288
L_8df288:
	mov_s r1,0x0
L_8df28a:
	b_s L_8df2a8
	.global L_8df28c
L_8df28c:
	ld_s r0,[r14,0x8]
L_8df28e:
	ldb_s r0,[r0,0x1]
L_8df290:
	bbit0 r0,0x3,L_8df288
L_8df294:
	mov r16,0x1
L_8df298:
	mov_s r2,0x100f1a4
L_8df29e:
	mov_s r0,0xa
L_8df2a0:
	bl.d L_8edfb0
L_8df2a4:
	mov_s r1,r16
L_8df2a6:
	mov_s r1,r16
	.global L_8df2a8
L_8df2a8:
	ld_s r2,[r13,0xc]
L_8df2aa:
	ld_s r2,[r2,0x50]
L_8df2ac:
	mov_s r0,0x0
L_8df2ae:
	cmp_s r2,0x2
L_8df2b0:
	cmp.ne r2,0x3
L_8df2b4:
	mov.eq r0,0x1
L_8df2b8:
	extb.f 0x0,r0
L_8df2bc:
	beq_s L_8df2d6
L_8df2be:
	cmp_s r1,0x0
L_8df2c0:
	cmp.eq r17,0x0
L_8df2c4:
	bne_s L_8df2d6
L_8df2c6:
	mov_s r0,r15
L_8df2c8:
	mov_s r1,0x0
	.global L_8df2ca
L_8df2ca:
	mov_s r2,r14
L_8df2cc:
	mov_s r3,0x0
L_8df2ce:
	bl.d L_8d6a1c
L_8df2d2:
	mov_s r4,r3
L_8df2d4:
	b_s L_8df336
	.global L_8df2d6
L_8df2d6:
	bl.d L_8c955c
L_8df2da:
	mov_s r0,r14
L_8df2dc:
	bl.d L_8c9538
L_8df2e0:
	mov_s r0,r14
L_8df2e2:
	b_s L_8df336
L_8df2e4:
	add3 r0,r13,0x16
L_8df2e8:
	ld_s r1,[r0,0x30]
L_8df2ea:
	breq_s r1,0,L_8df2d6
L_8df2ec:
	ldb_s r1,[r0]
L_8df2ee:
	breq r1,0x2,L_8df2d6
L_8df2f2:
	ld_s r1,[r14,0xc]
L_8df2f4:
	ldw r1,[r1, 0xcc]
L_8df2f8:
	cmp_s r1,0x0
L_8df2fa:
	mov_s r1,0x4
L_8df2fc:
	mov.ne r1,0x5
L_8df300:
	b_s L_8df2ca
L_8df302:
	add3 r0,r13,0x16
L_8df306:
	mov_s r1,0x2
L_8df308:
	b_s L_8df2ca
	.global L_8df30a
L_8df30a:
	ld r5,[r14, 0x30]
L_8df30e:
	mov_s r2,0x100f1f0
L_8df314:
	ldb_s r3,[r13,0x8]
L_8df316:
	mov_s r0,0xa
L_8df318:
	mov_s r1,0x1
L_8df31a:
	bl.d L_8ee034
L_8df31e:
	mov r4,r6
L_8df322:
	mov_s r0,blink
L_8df324:
	mov_s r2,0x100f220
L_8df32a:
	mov_s r1,0x9
L_8df32c:
	asl_s r1,r1,0x9
L_8df32e:
	bl.d L_8c82c0
L_8df332:
	mov r3,0x43a
	.global L_8df336
L_8df336:
	.byte 0xe9,0x07
