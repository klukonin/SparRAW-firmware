/* vendor_ie__build_wilocity @ 0x8e73a0, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channel_estimation_cmd_start, mid__log_network_type, mid__reset_bss_defaults, mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, vendor_ie__write_at_282
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vendor_ie__build_wilocity
vendor_ie__build_wilocity:
	.global L_8e73a0
L_8e73a0:
	sub_s sp,sp,0x4
L_8e73a2:
	push_s blink
L_8e73a4:
	bl.d L_8c01dc
L_8e73a8:
	mov r4,0x2
L_8e73ac:
	sub_s sp,sp,0xc
L_8e73ae:
	st_s r1,[sp,0x20]
L_8e73b0:
	mov_s r14,r0
L_8e73b2:
	cmp_s r2,0x1
L_8e73b4:
	mov_s r0,0x1
L_8e73b6:
	sub_s.ne r0,r0,r0
L_8e73b8:
	stw r0,[sp]
L_8e73bc:
	cmp_s r2,0x3
L_8e73be:
	mov_s r0,0x1
L_8e73c0:
	sub_s.ne r0,r0,r0
L_8e73c2:
	stw r0,[sp, 0x2]
L_8e73c6:
	mov_s r0,0xdd
L_8e73c8:
	add3 r13,r14,0x20
L_8e73cc:
	stb_s r0,[r13,0x1a]
L_8e73ce:
	mov_s r0,0x4
L_8e73d0:
	stb_s r0,[r13,0x1c]
L_8e73d2:
	mov_s r0,0xce
L_8e73d4:
	stb_s r0,[r13,0x1d]
L_8e73d6:
	mov_s r0,0x14
L_8e73d8:
	stb_s r0,[r13,0x1e]
L_8e73da:
	mov_s r2,0x1
L_8e73dc:
	mov_s r16,r2
L_8e73de:
	stw r2,[sp, 0x4]
L_8e73e2:
	add_s r3,sp,0x4
L_8e73e4:
	mov_s r0,r14
L_8e73e6:
	mov_s r1,0x5
L_8e73e8:
	bl.d L_8ebcd4
L_8e73ec:
	mov_s r2,r1
L_8e73ee:
	add_s r15,r0,0x5
L_8e73f0:
	extw_s r1,r15
L_8e73f2:
	mov_s r3,sp
L_8e73f4:
	mov_s r0,r14
L_8e73f6:
	mov_s r2,r16
L_8e73f8:
	bl.d L_8ebcd4
L_8e73fc:
	mov r4,0x2
L_8e7400:
	add_s r15,r15,r0
L_8e7402:
	extw_s r1,r15
L_8e7404:
	add_s r3,sp,0x20
L_8e7406:
	mov_s r0,r14
L_8e7408:
	mov_s r2,0x2
L_8e740a:
	bl.d L_8ebcd4
L_8e740e:
	mov r4,0x2
L_8e7412:
	add_s r15,r15,r0
L_8e7414:
	extw_s r1,r15
L_8e7416:
	add r3,sp,0x2
L_8e741a:
	mov_s r0,r14
L_8e741c:
	mov_s r2,0x3
L_8e741e:
	bl.d L_8ebcd4
L_8e7422:
	mov r4,0x2
L_8e7426:
	add_s r15,r15,r0
L_8e7428:
	mov_s r0,0x880a7c
L_8e742e:
	ldw_s r0,[r0,0x10]
L_8e7430:
	extw_s r1,r15
L_8e7432:
	stw r0,[sp, 0x6]
L_8e7436:
	add r3,sp,0x6
L_8e743a:
	mov_s r0,r14
L_8e743c:
	mov_s r2,0x6
L_8e743e:
	bl.d L_8ebcd4
L_8e7442:
	mov r4,0x2
L_8e7446:
	add_s r15,r15,r0
L_8e7448:
	stw r16,[sp, 0x8]
L_8e744c:
	extw_s r1,r15
L_8e744e:
	add_s r3,sp,0x8
L_8e7450:
	mov_s r0,r14
L_8e7452:
	mov_s r2,0x7
L_8e7454:
	bl.d L_8ebcd4
L_8e7458:
	mov r4,0x2
L_8e745c:
	add_s r0,r0,r15
L_8e745e:
	sub_s r1,r0,0x2
L_8e7460:
	extb_s r1,r1
L_8e7462:
	stb_s r1,[r13,0x1b]
L_8e7464:
	add r14,r14,0x17a
L_8e7468:
	stb_s r0,[r14]
L_8e746a:
	mov_s r12,0x8
L_8e746c:
	b.d L_8c0246
L_8e7470:
	add_s sp,sp,0xc
L_8e7472:
	nop_s
