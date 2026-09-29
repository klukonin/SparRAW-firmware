/* hwd_phy__rx_apu_calc @ 0x8d2314, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_sysassert_fatal, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_apu_calc
hwd_phy__rx_apu_calc:
	.global L_8d2314
L_8d2314:
	push_s blink
L_8d2316:
	bl L_8c01d0
L_8d231a:
	mov_s r14,r0
L_8d231c:
	mov_s r15,r1
L_8d231e:
	mov_s r17,r2
L_8d2320:
	mov_s r16,r3
L_8d2322:
	mov.f r13,r6
L_8d2326:
	mov r18,r4
L_8d232a:
	mov r19,r5
L_8d232e:
	beq_s L_8d2392
	.global L_8d2330
L_8d2330:
	mov_s r0,r13
L_8d2332:
	bl.d L_8c1cd8
L_8d2336:
	mov_s r1,0xc
L_8d2338:
	mov_s r0,0x883a00
L_8d233e:
	st_s r14,[r0,0x74]
L_8d2340:
	mov_s r3,0xffff0000
L_8d2346:
	ld_s r14,[r0,0x68]
L_8d2348:
	extw r2,r17
L_8d234c:
	and_s r14,r14,r3
L_8d234e:
	or_s r14,r14,r15
L_8d2350:
	extw_s r14,r14
L_8d2352:
	asl_s r2,r2,0x10
L_8d2354:
	or_s r2,r2,r14
L_8d2356:
	st_s r2,[r0,0x68]
L_8d2358:
	ld_s r14,[r0,0x6c]
L_8d235a:
	extw r2,r18
L_8d235e:
	and_s r3,r3,r14
L_8d2360:
	or r3,r3,r16
L_8d2364:
	extw_s r3,r3
L_8d2366:
	asl_s r2,r2,0x10
L_8d2368:
	or_s r3,r3,r2
L_8d236a:
	st_s r3,[r0,0x6c]
L_8d236c:
	extw r2,r19
L_8d2370:
	st_s r2,[r0,0x70]
L_8d2372:
	ld_s r2,[r0,0x78]
L_8d2374:
	mov_s r1,0x883800
L_8d237a:
	stw_s r2,[r13]
L_8d237c:
	ld_s r2,[r0,0x78]
L_8d237e:
	lsr_s r2,r2,0x10
L_8d2380:
	stw_s r2,[r13,0x2]
L_8d2382:
	ld_s r0,[r0,0x7c]
L_8d2384:
	st_s r0,[r13,0x4]
L_8d2386:
	ld.as r0,[r1,0xa0]
L_8d238a:
	bmsk_s r0,r0,0x3
L_8d238c:
	b.d L_8c022c
L_8d2390:
	stb_s r0,[r13,0x8]
	.global L_8d2392
L_8d2392:
	mov_s r0,blink
L_8d2394:
	mov_s r1,0xe1
L_8d2396:
	bl.d L_8c9b28
L_8d239a:
	bset_s r1,r1,0xc
L_8d239c:
	b_s L_8d2330
L_8d239e:
	nop_s
