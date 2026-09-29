/* direct_tx__send_after_delay @ 0x938218, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__send_frame, internal_tx__flow_sm2, internal_tx__flow_sm6, tx__write_header_16, tx_bcast_flow, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, direct_tx__issue_cmd_33, uc_wait_direct_tx_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__send_after_delay
direct_tx__send_after_delay:
	.global L_938218
L_938218:
	push_s blink
L_93821a:
	/* bl.d 0x00920234 */
	.byte 0x1e,0x08,0x2f,0xf4
L_93821e:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_938220:
	bset r3,r1,0x2
L_938224:
	asl r1,r2,0x8
L_938228:
	or r33,r1,r3
L_93822c:
	ld.as r3,[gp,-0x5]
L_938230:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_938232:
	sub_s r1,r3,0x4
L_938234:
	st.as r1,[gp,-0x5]
L_938238:
	add2_s r0,r0,r0
L_93823a:
	add r13,r0,0x801104
L_938242:
	mov_s r1,0x33000443
L_938248:
	add r14,r13,0x30
L_93824c:
	brne r2,0x5,L_938280
L_938250:
	sub_s r3,r3,0xa
L_938252:
	st.as r3,[gp,-0x5]
L_938256:
	mov_s r32,r1
L_938258:
	st.ab r1,[r25,0x4]
L_93825c:
	bclr r25,r25,0xa
L_938260:
	bl L_925874
L_938264:
	ldw_s r0,[r13,0x30]
L_938266:
	bset r34,r0,0x18
L_93826a:
	ldw_s r0,[r14,0x2]
L_93826c:
	bset r34,r0,0x18
L_938270:
	ldw_s r0,[r14,0x4]
L_938272:
	bset r34,r0,0x18
L_938276:
	ld_s r0,[gp,-0x14]
L_938278:
	/* sub_s r0,r0,0x6 */
	.byte 0x66,0xb8
L_93827a:
	st.as r0,[gp,-0x5]
L_93827e:
	b_s L_9382a4
	.global L_938280
L_938280:
	ldw_s r0,[r13,0x30]
L_938282:
	bset r34,r0,0x18
L_938286:
	ldw_s r0,[r14,0x2]
L_938288:
	bset r34,r0,0x18
L_93828c:
	ldw_s r0,[r14,0x4]
L_93828e:
	bset r34,r0,0x18
L_938292:
	ld_s r0,[gp,-0x14]
L_938294:
	sub_s r0,r0,0xc
L_938296:
	st.as r0,[gp,-0x5]
L_93829a:
	mov_s r32,r1
L_93829c:
	st.ab r1,[r25,0x4]
L_9382a0:
	bclr r25,r25,0xa
	.global L_9382a4
L_9382a4:
	bl L_925874
L_9382a8:
	bl L_925774
L_9382ac:
	b L_9202a4
