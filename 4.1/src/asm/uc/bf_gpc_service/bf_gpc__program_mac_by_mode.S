/* bf_gpc__program_mac_by_mode @ 0x92c9b0, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bf_gpc_service.cpp
 * Зовут его: bti_worker__collect_bf_metric
 * Зовёт сам: uc_sysassert
 */
	.section .text.bf_gpc__program_mac_by_mode,"ax",@progbits
	.global bf_gpc__program_mac_by_mode
bf_gpc__program_mac_by_mode:
	.global L_92c9b0
L_92c9b0:
	st.a r13,[sp,-0x8]
L_92c9b4:
	mov_s r13,0x801e68
L_92c9ba:
	ldb_s r0,[r13,0x3]
L_92c9bc:
	st_s r14,[sp,0x4]
L_92c9be:
	lsr_s r0,r0,0x2
L_92c9c0:
	bmsk r0,r0,0x3
L_92c9c4:
	brlo.d r0,0x4,L_92ca18
L_92c9c8:
	mov r14,blink
	.global L_92c9cc
L_92c9cc:
	mov_s r1,0x802060
L_92c9d2:
	sub_s r1,r1,0x8
L_92c9d4:
	ldw.as r3,[r1,r0]
L_92c9d8:
	or r3,r3,0x50000000
L_92c9e0:
	mov r32,r3
L_92c9e4:
	st.ab r3,[r25,0x4]
L_92c9e8:
	bclr r25,r25,0xa
L_92c9ec:
	mov_s r2,0x5300080e
L_92c9f2:
	mov_s r32,r2
L_92c9f4:
	st.ab r2,[r25,0x4]
L_92c9f8:
	bclr r25,r25,0xa
L_92c9fc:
	mov_s r1,0x49000080
L_92ca02:
	mov_s r32,r1
L_92ca04:
	st.ab r1,[r25,0x4]
L_92ca08:
	bclr r25,r25,0xa
L_92ca0c:
	mov_s blink,r14
L_92ca0e:
	ld_s r14,[sp,0x4]
L_92ca10:
	j.d [blink]
L_92ca14:
	ld.ab r13,[sp,0x8]
	.global L_92ca18
L_92ca18:
	mov_s r0,blink
L_92ca1a:
	mov_s r2,0x10028ec
L_92ca20:
	mov r1,0x1471
L_92ca28:
	bl.d L_925548
L_92ca2c:
	mov r3,0x37
L_92ca30:
	ldb_s r0,[r13,0x3]
L_92ca32:
	lsr_s r0,r0,0x2
L_92ca34:
	b.d L_92c9cc
L_92ca38:
	bmsk_s r0,r0,0x3
L_92ca3a:
	nop_s
