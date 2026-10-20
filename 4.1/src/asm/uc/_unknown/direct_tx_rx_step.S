/* direct_tx_rx_step @ 0x931434, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__post_rx_act9
 * Зовёт сам: direct_tx__init_rx_desc, direct_tx__issue_cmd_33, direct_tx__push_payload, direct_tx_rx__program, uc_wait_direct_tx_ready
 */
	.section .text.direct_tx_rx_step,"ax",@progbits
	.global direct_tx_rx_step
direct_tx_rx_step:
	.global L_931434
L_931434:
	st.a r13,[sp,-0x8]
L_931438:
	st_s r14,[sp,0x4]
L_93143a:
	sub_s sp,sp,0x18
L_93143c:
	ldw r1,[0x804012]
L_931444:
	mov_s r14,blink
L_931446:
	sub_s r1,r1,0x14
L_931448:
	mov r0,0x0
L_93144c:
	bl.d L_9334c4
L_931450:
	mov r2,0x17
L_931454:
	mov_s r0,sp
L_931456:
	mov_s r1,0x1
L_931458:
	bl.d L_9243fc
L_93145c:
	mov r2,r1
L_931460:
	ldw r33,[sp]
L_931464:
	ld.as r2,[gp,-0x6]
L_931468:
	add_s r13,sp,0x10
L_93146a:
	sub_s r2,r2,0x10
L_93146c:
	st.as r2,[gp,-0x6]
L_931470:
	mov r4,0x33000063
L_931478:
	mov r32,r4
L_93147c:
	st.ab r4,[r25,0x4]
L_931480:
	bclr r25,r25,0xa
L_931484:
	bl L_924f7c
L_931488:
	mov r0,r13
L_93148c:
	bl.d L_924ef4
L_931490:
	mov r1,0x7
L_931494:
	bl L_924e6c
L_931498:
	mov r5,0x801458
L_9314a0:
	ld r3,[r5, 0x2c]
L_9314a4:
	mov_s blink,r14
L_9314a6:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_9314a8:
	st r3,[r5, 0x2c]
L_9314ac:
	add_s sp,sp,0x18
L_9314ae:
	ld_s r14,[sp,0x4]
L_9314b0:
	j.d [blink]
L_9314b4:
	ld.ab r13,[sp,0x8]
