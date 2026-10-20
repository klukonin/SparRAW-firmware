/* ba__retry_flow @ 0x8ea2c8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BA retry flow (# %d)
 *   BA max retry flow (# %d) fail handle
 * Зовут его: ba_setup_sm__on_ready_to_run
 * Зовёт сам: __ld_r13_ret, ba_setup_sm__close_ba_setup_global_timeout, basic_sm__inject_event, fw_log__emit1
 */
	.section .text.ba__retry_flow,"ax",@progbits
	.global ba__retry_flow
ba__retry_flow:
	.global L_8ea2c8
L_8ea2c8:
	push_s blink
L_8ea2ca:
	push_s r13
L_8ea2cc:
	mov_s r13,r0
L_8ea2ce:
	add_s r0,r0,0x20
L_8ea2d0:
	ldb_s r3,[r0,0xc]
L_8ea2d2:
	brge r3,0x5,L_8ea2f0
L_8ea2d6:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8ea2d8:
	extb_s r3,r3
L_8ea2da:
	stb_s r3,[r0,0xc]
L_8ea2dc:
	mov_s r2,0x1010314
L_8ea2e2:
	mov_s r0,0x5
L_8ea2e4:
	bl.d L_8edfcc
L_8ea2e8:
	mov_s r1,0x2
L_8ea2ea:
	mov_s r0,r13
L_8ea2ec:
	mov_s r1,0x2
L_8ea2ee:
	b_s L_8ea316
	.global L_8ea2f0
L_8ea2f0:
	mov_s r2,0x101032c
L_8ea2f6:
	mov_s r0,0x5
L_8ea2f8:
	bl.d L_8edfcc
L_8ea2fc:
	mov_s r1,0x2
L_8ea2fe:
	bl.d L_8ea4b0
L_8ea302:
	mov_s r0,r13
L_8ea304:
	ld_s r0,[r13,0x44]
L_8ea306:
	mov_s r1,0x8
L_8ea308:
	mov_s r2,0x1
L_8ea30a:
	mov_s r3,0x0
L_8ea30c:
	bl.d L_8d6a1c
L_8ea310:
	mov_s r4,r3
L_8ea312:
	mov_s r0,r13
L_8ea314:
	mov_s r1,0x9
	.global L_8ea316
L_8ea316:
	mov_s r2,0x0
L_8ea318:
	mov_s r3,r2
L_8ea31a:
	bl.d L_8d6a1c
L_8ea31e:
	mov_s r4,r2
L_8ea320:
	b L_8c033c
