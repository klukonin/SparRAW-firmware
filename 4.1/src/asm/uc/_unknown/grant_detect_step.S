/* grant_detect_step @ 0x92a558, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry, rx_flow__grant_detected, ucode_cmd__rx_on, ucode_pm__rx_off_step
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, mac__program_rf_mode, uc_read_tsf_lo
 */
	.section .text.grant_detect_step,"ax",@progbits
	.global grant_detect_step
grant_detect_step:
	.global L_92a558
L_92a558:
	push_s blink
L_92a55a:
	bl L_92020c
L_92a55e:
	mov_s r13,r0
L_92a560:
	mov_s r14,r1
L_92a562:
	mov_s r16,r2
L_92a564:
	bl.d L_9315e8
L_92a568:
	mov_s r15,0x0
L_92a56a:
	mov_s r1,0x800994
L_92a570:
	ld_s r2,[r1]
L_92a572:
	bmsk r3,r2,0x1
L_92a576:
	add_s r0,r0,r13
L_92a578:
	brne r3,0x3,L_92a584
L_92a57c:
	ld_s r3,[r1,0x4]
L_92a57e:
	sub_s r0,r0,r3
L_92a580:
	bbit1 r0,0x1f,L_92a59c
	.global L_92a584
L_92a584:
	mov_s r15,0x1
L_92a586:
	bbit0 r2,0x0,L_92a59c
L_92a58a:
	bclr_s r2,r2,0x0
L_92a58c:
	st_s r2,[r1]
L_92a58e:
	mov r0,-0x1
L_92a592:
	st_s r0,[r1,0x8]
L_92a594:
	mov_s r0,0x0
L_92a596:
	st.as r0,[gp,-0x24]
L_92a59a:
	mov_s r14,r15
	.global L_92a59c
L_92a59c:
	cmp r16,0x0
L_92a5a0:
	cmp.ne r14,0x0
L_92a5a4:
	beq_s L_92a5d8
L_92a5a6:
	lr r13,[0xa]
L_92a5aa:
	bclr r0,r13,0x1
L_92a5ae:
	flag r0
L_92a5b2:
	ld_s r0,[gp,-0xd8]
L_92a5b4:
	ld_s r1,[r1,0x8]
L_92a5b6:
	and_s r0,r0,r1
L_92a5b8:
	bset_s r0,r0,0x1b
L_92a5ba:
	mov_s r32,r0
L_92a5bc:
	st.ab r0,[r25,0x4]
L_92a5c0:
	bclr r25,r25,0xa
L_92a5c4:
	bl.d L_9296c8
L_92a5c8:
	mov_s r0,0x1
L_92a5ca:
	lr r0,[0xa]
L_92a5ce:
	bic r13,r13,-0x3
L_92a5d2:
	or_s r13,r13,r0
L_92a5d4:
	flag r13
	.global L_92a5d8
L_92a5d8:
	brne_s r15,0,L_92a5e6
L_92a5da:
	mov_s r1,0x801458
L_92a5e0:
	ld_s r0,[r1,0x28]
L_92a5e2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92a5e4:
	st_s r0,[r1,0x28]
	.global L_92a5e6
L_92a5e6:
	b.d L_920274
L_92a5ea:
	mov_s r0,r15
