/* rx_mgmt_prs__parse @ 0x8de190, 468 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [PRS]Unhandled  MGMT type: sub_type %d stype %x len %d
 *   [PRS]: ERROR in pckt type %d: stype %d len %d
 *           id %x: ei_len %x pos_to_end %d
 *   [PRS]: ERROR -  id %x: ei_len %x pos_to_end %d < 0
 * Зовут его: rx_mgmt_prs__alloc_ei
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit3, fw_sysassert_fatal, hexdump_words, rx_mgmt_prs_step, set_parse_ei
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt_prs__parse
rx_mgmt_prs__parse:
	.global L_8de190
L_8de190:
	push_s blink
L_8de192:
	bl L_8c01cc
L_8de196:
	mov_s r20,r0
L_8de198:
	mov_s r14,r1
L_8de19a:
	mov_s r13,r2
L_8de19c:
	mov_s r19,r3
L_8de19e:
	mov_s r15,r4
L_8de1a0:
	mov r18,r5
L_8de1a4:
	st.a r3,[sp,-0x8]
L_8de1a8:
	mov_s r0,0x0
L_8de1aa:
	mov_s r16,r0
L_8de1ac:
	stb_s r0,[r2,0x4]
L_8de1ae:
	stb_s r0,[sp,0x4]
L_8de1b0:
	brne r5,0x3,L_8de1ca
L_8de1b4:
	cmp_s r15,0x0
L_8de1b6:
	bne_s L_8de2b4
L_8de1b8:
	mov_s r3,sp
L_8de1ba:
	add r4,sp,0x4
L_8de1be:
	bl.d L_8de0fc
L_8de1c2:
	mov_s r0,r20
L_8de1c4:
	ldb_s r0,[sp,0x4]
L_8de1c6:
	add_s r14,r14,r0
L_8de1c8:
	b_s L_8de2b4
	.global L_8de1ca
L_8de1ca:
	brhs r15,0xb,L_8de28e
L_8de1ce:
	ldb.x r10,[0x802c68,r15]
L_8de1d6:
	add r0,pcl,0xc
L_8de1da:
	add1 r0,r0,r10
L_8de1de:
	j_s [r0]
L_8de1e0:
	add3 r1,r13,0x10
L_8de1e4:
	st_s r14,[r1,0x30]
L_8de1e6:
	ld_s r0,[sp,0x0]
L_8de1e8:
	mov_s r15,0x5
L_8de1ea:
	sub_s r0,r0,0x8
L_8de1ec:
	st_s r0,[sp,0x0]
L_8de1ee:
	ldb_s r0,[r13,0x4]
L_8de1f0:
	add r2,r14,0x8
L_8de1f4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de1f6:
	stb_s r0,[r13,0x4]
L_8de1f8:
	ldb_s r0,[sp,0x4]
L_8de1fa:
	add_s r14,r14,0xa
L_8de1fc:
	add_s r0,r0,0x8
L_8de1fe:
	stb_s r0,[sp,0x4]
L_8de200:
	st_s r2,[r1,0x3c]
L_8de202:
	ld_s r0,[sp,0x0]
L_8de204:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8de206:
	st_s r0,[sp,0x0]
L_8de208:
	ldb_s r0,[r13,0x4]
L_8de20a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de20c:
	stb_s r0,[r13,0x4]
L_8de20e:
	ldb_s r0,[sp,0x4]
L_8de210:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8de212:
	stb_s r0,[sp,0x4]
L_8de214:
	st_s r14,[r1,0x34]
L_8de216:
	b_s L_8de26e
L_8de218:
	st r14,[r13, 0xb4]
L_8de21c:
	ld_s r0,[sp,0x0]
L_8de21e:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8de220:
	st_s r0,[sp,0x0]
L_8de222:
	ldb_s r0,[r13,0x4]
L_8de224:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de226:
	stb_s r0,[r13,0x4]
L_8de228:
	ldb_s r0,[sp,0x4]
L_8de22a:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8de22c:
	stb_s r0,[sp,0x4]
L_8de22e:
	ldw.a r0,[r14,0x2]
L_8de232:
	stw r0,[r13, 0xc8]
L_8de236:
	b_s L_8de26e
L_8de238:
	st r14,[r13, 0xb4]
L_8de23c:
	ld_s r0,[sp,0x0]
L_8de23e:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8de240:
	st_s r0,[sp,0x0]
L_8de242:
	ldb_s r0,[r13,0x4]
L_8de244:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de246:
	stb_s r0,[r13,0x4]
L_8de248:
	ldb_s r0,[sp,0x4]
L_8de24a:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8de24c:
	stb_s r0,[sp,0x4]
L_8de24e:
	ldw_s r0,[r14,0x2]
L_8de250:
	stw r0,[r13, 0xcc]
L_8de254:
	ld_s r0,[sp,0x0]
L_8de256:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8de258:
	st_s r0,[sp,0x0]
L_8de25a:
	ldb_s r0,[r13,0x4]
L_8de25c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de25e:
	stb_s r0,[r13,0x4]
L_8de260:
	ldb_s r0,[sp,0x4]
L_8de262:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8de264:
	stb_s r0,[sp,0x4]
L_8de266:
	ldw.a r0,[r14,0x4]
L_8de26a:
	stw r0,[r13, 0xca]
	.global L_8de26e
L_8de26e:
	ld_s r0,[sp,0x0]
L_8de270:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8de272:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_8de274:
	st_s r0,[sp,0x0]
L_8de276:
	ldb_s r0,[r13,0x4]
L_8de278:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de27a:
	stb_s r0,[r13,0x4]
L_8de27c:
	ldb_s r0,[sp,0x4]
L_8de27e:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8de280:
	stb_s r0,[sp,0x4]
L_8de282:
	b_s L_8de2b4
L_8de284:
	mov_s r15,0xa
L_8de286:
	ldw_s r0,[r14]
L_8de288:
	stw r0,[r13, 0xcc]
L_8de28c:
	b_s L_8de26e
	.global L_8de28e
L_8de28e:
	mov_s r1,0x101405c
L_8de294:
	mov_s r0,0xd
L_8de296:
	mov_s r2,r15
L_8de298:
	mov_s r3,r18
L_8de29a:
	bl.d L_8dcd00
L_8de29e:
	mov r4,r19
L_8de2a2:
	mov_s r0,r14
L_8de2a4:
	bl.d L_8c9790
L_8de2a8:
	mov_s r1,r19
L_8de2aa:
	mov_s r0,blink
L_8de2ac:
	mov_s r1,0xa6
L_8de2ae:
	bl.d L_8c9b28
L_8de2b2:
	bset_s r1,r1,0xc
	.global L_8de2b4
L_8de2b4:
	add3 r1,r13,0x10
L_8de2b8:
	st_s r14,[r1,0x50]
L_8de2ba:
	stb r16,[r1, 0x19]
L_8de2be:
	st r16,[r1, 0x1c]
L_8de2c2:
	stb r16,[r13, 0xa1]
L_8de2c6:
	st r16,[r1, 0x24]
L_8de2ca:
	b_s L_8de30e
	.global L_8de2cc
L_8de2cc:
	ldb r16,[r14]
L_8de2d0:
	sub r5,r0,0x2
L_8de2d4:
	ldb r17,[r14, 0x1]
L_8de2d8:
	/* add_s r14,0x2 */
	.byte 0x02,0xe6
L_8de2da:
	st r5,[sp]
L_8de2de:
	mov_s r0,r20
L_8de2e0:
	mov_s r1,r14
L_8de2e2:
	mov_s r2,r13
L_8de2e4:
	mov_s r3,r16
L_8de2e6:
	mov r4,r17
L_8de2ea:
	bl.d L_8e6a54
L_8de2ee:
	mov r6,r18
L_8de2f2:
	brlt r0,0x0,L_8de318
L_8de2f6:
	ld_s r0,[sp,0x0]
L_8de2f8:
	sub r0,r0,r17
L_8de2fc:
	st_s r0,[sp,0x0]
L_8de2fe:
	ldb_s r0,[r13,0x4]
L_8de300:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8de302:
	stb_s r0,[r13,0x4]
L_8de304:
	ld r4,[sp]
L_8de308:
	brlt.d r4,0x0,L_8de34c
L_8de30c:
	add_s r14,r14,r17
	.global L_8de30e
L_8de30e:
	ld_s r0,[sp,0x0]
L_8de310:
	brge r0,0x3,L_8de2cc
L_8de314:
	mov_s r0,0x1
L_8de316:
	b_s L_8de35e
	.global L_8de318
L_8de318:
	mov_s r1,0x1014094
L_8de31e:
	mov_s r0,0x2d
L_8de320:
	mov_s r2,r18
L_8de322:
	mov_s r3,r15
L_8de324:
	bl.d L_8dcd00
L_8de328:
	mov r4,r19
L_8de32c:
	mov_s r1,0x10140c4
L_8de332:
	ld r4,[sp]
L_8de336:
	mov_s r0,0x2d
L_8de338:
	mov_s r2,r16
L_8de33a:
	bl.d L_8dcd00
L_8de33e:
	mov_s r3,r17
L_8de340:
	mov_s r0,r14
L_8de342:
	bl.d L_8c9790
L_8de346:
	mov_s r1,r19
L_8de348:
	mov_s r0,0x0
L_8de34a:
	b_s L_8de35e
	.global L_8de34c
L_8de34c:
	mov_s r1,0x10140ec
L_8de352:
	mov_s r0,0xd
L_8de354:
	mov_s r2,r16
L_8de356:
	bl.d L_8dcd00
L_8de35a:
	mov_s r3,r17
L_8de35c:
	mov_s r0,0x0
	.global L_8de35e
L_8de35e:
	b.d L_8c0224
L_8de362:
	add_s sp,sp,0x8
