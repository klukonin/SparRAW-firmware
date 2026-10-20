/* mid__lookup_for_tx @ 0x8c655c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid.cpp
 * Зовут его: tx_send_packet_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, iter__has_more, iter__init, iter__next, mid__copy_addr
 */
	.section .text.mid__lookup_for_tx,"ax",@progbits
	.global mid__lookup_for_tx
mid__lookup_for_tx:
	.global L_8c655c
L_8c655c:
	push_s blink
L_8c655e:
	bl L_8c02bc
L_8c6562:
	add r15,r0,0x18
L_8c6566:
	ld_s r0,[r15]
L_8c6568:
	mov_s r13,r1
L_8c656a:
	sub.f r0,r0,0x0
L_8c656e:
	mov.ne r0,0x1
L_8c6572:
	extb.f 0x0,r0
L_8c6576:
	sub_s sp,sp,0x4
L_8c6578:
	mov_s r16,r2
L_8c657a:
	beq_s L_8c65b4
	.global L_8c657c
L_8c657c:
	mov_s r14,sp
L_8c657e:
	mov_s r0,r14
L_8c6580:
	bl.d L_8e1138
L_8c6584:
	mov_s r1,r15
L_8c6586:
	b_s L_8c6594
	.global L_8c6588
L_8c6588:
	bl.d L_8db188
L_8c658c:
	mov_s r0,r14
L_8c658e:
	ldb_s r1,[r0,0x8]
L_8c6590:
	breq r13,r1,L_8c65cc
	.global L_8c6594
L_8c6594:
	bl.d L_8cb674
L_8c6598:
	mov_s r0,r14
L_8c659a:
	brne_s r0,0,L_8c6588
L_8c659c:
	mov_s r0,blink
L_8c659e:
	mov_s r2,0x100aedc
L_8c65a4:
	mov_s r1,0x11ee
L_8c65aa:
	bl.d L_8c82c0
L_8c65ae:
	mov r3,0x2a7
L_8c65b2:
	b_s L_8c65d2
	.global L_8c65b4
L_8c65b4:
	mov_s r0,blink
L_8c65b6:
	mov_s r2,0x100aedc
L_8c65bc:
	mov_s r1,0x11ed
L_8c65c2:
	bl.d L_8c82c0
L_8c65c6:
	mov r3,0x299
L_8c65ca:
	b_s L_8c657c
	.global L_8c65cc
L_8c65cc:
	bl.d L_8ea984
L_8c65d0:
	mov_s r1,r16
	.global L_8c65d2
L_8c65d2:
	b.d L_8c0324
L_8c65d6:
	add_s sp,sp,0x4
