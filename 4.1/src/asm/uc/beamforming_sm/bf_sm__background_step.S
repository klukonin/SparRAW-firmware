/* bf_sm__background_step @ 0x9225ec, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__step
 * Зовёт сам: __st_r17_to_r13_uc, bf_sm__process_request_fifo, uc_tx__is_idle, ucode_pm__set_busy_flag
 */
	.section .text.bf_sm__background_step,"ax",@progbits
	.global bf_sm__background_step
bf_sm__background_step:
	.global L_9225ec
L_9225ec:
	push_s blink
L_9225ee:
	bl L_920208
L_9225f2:
	mov_s r13,0x800ef4
L_9225f8:
	ld_s r0,[r13,0x6c]
L_9225fa:
	cmp_s r0,0x0
L_9225fc:
	beq L_92284a
L_922600:
	bl.d L_936d50
L_922604:
	mov_s r0,0x0
L_922606:
	bl L_936b2c
L_92260a:
	ld_s r0,[r13,0x78]
L_92260c:
	mov_s r1,0x800f64
L_922612:
	bmsk_s r0,r0,0x2
L_922614:
	ldb_s r14,[r1,r0]
L_922616:
	asl_s r0,r14,0x2
L_922618:
	add1_s r0,r0,r0
L_92261a:
	add_s r13,r13,r0
L_92261c:
	st.as r14,[gp,-0x2f]
L_922620:
	ld_s r0,[r13,0x4]
L_922622:
	ld_s r1,[r13]
L_922624:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_922626:
	or_s r0,r0,r1
L_922628:
	bmsk_s r0,r0,0xb
L_92262a:
	or r0,r0,0xfaf000
L_922632:
	mov_s r32,r0
L_922634:
	st.ab r0,[r25,0x4]
L_922638:
	bclr r25,r25,0xa
L_92263c:
	ld_s r1,[r13]
L_92263e:
	cmp_s r1,0x11
L_922640:
	bhi L_922812
L_922644:
	ldb r1,[0x800ba8,r1]
L_92264c:
	add r0,pcl,0x8
L_922650:
	add1_s r0,r0,r1
L_922652:
	j_s [r0]
