/* txss__flow_body @ 0x9361d4, 392 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__txss_by_slot
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, bf_substate__set, rate_search__apply_mcs, txss__duration_by_index, txss__init_sweep, txss__prepare_frames, txss__tx_sector_frame, txss_copy_step, txss_func__reorder_sectors
 * Глобалы (через gp): 0x8005d8, 0x800604, 0x800608
 */
	.section .text.txss__flow_body,"ax",@progbits
	.global txss__flow_body
txss__flow_body:
	.global L_9361d4
L_9361d4:
	push_s blink
L_9361d6:
	bl L_920210
L_9361da:
	mov_s r13,r0
L_9361dc:
	mov_s r14,r1
L_9361de:
	mov_s r0,0x1
L_9361e0:
	bl.d L_92c330
L_9361e4:
	mov_s r1,r13
L_9361e6:
	mov_s r0,0xbf
L_9361e8:
	asl_s r0,r0,0x10
L_9361ea:
	mov_s r32,r0
L_9361ec:
	st.ab r0,[r25,0x4]
L_9361f0:
	bclr r25,r25,0xa
L_9361f4:
	mov_s r0,0x8006a4
L_9361fa:
	ld_s r0,[r0,0x10]
L_9361fc:
	lr r0,[r0]
L_936200:
	bmsk_s r0,r0,0x17
L_936202:
	mov_s r32,r0
L_936204:
	st.ab r0,[r25,0x4]
L_936208:
	bclr r25,r25,0xa
L_93620c:
	mov_s r0,0x20
L_93620e:
	st.as r0,[gp,0x37]
L_936212:
	st.as 0x80000,[gp,0x38]
L_93621a:
	mov_s r0,0x49000001
L_936220:
	mov_s r32,r0
L_936222:
	st.ab r0,[r25,0x4]
L_936226:
	bclr r25,r25,0xa
L_93622a:
	mov_s r0,0x1
L_93622c:
	st.as r0,[gp,-0x7]
L_936230:
	mov_s r1,0x801a08
L_936236:
	ldw_s r0,[gp,0xb0]
L_936238:
	ldw_s r1,[r1,0xc]
L_93623a:
	breq r0,r1,L_936266
L_93623e:
	stw.as r1,[gp,0x58]
L_936242:
	or r1,r1,0x1730000
L_93624a:
	mov_s r0,0x886d00
L_936250:
	st_s r1,[r0]
L_936252:
	sync
L_936256:
	mov_s r0,0x38000200
L_93625c:
	mov_s r32,r0
L_93625e:
	st.ab r0,[r25,0x4]
L_936262:
	bclr r25,r25,0xa
	.global L_936266
L_936266:
	brne r14,0x5,L_93627a
L_93626a:
	mov_s r0,0x801bc6
L_936270:
	mul64 r13,0x1c
L_936274:
	ldw r15,[r0,mlo]
L_936278:
	b_s L_936288
	.global L_93627a
L_93627a:
	mul64 r14,0x1c
L_93627e:
	mov_s r0,0x801d06
L_936284:
	ldw r15,[r0,mlo]
	.global L_936288
L_936288:
	extw r6,r15
L_93628c:
	mov_s r0,r13
L_93628e:
	mov_s r1,r14
L_936290:
	mov_s r2,0x5
L_936292:
	mov_s r3,0x0
L_936294:
	mov_s r4,r3
L_936296:
	bl.d L_936864
L_93629a:
	mov_s r5,r3
L_93629c:
	brne r0,0x1,L_9362ee
L_9362a0:
	st.as 0x200000,[gp,0x38]
L_9362a8:
	mov_s r0,r14
L_9362aa:
	bl.d L_926450
L_9362ae:
	mov_s r1,r13
L_9362b0:
	mov_s r1,r0
L_9362b2:
	bl.d L_936074
L_9362b6:
	mov_s r0,r13
L_9362b8:
	brne r0,0x1,L_9362f6
L_9362bc:
	mov_s r0,0x800fcc
L_9362c2:
	ld_s r1,[r0]
L_9362c4:
	mov_s r2,0x801b08
L_9362ca:
	lsr r0,r1,0x6
L_9362ce:
	bmsk_s r0,r0,0x1
L_9362d0:
	stw_s r0,[r2,0x20]
L_9362d2:
	bmsk_s r1,r1,0x5
L_9362d4:
	stw_s r1,[r2,0x22]
L_9362d6:
	bl.d L_935f54
L_9362da:
	mov_s r0,r13
L_9362dc:
	ld_s r0,[gp,-0x78]
L_9362de:
	cmp_s r0,0x1
L_9362e0:
	bl.eq L_930f44
L_9362e4:
	mov_s r0,r13
L_9362e6:
	bl.d L_937818
L_9362ea:
	mov_s r1,0x0
L_9362ec:
	b_s L_9362f6
	.global L_9362ee
L_9362ee:
	mov_s r0,r13
L_9362f0:
	bl.d L_930dc4
L_9362f4:
	mov_s r1,0x1
	.global L_9362f6
L_9362f6:
	mov_s r0,0x0
L_9362f8:
	st.as r0,[gp,0x37]
L_9362fc:
	st.as r0,[gp,0x38]
L_936300:
	ld_s r0,[gp,-0x1c]
L_936302:
	breq_s r0,0,L_936356
L_936304:
	mov_s r1,0x801a08
L_93630a:
	ldw_s r0,[gp,0xb0]
L_93630c:
	ldw_s r1,[r1]
L_93630e:
	breq r0,r1,L_93633a
L_936312:
	stw.as r1,[gp,0x58]
L_936316:
	or r1,r1,0x1730000
L_93631e:
	mov_s r0,0x886d00
L_936324:
	st_s r1,[r0]
L_936326:
	sync
L_93632a:
	mov_s r0,0x38000200
L_936330:
	mov_s r32,r0
L_936332:
	st.ab r0,[r25,0x4]
L_936336:
	bclr r25,r25,0xa
	.global L_93633a
L_93633a:
	nop_s
L_93633c:
	nop_s
L_93633e:
	nop_s
L_936340:
	mov_s r0,0x1f000601
L_936346:
	mov_s r32,r0
L_936348:
	st.ab r0,[r25,0x4]
L_93634c:
	bclr r25,r25,0xa
L_936350:
	mov_s r0,0x0
L_936352:
	st.as r0,[gp,-0x7]
	.global L_936356
L_936356:
	b L_92027c
L_93635a:
	nop_s
