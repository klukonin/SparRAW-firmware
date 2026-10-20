/* sta_trace__push_record @ 0x8e3488, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_start, calib_engine__step, link_stats__collect, lmac_if_link_lost_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.sta_trace__push_record,"ax",@progbits
	.global sta_trace__push_record
sta_trace__push_record:
	.global L_8e3488
L_8e3488:
	push_s blink
L_8e348a:
	bl L_8c02c0
L_8e348e:
	mov_s r13,0x855800
L_8e3494:
	mov_s r1,0x855900
L_8e349a:
	ld.as r2,[gp,-0x53]
L_8e349e:
	add2_s r1,r1,r0
L_8e34a0:
	add2 r3,r13,r0
L_8e34a4:
	ld_s r14,[r1,0x38]
L_8e34a6:
	bbit0 r2,r0,L_8e34de
L_8e34aa:
	mov_s r2,0x886e80
L_8e34b0:
	ld_s r2,[r2,0x38]
L_8e34b2:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8e34b4:
	st_s r2,[r14,0x4]
L_8e34b6:
	ld_s r2,[r3,0x4]
L_8e34b8:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e34ba:
	st_s r2,[r14,0x8]
L_8e34bc:
	add_s r14,r13,r0
L_8e34be:
	ld_s r15,[r14,0x4c]
L_8e34c0:
	ld_s r2,[r1,0x38]
L_8e34c2:
	ld_s r14,[r14,0x54]
L_8e34c4:
	add_s r2,r2,r15
L_8e34c6:
	add_s r13,r13,r0
L_8e34c8:
	ld_s r13,[r13,0x50]
L_8e34ca:
	mul64_s r14,r15
L_8e34cc:
	add r0,r13,mlo
L_8e34d0:
	st_s r2,[r1,0x38]
L_8e34d2:
	brne r2,r0,L_8e34d8
L_8e34d6:
	st_s r13,[r1,0x38]
	.global L_8e34d8
L_8e34d8:
	ld_s r0,[r3,0x4]
L_8e34da:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e34dc:
	st_s r0,[r3,0x4]
	.global L_8e34de
L_8e34de:
	b L_8c032c
L_8e34e2:
	nop_s
