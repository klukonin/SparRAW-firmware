/* bi_ctrl__program_mac_bcon @ 0x9381c4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow
 * Зовёт сам: __ld_r13_to_r13_ret
 * Глобалы (через gp): 0x8005a0, 0x8005a4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_ctrl__program_mac_bcon
bi_ctrl__program_mac_bcon:
	.global L_9381c4
L_9381c4:
	push_s blink
L_9381c6:
	push_s r13
L_9381c8:
	mov_s r3,0x80229c
L_9381ce:
	ldb_s r0,[r3,0x5]
L_9381d0:
	mov_s r2,0x1
L_9381d2:
	cmp_s r0,0x0
L_9381d4:
	sub_s.ne r2,r2,r2
L_9381d6:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_9381d8:
	ldb_s r1,[r3,0x2]
L_9381da:
	bset_s r2,r2,0x19
L_9381dc:
	ldb_s r0,[r3]
L_9381de:
	bset_s r2,r2,0x1b
L_9381e0:
	bset_s r2,r2,0x1d
L_9381e2:
	asl_s r1,r1,0xe
L_9381e4:
	or_s r1,r1,r2
L_9381e6:
	asl_s r0,r0,0xf
L_9381e8:
	or_s r1,r1,r0
L_9381ea:
	ld_s r0,[gp,0x78]
L_9381ec:
	ldb_s r13,[r3,0x1]
L_9381ee:
	or_s r0,r0,r1
L_9381f0:
	mov_s r32,r0
L_9381f2:
	st.ab r0,[r25,0x4]
L_9381f6:
	bclr r25,r25,0xa
L_9381fa:
	asl_s r13,r13,0xb
L_9381fc:
	ld_s r0,[gp,0x7c]
L_9381fe:
	or r13,r13,0x2b000000
L_938206:
	or_s r0,r0,r13
L_938208:
	mov_s r32,r0
L_93820a:
	st.ab r0,[r25,0x4]
L_93820e:
	bclr r25,r25,0xa
L_938212:
	b L_9202ac
L_938216:
	nop_s
