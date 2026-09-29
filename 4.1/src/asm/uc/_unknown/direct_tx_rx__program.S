/* direct_tx_rx__program @ 0x9334c4, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: direct_tx_rx_step, rx__send_response_frame, rx_flow__send_imm_response
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, direct_tx__program_cmd34, mac__program_tx_with_rate
 */
	.section .text.direct_tx_rx__program,"ax",@progbits
	.global direct_tx_rx__program
direct_tx_rx__program:
	.global L_9334c4
L_9334c4:
	push_s blink
L_9334c6:
	bl L_920210
L_9334ca:
	mov_s r13,r0
L_9334cc:
	mov_s r15,r1
L_9334ce:
	mov_s r14,r2
L_9334d0:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9334d2:
	or r0,r0,0x3e000000
L_9334da:
	mov_s r32,r0
L_9334dc:
	st.ab r0,[r25,0x4]
L_9334e0:
	bclr r25,r25,0xa
L_9334e4:
	mov_s r0,0x37000020
L_9334ea:
	mov_s r32,r0
L_9334ec:
	st.ab r0,[r25,0x4]
L_9334f0:
	bclr r25,r25,0xa
L_9334f4:
	mov_s r1,0x801458
L_9334fa:
	ld_s r0,[r1,0xc]
L_9334fc:
	bset_s r15,r15,0x18
L_9334fe:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_933500:
	st_s r0,[r1,0xc]
L_933502:
	mov_s r0,0x10
L_933504:
	bl.d L_924ea8
L_933508:
	mov_s r1,r14
L_93350a:
	bset_s r15,r15,0x1a
L_93350c:
	bset_s r15,r15,0x1c
L_93350e:
	mov_s r32,r15
L_933510:
	st.ab r15,[r25,0x4]
L_933514:
	bclr r25,r25,0xa
L_933518:
	mov_s r0,0x14000007
L_93351e:
	mov_s r32,r0
L_933520:
	st.ab r0,[r25,0x4]
L_933524:
	bclr r25,r25,0xa
L_933528:
	bl.d L_92a318
L_93352c:
	mov_s r0,r13
L_93352e:
	mov_s r0,0x2008000
L_933534:
	mov_s r32,r0
L_933536:
	st.ab r0,[r25,0x4]
L_93353a:
	bclr r25,r25,0xa
L_93353e:
	mov_s r0,0x19000001
L_933544:
	mov_s r32,r0
L_933546:
	st.ab r0,[r25,0x4]
L_93354a:
	bclr r25,r25,0xa
	.global L_93354e
L_93354e:
	mov_s r0,r45
L_933550:
	bbit0 r0,0x1f,L_93354e
L_933554:
	mov_s r0,0x18001000
L_93355a:
	mov_s r32,r0
L_93355c:
	st.ab r0,[r25,0x4]
L_933560:
	bclr r25,r25,0xa
L_933564:
	b L_92027c
