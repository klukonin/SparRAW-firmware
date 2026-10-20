/* hwd_phy__uses_rgf_883100 @ 0x8d2568, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__set_agc_start_val, ut_hw_drivers__pair_2568
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__uses_rgf_883100
hwd_phy__uses_rgf_883100:
	.global L_8d2568
L_8d2568:
	push_s r13
L_8d256a:
	push_s r14
L_8d256c:
	mov_s r14,0x883100
L_8d2572:
	ld_s r14,[r14,0x38]
L_8d2574:
	add_s r1,r1,r0
L_8d2576:
	bmsk_s r14,r14,0x5
L_8d2578:
	cmp_s r1,r14
L_8d257a:
	mov.cc r1,r14
L_8d257e:
	add_s r2,r2,r0
L_8d2580:
	cmp_s r2,r14
L_8d2582:
	mov.cc r2,r14
L_8d2586:
	add_s r3,r3,r0
L_8d2588:
	cmp_s r3,r14
L_8d258a:
	mov.cc r3,r14
L_8d258e:
	add_s r0,r0,r4
L_8d2590:
	cmp_s r0,r14
L_8d2592:
	mov.cc r0,r14
L_8d2596:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_8d2598:
	or_s r1,r1,r2
L_8d259a:
	asl_s r3,r3,0xc
L_8d259c:
	or_s r3,r3,r1
L_8d259e:
	asl_s r0,r0,0x12
L_8d25a0:
	or_s r0,r0,r3
L_8d25a2:
	pop_s r14
L_8d25a4:
	j_s.d [blink]
L_8d25a6:
	pop_s r13
