/* bi_ctrl__program_mac_bcon @ 0x933280, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 * Зовёт сам: __ld_r13_ret_uc
 * Глобалы (через gp): 0x8005a8, 0x8005ac
 */
	.section .text.bi_ctrl__program_mac_bcon,"ax",@progbits
	.global bi_ctrl__program_mac_bcon
bi_ctrl__program_mac_bcon:
	.global L_933280
L_933280:
	push_s blink
L_933282:
	push_s r13
L_933284:
	mov_s r3,0x80142c
L_93328a:
	ldb_s r0,[r3,0x5]
L_93328c:
	mov_s r2,0x1
L_93328e:
	cmp_s r0,0x0
L_933290:
	sub_s.ne r2,r2,r2
L_933292:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_933294:
	ldb_s r1,[r3,0x2]
L_933296:
	bset_s r2,r2,0x19
L_933298:
	ldb_s r0,[r3]
L_93329a:
	bset_s r2,r2,0x1b
L_93329c:
	bset_s r2,r2,0x1d
L_93329e:
	asl_s r1,r1,0xe
L_9332a0:
	or_s r1,r1,r2
L_9332a2:
	asl_s r0,r0,0xf
L_9332a4:
	or_s r1,r1,r0
L_9332a6:
	ld_s r0,[gp,0x80]
L_9332a8:
	ldb_s r13,[r3,0x1]
L_9332aa:
	or_s r0,r0,r1
L_9332ac:
	mov_s r32,r0
L_9332ae:
	st.ab r0,[r25,0x4]
L_9332b2:
	bclr r25,r25,0xa
L_9332b6:
	asl_s r13,r13,0xb
L_9332b8:
	ld_s r0,[gp,0x84]
L_9332ba:
	or r13,r13,0x2b000000
L_9332c2:
	or_s r0,r0,r13
L_9332c4:
	mov_s r32,r0
L_9332c6:
	st.ab r0,[r25,0x4]
L_9332ca:
	bclr r25,r25,0xa
L_9332ce:
	b L_92028c
L_9332d2:
	nop_s
