/* POWER_MNGR__halt @ 0x8c89a0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR::halt ucode took: %d usec
 * Зовут его: deep_sleep_enter
 * Зовёт сам: SDP__sdp_drive_value, __ld_r14_to_r13_ret, __st_r14_to_r13, fw2uc__signal_halt_and_wait_ack, fw_log_emit1, hw_cfg__get_8004fc_bit0, power_halt__start_timer, power_halt_seq, power_mngr__read_g800380, radio__get_channel, u_schd__now
 * Глобалы (через gp): 0x800334
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global POWER_MNGR__halt
POWER_MNGR__halt:
	.global L_8c89a0
L_8c89a0:
	sub_s sp,sp,0x8
L_8c89a2:
	push_s blink
L_8c89a4:
	bl L_8c01e4
L_8c89a8:
	mov_s r14,r0
L_8c89aa:
	ld_s r0,[gp,-0xbc]
L_8c89ac:
	st_s r2,[sp,0x10]
L_8c89ae:
	cmp_s r0,0x1
L_8c89b0:
	st_s r1,[sp,0xc]
L_8c89b2:
	mov.eq r0,0x0
L_8c89b6:
	beq_s L_8c8a2c
L_8c89b8:
	bl L_8e9524
L_8c89bc:
	bl L_8cc1fc
L_8c89c0:
	mov_s r13,r0
L_8c89c2:
	mov_s r0,0x1
L_8c89c4:
	st.as r0,[gp,-0x2f]
L_8c89c8:
	ld_s r0,[r13]
L_8c89ca:
	bbit0 r0,0x2,L_8c89dc
L_8c89ce:
	mov_s r0,0x8042c8
L_8c89d4:
	bl L_8cc13c
L_8c89d8:
	st.as r0,[gp,0x6c]
	.global L_8c89dc
L_8c89dc:
	bl L_8e9558
L_8c89e0:
	breq_s r14,0,L_8c8a06
L_8c89e2:
	bl L_8e9524
L_8c89e6:
	bl.d L_8db148
L_8c89ea:
	mov_s r14,r0
L_8c89ec:
	bl L_8e9524
L_8c89f0:
	sub_s r0,r0,r14
L_8c89f2:
	asl_s r2,r0,0x4
L_8c89f4:
	cmp r2,0x3e8
L_8c89f8:
	bls_s L_8c8a06
L_8c89fa:
	mov_s r1,0x1001e2c
L_8c8a00:
	bl.d L_8dcc10
L_8c8a04:
	mov_s r0,0xe
	.global L_8c8a06
L_8c8a06:
	bl L_8ce1a8
L_8c8a0a:
	cmp_s r0,0x0
L_8c8a0c:
	mov.ne r0,0x1
L_8c8a10:
	bl.ne.d L_8e4abc
L_8c8a14:
	mov.ne r1,0x7
L_8c8a18:
	ld r4,[sp, 0x10]
L_8c8a1c:
	mov_s r0,0x1
L_8c8a1e:
	ld.as r2,[gp,-0x2b]
L_8c8a22:
	mov_s r1,r13
L_8c8a24:
	bl.d L_8d78cc
L_8c8a28:
	ld_s r3,[sp,0xc]
L_8c8a2a:
	mov_s r0,0x1
	.global L_8c8a2c
L_8c8a2c:
	mov_s r12,0xc
L_8c8a2e:
	b L_8c0256
L_8c8a32:
	nop_s
