/* tof__alloc_session @ 0x8c3340, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tof__find_session_by_addr
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, mem_pool__allocate, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof__alloc_session
tof__alloc_session:
	.global L_8c3340
L_8c3340:
	push_s blink
L_8c3342:
	mov_s r0,0x80653c
L_8c3348:
	bl.d L_8c354c
L_8c334c:
	push_s r13
L_8c334e:
	mov.f r13,r0
L_8c3352:
	beq_s L_8c3362
	.global L_8c3354
L_8c3354:
	mov_s r0,r13
L_8c3356:
	bl.d L_8c1cd8
L_8c335a:
	mov_s r1,0x10
L_8c335c:
	b.d L_8c025c
L_8c3360:
	mov_s r0,r13
	.global L_8c3362
L_8c3362:
	mov_s r0,blink
L_8c3364:
	mov_s r1,0x1493
L_8c336a:
	bl L_8c9b28
L_8c336e:
	b_s L_8c3354
