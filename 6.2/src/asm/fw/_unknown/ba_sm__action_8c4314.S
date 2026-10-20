/* ba_sm__action_8c4314 @ 0x8c4314, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BA Setup succeed: WSIZE %d. TIMEOUT: %d, AMSDU: %d
 *   BA Setup failed: reason %d (wsize %d).
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8c4314
ba_sm__action_8c4314:
	.global L_8c4314
L_8c4314:
	push_s blink
L_8c4316:
	bl L_8c01dc
L_8c431a:
	mov_s r14,r0
L_8c431c:
	mov.f r2,r1
L_8c4320:
	add_s r0,r0,0x8
L_8c4322:
	ldb_s r13,[r0,0x19]
L_8c4324:
	ldw_s r15,[r0,0x1e]
L_8c4326:
	bne_s L_8c4360
L_8c4328:
	ldb r16,[r0, 0x1b]
L_8c432c:
	mov_s r1,0x1013560
L_8c4332:
	mov_s r0,0x2b
L_8c4334:
	mov_s r2,r13
L_8c4336:
	mov_s r3,r15
L_8c4338:
	bl.d L_8dcd00
L_8c433c:
	mov r4,r16
L_8c4340:
	breq_s r13,0,L_8c4352
	.global L_8c4342
L_8c4342:
	ld_s r0,[r14,0x40]
L_8c4344:
	mov_s r2,r15
L_8c4346:
	ld_s r1,[r0,0x68]
L_8c4348:
	ld_s r14,[r1,0x18]
L_8c434a:
	mov_s r1,r13
L_8c434c:
	jl_s.d [r14]
L_8c434e:
	mov_s r3,r16
L_8c4350:
	b_s L_8c4378
	.global L_8c4352
L_8c4352:
	mov_s r0,blink
L_8c4354:
	mov_s r1,0x133e
L_8c435a:
	bl L_8c9b28
L_8c435e:
	b_s L_8c4342
	.global L_8c4360
L_8c4360:
	mov_s r1,0x1013594
L_8c4366:
	mov_s r0,0x2b
L_8c4368:
	bl.d L_8dcc80
L_8c436c:
	mov_s r3,r13
L_8c436e:
	ld_s r0,[r14,0x40]
L_8c4370:
	ld_s r1,[r0,0x68]
L_8c4372:
	ld_s r2,[r1,0x1c]
L_8c4374:
	jl_s.d [r2]
L_8c4376:
	mov_s r1,0x0
	.global L_8c4378
L_8c4378:
	b L_8c0244
