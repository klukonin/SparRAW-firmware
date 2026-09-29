/* cf_end__send_frame @ 0x933454, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cf_end__tx_flow
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, direct_tx__program_cmd34, mac__program_tx_with_rate, txop_tx_step
 * Глобалы (через gp): 0x800610, 0x800614
 */
	.section .text.cf_end__send_frame,"ax",@progbits
	.global cf_end__send_frame
cf_end__send_frame:
	.global L_933454
L_933454:
	push_s blink
L_933456:
	bl L_92020c
L_93345a:
	mov_s r13,r0
L_93345c:
	mov_s r14,r1
L_93345e:
	push_s r2
L_933460:
	mov_s r15,r3
L_933462:
	mov r16,r4
L_933466:
	mov_s r0,0x10
L_933468:
	bl.d L_924ea8
L_93346c:
	mov_s r1,r0
L_93346e:
	bl.d L_92a318
L_933472:
	mov_s r0,r14
L_933474:
	st r14,[r16]
	.global L_933478
L_933478:
	mov_s r0,r43
L_93347a:
	bbit0 r0,0x1f,L_933478
L_93347e:
	mov_s r0,r51
L_933480:
	bmsk r1,r0,0x3
L_933484:
	st.as r1,[gp,0x3a]
L_933488:
	lsr_s r0,r0,0x4
L_93348a:
	st.as r0,[gp,0x3b]
	.global L_93348e
L_93348e:
	mov_s r0,r45
L_933490:
	bbit0 r0,0x1f,L_93348e
L_933494:
	breq_s r15,0,L_9334a4
L_933496:
	mov_s r0,0x18
L_933498:
	asl_s r0,r0,0x18
L_93349a:
	mov_s r32,r0
L_93349c:
	st.ab r0,[r25,0x4]
L_9334a0:
	bclr r25,r25,0xa
	.global L_9334a4
L_9334a4:
	ld_s r0,[r13]
L_9334a6:
	ld_s r1,[sp,0x0]
L_9334a8:
	bl.d L_9332d4
L_9334ac:
	mov_s r2,0x0
L_9334ae:
	ld_s r1,[r13,0x14]
L_9334b0:
	extb r0,r45
L_9334b4:
	and_s r0,r0,r1
L_9334b6:
	cmp_s r0,0x0
L_9334b8:
	mov_s r0,0x1
L_9334ba:
	sub_s.ne r0,r0,r0
L_9334bc:
	b.d L_920274
L_9334c0:
	add_s sp,sp,0x4
L_9334c2:
	nop_s
