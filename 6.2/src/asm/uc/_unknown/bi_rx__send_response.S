/* bi_rx__send_response @ 0x939530, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, direct_tx__program_cmd34, direct_tx__send_with_seq, mac__program_tx_with_rate
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_rx__send_response
bi_rx__send_response:
	.global L_939530
L_939530:
	push_s blink
L_939532:
	bl L_920230
L_939536:
	mov_s r15,r0
L_939538:
	mov_s r13,r1
L_93953a:
	push_s r2
L_93953c:
	mov_s r14,r3
L_93953e:
	mov_s r0,0x16
L_939540:
	bl.d L_9257a8
L_939544:
	mov_s r1,0x18
L_939546:
	bl.d L_92d8e8
L_93954a:
	mov_s r0,r13
	.global L_93954c
L_93954c:
	mov_s r0,r43
L_93954e:
	bbit0 r0,0x1f,L_93954c
L_939552:
	mov_s r0,r51
L_939554:
	bmsk r1,r0,0x3
L_939558:
	st.as r1,[gp,0x38]
L_93955c:
	lsr_s r0,r0,0x4
L_93955e:
	st.as r0,[gp,0x39]
	.global L_939562
L_939562:
	mov_s r0,r45
L_939564:
	bbit0 r0,0x1f,L_939562
L_939568:
	cmp_s r14,0x0
L_93956a:
	mov_s r0,0x18
L_93956c:
	asl.ne r0,r0,0x18
L_939570:
	mov.eq r0,0x18002100
L_939578:
	mov_s r32,r0
L_93957a:
	st.ab r0,[r25,0x4]
L_93957e:
	bclr r25,r25,0xa
L_939582:
	ld_s r1,[sp,0x0]
L_939584:
	mov_s r0,r15
L_939586:
	bl.d L_9382b0
L_93958a:
	mov_s r2,r14
L_93958c:
	b.d L_92029c
L_939590:
	add_s sp,sp,0x4
L_939592:
	nop_s
