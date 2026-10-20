/* tx__send_imm_response @ 0x9385d8, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__send_dmg_cts, rx__send_response_frame, rx_flow__send_imm_response
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, direct_tx__program_cmd34, mac__program_tx_with_rate
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__send_imm_response
tx__send_imm_response:
	.global L_9385d8
L_9385d8:
	push_s blink
L_9385da:
	bl L_920230
L_9385de:
	mov_s r13,r0
L_9385e0:
	mov_s r15,r1
L_9385e2:
	mov_s r14,r2
L_9385e4:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_9385e6:
	or r0,r0,0x3e000000
L_9385ee:
	mov_s r32,r0
L_9385f0:
	st.ab r0,[r25,0x4]
L_9385f4:
	bclr r25,r25,0xa
L_9385f8:
	mov_s r0,0x37000020
L_9385fe:
	mov_s r32,r0
L_938600:
	st.ab r0,[r25,0x4]
L_938604:
	bclr r25,r25,0xa
L_938608:
	mov_s r1,0x8022c8
L_93860e:
	ld_s r0,[r1,0xc]
L_938610:
	bset_s r15,r15,0x18
L_938612:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_938614:
	st_s r0,[r1,0xc]
L_938616:
	ld_s r0,[gp,0x178]
L_938618:
	mov_s r1,0x802940
L_93861e:
	bclr_s r0,r0,0x18
L_938620:
	ld_s r1,[r1]
L_938622:
	bclr_s r0,r0,0x19
L_938624:
	asl_s r1,r1,0x18
L_938626:
	or_s r0,r0,r1
L_938628:
	st.as r0,[gp,0x5e]
L_93862c:
	mov_s r1,0x889480
L_938632:
	st_s r0,[r1,0x8]
L_938634:
	mov_s r0,0x10
L_938636:
	bl.d L_9257a8
L_93863a:
	mov_s r1,r14
L_93863c:
	bset_s r15,r15,0x1a
L_93863e:
	bset_s r15,r15,0x1c
L_938640:
	mov_s r32,r15
L_938642:
	st.ab r15,[r25,0x4]
L_938646:
	bclr r25,r25,0xa
L_93864a:
	mov_s r0,0x14000007
L_938650:
	mov_s r32,r0
L_938652:
	st.ab r0,[r25,0x4]
L_938656:
	bclr r25,r25,0xa
L_93865a:
	bl.d L_92d8e8
L_93865e:
	mov_s r0,r13
L_938660:
	mov_s r0,0x2008000
L_938666:
	mov_s r32,r0
L_938668:
	st.ab r0,[r25,0x4]
L_93866c:
	bclr r25,r25,0xa
L_938670:
	mov_s r0,0x19000001
L_938676:
	mov_s r32,r0
L_938678:
	st.ab r0,[r25,0x4]
L_93867c:
	bclr r25,r25,0xa
	.global L_938680
L_938680:
	mov_s r0,r45
L_938682:
	bbit0 r0,0x1f,L_938680
L_938686:
	mov_s r0,0x18001000
L_93868c:
	mov_s r32,r0
L_93868e:
	st.ab r0,[r25,0x4]
L_938692:
	bclr r25,r25,0xa
L_938696:
	b L_92029c
L_93869a:
	nop_s
