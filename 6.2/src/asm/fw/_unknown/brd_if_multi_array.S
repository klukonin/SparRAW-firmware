/* brd_if_multi_array @ 0x8c630c, 264 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::check_physical_section_validity: Unknown section_type=%d,sections_count=%d
 *   brd_if_multi_array::find_section: Bad validation pattern, actual_pattern=0x%X, vp1_allowed=0x%X, vp2_allowed=0x%X
 *   brd_if_multi_array::check_physical_section_validity: Length of section (section_type=%d) exceeds brd file boundary
 *   brd_if_multi_array::check_physical_section_validity: buffer_size=%d, secton_offset_bytes=%d, section_size_bytes=%d
 *   brd_if_multi_array::check_physical_section_validity: actual_vp=%d, vps_allowed.vp1=%d, vps_allowed.vp2=%d
 *   brd_if_multi_array::find_section: Corrupted physical section header
 *   brd_if_multi_array::find_section: Physical section type=%d doesn't match virtual section type=%d
 * Зовут его: brd_if_multi_array__find_section
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, brd_if__check_section_header, brd_if_multi_array__physical_section_header_u, edmg__channel_matches_mode, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array
brd_if_multi_array:
	.global L_8c630c
L_8c630c:
	push_s blink
L_8c630e:
	bl L_8c01d0
L_8c6312:
	mov_s r13,r0
L_8c6314:
	mov_s r14,r1
L_8c6316:
	mov_s r16,r2
L_8c6318:
	mov_s r19,r3
L_8c631a:
	brlo.d r1,0xa,L_8c6334
L_8c631e:
	mov_s r15,r4
L_8c6320:
	mov_s r1,0x100a940
L_8c6326:
	mov_s r0,0x0
L_8c6328:
	mov_s r2,r14
L_8c632a:
	bl.d L_8dcc80
L_8c632e:
	mov_s r3,0xa
L_8c6330:
	mov_s r0,0x0
L_8c6332:
	b_s L_8c6410
	.global L_8c6334
L_8c6334:
	ld_s r0,[r13,0x48]
L_8c6336:
	ld_s r3,[r15]
L_8c6338:
	add_s r0,r0,0x8
L_8c633a:
	add r18,r0,r16
L_8c633e:
	ld r17,[r18]
L_8c6342:
	mov_s r0,0x0
L_8c6344:
	breq r3,r17,L_8c634e
L_8c6348:
	ld_s r1,[r15,0x4]
L_8c634a:
	brne r1,r17,L_8c6350
	.global L_8c634e
L_8c634e:
	mov_s r0,0x1
	.global L_8c6350
L_8c6350:
	extb.f 0x0,r0
L_8c6354:
	bne_s L_8c636c
L_8c6356:
	mov_s r1,0x100a9a0
L_8c635c:
	ld r4,[r15, 0x4]
L_8c6360:
	mov_s r0,0x0
L_8c6362:
	bl.d L_8dcd00
L_8c6366:
	mov_s r2,r17
L_8c6368:
	mov_s r0,0x0
L_8c636a:
	b_s L_8c6410
	.global L_8c636c
L_8c636c:
	ld_s r0,[r13,0x4c]
L_8c636e:
	add r1,r19,r16
L_8c6372:
	sub_s r0,r0,0x8
L_8c6374:
	brhs r0,r1,L_8c63c6
L_8c6378:
	mov_s r1,0x100aa14
L_8c637e:
	mov_s r0,0x0
L_8c6380:
	bl.d L_8dcc10
L_8c6384:
	mov_s r2,r14
L_8c6386:
	ld_s r2,[r13,0x4c]
L_8c6388:
	mov_s r1,0x100aa88
L_8c638e:
	sub_s r2,r2,0x8
L_8c6390:
	mov_s r0,0x0
L_8c6392:
	mov_s r3,r16
L_8c6394:
	bl.d L_8dcd00
L_8c6398:
	mov r4,r19
L_8c639c:
	mov_s r1,0x100aafc
L_8c63a2:
	ld r4,[r15, 0x4]
L_8c63a6:
	mov_s r0,0x0
L_8c63a8:
	mov_s r2,r17
L_8c63aa:
	bl.d L_8dcd00
L_8c63ae:
	ld_s r3,[r15]
L_8c63b0:
	add r0,r18,0x8
L_8c63b4:
	bl.d L_8e0f4c
L_8c63b8:
	mov_s r1,0x0
L_8c63ba:
	mov_s r0,blink
L_8c63bc:
	mov_s r1,0x1366
L_8c63c2:
	bl L_8c9b28
	.global L_8c63c6
L_8c63c6:
	add r15,r18,0x8
L_8c63ca:
	mov_s r0,r13
L_8c63cc:
	bl.d L_8ebdc4
L_8c63d0:
	mov_s r1,r15
L_8c63d2:
	brne_s r0,0,L_8c63e4
L_8c63d4:
	mov_s r1,0x100ab68
L_8c63da:
	bl.d L_8dcba8
L_8c63de:
	mov_s r0,0x0
L_8c63e0:
	mov_s r0,0x0
L_8c63e2:
	b_s L_8c6410
	.global L_8c63e4
L_8c63e4:
	ld_s r2,[r15]
L_8c63e6:
	mov_s r0,r13
L_8c63e8:
	lsr_s r2,r2,0x14
L_8c63ea:
	mov_s r1,r14
L_8c63ec:
	bl.d L_8c6430
L_8c63f0:
	bmsk_s r2,r2,0x3
L_8c63f2:
	brne_s r0,0,L_8c640e
L_8c63f4:
	ld_s r2,[r15]
L_8c63f6:
	mov_s r1,0x100abac
L_8c63fc:
	lsr_s r2,r2,0x14
L_8c63fe:
	mov_s r13,0x0
L_8c6400:
	mov_s r0,r13
L_8c6402:
	bmsk_s r2,r2,0x3
L_8c6404:
	bl.d L_8dcc80
L_8c6408:
	mov_s r3,r14
L_8c640a:
	mov_s r0,r13
L_8c640c:
	b_s L_8c6410
	.global L_8c640e
L_8c640e:
	mov_s r0,0x1
	.global L_8c6410
L_8c6410:
	b L_8c022c
