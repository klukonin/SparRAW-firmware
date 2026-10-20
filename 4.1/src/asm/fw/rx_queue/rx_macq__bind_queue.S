/* rx_macq__bind_queue @ 0x8df710, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_queue.c
 * Зовут его: rx_macq__bind_all_queues
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.rx_macq__bind_queue,"ax",@progbits
	.global rx_macq__bind_queue
rx_macq__bind_queue:
	.global L_8df710
L_8df710:
	push_s blink
L_8df712:
	bl L_8c02bc
L_8df716:
	mov_s r14,r0
L_8df718:
	mov_s r13,r1
L_8df71a:
	mov_s r15,r2
L_8df71c:
	mov_s r16,r3
L_8df71e:
	cmp_s r2,0xc
L_8df720:
	cmp.cs r14,0x20
L_8df724:
	bcc L_8df764
	.global L_8df728
L_8df728:
	cmp r16,0x0
L_8df72c:
	sub_s.ne r0,r0,r0
L_8df72e:
	mov.eq r0,r15
L_8df732:
	lsr r1,r14,0x3
L_8df736:
	mov_s r2,0x886800
L_8df73c:
	add2_s r2,r2,r1
L_8df73e:
	bmsk r1,r14,0x2
L_8df742:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8df744:
	mov_s r3,0xf
L_8df746:
	ld_s r15,[r2]
L_8df748:
	asl_s r3,r3,r1
L_8df74a:
	bic_s r15,r15,r3
L_8df74c:
	asl_s r0,r0,r1
L_8df74e:
	or_s r0,r0,r15
L_8df750:
	st_s r0,[r2]
L_8df752:
	breq_s r13,0,L_8df77a
L_8df754:
	breq r13,0x1,L_8df782
L_8df758:
	cmp_s r13,0x2
L_8df75a:
	mov.eq r2,0x886828
L_8df762:
	b_s L_8df788
	.global L_8df764
L_8df764:
	mov_s r0,blink
L_8df766:
	mov_s r2,0x1010150
L_8df76c:
	mov_s r1,0x1d
L_8df76e:
	bset_s r1,r1,0xc
L_8df770:
	bl.d L_8c82c0
L_8df774:
	mov r3,0x224
L_8df778:
	b_s L_8df728
	.global L_8df77a
L_8df77a:
	mov_s r2,0x886820
L_8df780:
	b_s L_8df788
	.global L_8df782
L_8df782:
	mov_s r2,0x886824
	.global L_8df788
L_8df788:
	ld_s r0,[r2]
L_8df78a:
	mov_s r1,0x0
L_8df78c:
	cmp r16,0x0
L_8df790:
	bset r1,r1,r14
L_8df794:
	bic.ne r0,r0,r1
L_8df798:
	bne_s L_8df79c
L_8df79a:
	or_s r0,r0,r1
	.global L_8df79c
L_8df79c:
	st_s r0,[r2]
L_8df79e:
	b L_8c0324
L_8df7a2:
	nop_s
