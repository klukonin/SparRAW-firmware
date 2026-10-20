/* rx_queue__config_by_kind_b @ 0x8df5fc, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_queue.c
 * Зовут его: rx_chain__configure_b
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_h_s0_w12, bf_w_s0_w4, fw_sysassert_fatal, get_g_800374, memset0_words
 * Глобалы (через gp): 0x800294
 */
	.section .text.rx_queue__config_by_kind_b,"ax",@progbits
	.global rx_queue__config_by_kind_b
rx_queue__config_by_kind_b:
	.global L_8df5fc
L_8df5fc:
	push_s blink
L_8df5fe:
	bl L_8c02c0
L_8df602:
	mov_s r14,r0
L_8df604:
	mov_s r13,r1
L_8df606:
	mov_s r15,r2
L_8df608:
	bl.d L_8c1a78
L_8df60c:
	mov_s r1,0x30
L_8df60e:
	brhs r13,0x6,L_8df668
L_8df612:
	ldb.x r13,[0x8022ac,r13]
L_8df61a:
	add r0,pcl,0xa
L_8df61e:
	add1_s r0,r0,r13
L_8df620:
	j_s [r0]
L_8df622:
	bl L_8ca0c4
L_8df626:
	cmp_s r0,0x0
L_8df628:
	mov_s r0,0x2
L_8df62a:
	bne_s L_8df63a
	.global L_8df62c
L_8df62c:
	mov_s r0,0x1
L_8df62e:
	b_s L_8df63a
L_8df630:
	ld_s r0,[gp,0x124]
L_8df632:
	breq_s r0,0,L_8df62c
L_8df634:
	mov_s r0,0x4
L_8df636:
	b_s L_8df63a
	.global L_8df638
L_8df638:
	mov_s r0,0x0
	.global L_8df63a
L_8df63a:
	bmsk r1,r0,0x3
L_8df63e:
	mov_s r0,r14
L_8df640:
	bl.d L_8e8348
L_8df644:
	mov_s r2,0x0
L_8df646:
	mov lp_count,0x8
L_8df64a:
	stb_s r15,[r14,0x2]
L_8df64c:
	lp L_8df664
L_8df650:
	mov_s r1,0xfff
L_8df656:
	add1 r3,r14,r2
L_8df65a:
	add_s r0,r3,0x4
L_8df65c:
	/* bl.d 0x008e8294 */
	.byte 0x3a,0x0c,0x60,0x04
L_8df660:
	/* _add_s r2,0x1 */
	.byte 0x01,0xe2
L_8df662:
	nop_s
	.global L_8df664
L_8df664:
	b L_8c032c
	.global L_8df668
L_8df668:
	mov_s r0,blink
L_8df66a:
	mov_s r2,0x1010150
L_8df670:
	mov_s r1,0x18
L_8df672:
	bset_s r1,r1,0xc
L_8df674:
	bl.d L_8c82c0
L_8df678:
	mov r3,0x17e
L_8df67c:
	b_s L_8df638
L_8df67e:
	nop_s
