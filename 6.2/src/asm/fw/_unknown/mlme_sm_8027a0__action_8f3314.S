/* mlme_sm_8027a0__action_8f3314 @ 0x8f3314, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, install_key_index_stub, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme_sm_8027a0__action_8f3314
mlme_sm_8027a0__action_8f3314:
	.global L_8f3314
L_8f3314:
	push_s blink
L_8f3316:
	push_s r13
L_8f3318:
	mov_s r13,r0
L_8f331a:
	ld_s r0,[r0,0xc]
L_8f331c:
	sub_s sp,sp,0x10
L_8f331e:
	bclr.f r0,r0,0x0
L_8f3322:
	st_s r0,[r13,0xc]
L_8f3324:
	bne_s L_8f3346
	.global L_8f3326
L_8f3326:
	mov_s r0,sp
L_8f3328:
	bl.d L_8c1cd8
L_8f332c:
	mov_s r1,0x10
L_8f332e:
	ld_s r0,[r13,0x8]
L_8f3330:
	mov_s r2,sp
L_8f3332:
	ld_s r0,[r0,0x8]
L_8f3334:
	mov_s r1,0x1
L_8f3336:
	ldb_s r0,[r0,0x8]
L_8f3338:
	mov_s r3,0x0
L_8f333a:
	bl.d L_8f0c98
L_8f333e:
	mov_s r4,r3
L_8f3340:
	b.d L_8c025c
L_8f3344:
	add_s sp,sp,0x10
	.global L_8f3346
L_8f3346:
	mov_s r0,blink
L_8f3348:
	mov_s r1,0x11c3
L_8f334e:
	bl L_8c9b28
L_8f3352:
	b_s L_8f3326
