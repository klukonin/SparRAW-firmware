/* hwd_phy__program_883a68_block @ 0x8cf664, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_sysassert_fatal, memset0_words
 */
	.section .text.hwd_phy__program_883a68_block,"ax",@progbits
	.global hwd_phy__program_883a68_block
hwd_phy__program_883a68_block:
	.global L_8cf664
L_8cf664:
	push_s blink
L_8cf666:
	bl L_8c02b0
L_8cf66a:
	mov_s r14,r0
L_8cf66c:
	mov_s r15,r1
L_8cf66e:
	mov_s r16,r2
L_8cf670:
	mov_s r17,r3
L_8cf672:
	mov.f r13,r6
L_8cf676:
	mov r18,r4
L_8cf67a:
	mov r19,r5
L_8cf67e:
	beq_s L_8cf6e2
	.global L_8cf680
L_8cf680:
	mov_s r0,r13
L_8cf682:
	bl.d L_8c1a78
L_8cf686:
	mov_s r1,0xc
L_8cf688:
	mov_s r0,0x883a00
L_8cf68e:
	st_s r14,[r0,0x74]
L_8cf690:
	mov_s r3,0xffff0000
L_8cf696:
	ld_s r14,[r0,0x68]
L_8cf698:
	extw r2,r16
L_8cf69c:
	and_s r14,r14,r3
L_8cf69e:
	or_s r14,r14,r15
L_8cf6a0:
	extw_s r14,r14
L_8cf6a2:
	asl_s r2,r2,0x10
L_8cf6a4:
	or_s r2,r2,r14
L_8cf6a6:
	st_s r2,[r0,0x68]
L_8cf6a8:
	ld_s r14,[r0,0x6c]
L_8cf6aa:
	extw r2,r18
L_8cf6ae:
	and_s r3,r3,r14
L_8cf6b0:
	or r3,r3,r17
L_8cf6b4:
	extw_s r3,r3
L_8cf6b6:
	asl_s r2,r2,0x10
L_8cf6b8:
	or_s r3,r3,r2
L_8cf6ba:
	st_s r3,[r0,0x6c]
L_8cf6bc:
	extw r2,r19
L_8cf6c0:
	st_s r2,[r0,0x70]
L_8cf6c2:
	ld_s r2,[r0,0x78]
L_8cf6c4:
	mov_s r1,0x883800
L_8cf6ca:
	stw_s r2,[r13]
L_8cf6cc:
	ld_s r2,[r0,0x78]
L_8cf6ce:
	lsr_s r2,r2,0x10
L_8cf6d0:
	stw_s r2,[r13,0x2]
L_8cf6d2:
	ld_s r0,[r0,0x7c]
L_8cf6d4:
	st_s r0,[r13,0x4]
L_8cf6d6:
	ld.as r0,[r1,0xa0]
L_8cf6da:
	bmsk_s r0,r0,0x3
L_8cf6dc:
	b.d L_8c030c
L_8cf6e0:
	stb_s r0,[r13,0x8]
	.global L_8cf6e2
L_8cf6e2:
	mov_s r0,blink
L_8cf6e4:
	mov_s r2,0x1018690
L_8cf6ea:
	mov_s r1,0xe1
L_8cf6ec:
	bset_s r1,r1,0xc
L_8cf6ee:
	bl.d L_8c82c0
L_8cf6f2:
	mov r3,0x2dd
L_8cf6f6:
	b_s L_8cf680
