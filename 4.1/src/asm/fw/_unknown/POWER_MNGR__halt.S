/* POWER_MNGR__halt @ 0x8c73d4, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR::halt ucode took: %d usec
 * Зовут его: deep_sleep_enter
 * Зовёт сам: SDP__sdp_drive_value, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_read_timer, get_g_80035c, lmac_if__wait_ucode_ack_2, obj__get_field_0x424, power_halt__start_timer, power_halt_seq
 * Глобалы (через gp): 0x800324
 */
	.section .text.POWER_MNGR__halt,"ax",@progbits
	.global POWER_MNGR__halt
POWER_MNGR__halt:
	.global L_8c73d4
L_8c73d4:
	sub_s sp,sp,0x8
L_8c73d6:
	push_s blink
L_8c73d8:
	bl L_8c02c4
L_8c73dc:
	mov_s r14,r0
L_8c73de:
	ld_s r0,[gp,-0xac]
L_8c73e0:
	st_s r2,[sp,0x10]
L_8c73e2:
	cmp_s r0,0x1
L_8c73e4:
	st_s r1,[sp,0xc]
L_8c73e6:
	mov.eq r0,0x0
L_8c73ea:
	beq_s L_8c7458
L_8c73ec:
	bl L_8e4694
L_8c73f0:
	bl L_8ca008
L_8c73f4:
	mov_s r13,r0
L_8c73f6:
	mov_s r0,0x1
L_8c73f8:
	st.as r0,[gp,-0x2b]
L_8c73fc:
	ld_s r0,[r13]
L_8c73fe:
	bbit0 r0,0x2,L_8c7410
L_8c7402:
	mov_s r0,0x803e84
L_8c7408:
	bl L_8c9f98
L_8c740c:
	st.as r0,[gp,0x6d]
	.global L_8c7410
L_8c7410:
	bl L_8e46c8
L_8c7414:
	breq_s r14,0,L_8c743c
L_8c7416:
	bl L_8e4694
L_8c741a:
	bl.d L_8d8004
L_8c741e:
	mov_s r14,r0
L_8c7420:
	bl L_8e4694
L_8c7424:
	sub_s r0,r0,r14
L_8c7426:
	asl_s r3,r0,0x4
L_8c7428:
	cmp r3,0x3e8
L_8c742c:
	bls_s L_8c743c
L_8c742e:
	mov_s r2,0x1001e90
L_8c7434:
	mov_s r0,0xe
L_8c7436:
	bl.d L_8edfcc
L_8c743a:
	mov_s r1,0x0
	.global L_8c743c
L_8c743c:
	mov_s r0,0x1
L_8c743e:
	bl.d L_8dfe00
L_8c7442:
	mov_s r1,0x7
L_8c7444:
	ld r4,[sp, 0x10]
L_8c7448:
	mov_s r0,0x1
L_8c744a:
	ld.as r2,[gp,-0x27]
L_8c744e:
	mov_s r1,r13
L_8c7450:
	bl.d L_8d4e10
L_8c7454:
	ld_s r3,[sp,0xc]
L_8c7456:
	mov_s r0,0x1
	.global L_8c7458
L_8c7458:
	mov_s r12,0xc
L_8c745a:
	b L_8c0336
L_8c745e:
	nop_s
