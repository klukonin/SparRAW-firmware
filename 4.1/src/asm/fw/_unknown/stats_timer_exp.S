/* stats_timer_exp @ 0x8dc190, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stats_timer_exp:: L1 WA: %d Took %d usec
 * Зовут его: POWER_MNGR__system_state_evt_handler, link_stats__report
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, fw_read_timer, get_reg_881c84, hwd_pcie__toggle_882f80_bits, pcie__l1_dwell_stats
 * Глобалы (через gp): 0x8003f4, 0x8003f8
 */
	.section .text.stats_timer_exp,"ax",@progbits
	.global stats_timer_exp
stats_timer_exp:
	.global L_8dc190
L_8dc190:
	push_s blink
L_8dc192:
	bl L_8c02c4
L_8dc196:
	mov_s r14,r0
L_8dc198:
	mov_s r0,0x11
L_8dc19a:
	asl_s r0,r0,0x13
L_8dc19c:
	ld_s r13,[r0,0x1c]
L_8dc19e:
	bbit0 r13,0x3,L_8dc25e
L_8dc1a2:
	ld_s r0,[gp,0x288]
L_8dc1a4:
	breq r0,0x0,L_8dc25e
L_8dc1a8:
	bl L_8cd9e0
L_8dc1ac:
	ld.as r1,[gp,0xa1]
L_8dc1b0:
	breq_s r0,0,L_8dc200
L_8dc1b2:
	brne_s r14,0,L_8dc200
L_8dc1b4:
	brne r1,0x0,L_8dc25e
L_8dc1b8:
	bl L_8e4694
L_8dc1bc:
	btst_s r13,0x8
L_8dc1be:
	mov_s r14,r0
L_8dc1c0:
	btst.eq r13,0x7
L_8dc1c4:
	btst.eq r13,0x6
L_8dc1c8:
	btst.eq r13,0x5
L_8dc1cc:
	beq_s L_8dc1da
L_8dc1ce:
	mov_s r0,0x0
L_8dc1d0:
	mov_s r1,r0
L_8dc1d2:
	mov_s r2,r0
L_8dc1d4:
	bl.d L_8ce044
L_8dc1d8:
	mov_s r3,r0
	.global L_8dc1da
L_8dc1da:
	bl.d L_8ce85c
L_8dc1de:
	mov_s r0,0x0
L_8dc1e0:
	mov_s r0,0x1
L_8dc1e2:
	bl.d L_8e4694
L_8dc1e6:
	st.as r0,[gp,0xa1]
L_8dc1ea:
	sub_s r0,r0,r14
L_8dc1ec:
	asl r4,r0,0x4
L_8dc1f0:
	mov_s r2,0x1003b18
L_8dc1f6:
	ld.as r3,[gp,0xa1]
L_8dc1fa:
	mov_s r0,0xe
L_8dc1fc:
	mov_s r1,0x2
L_8dc1fe:
	b_s L_8dc25a
	.global L_8dc200
L_8dc200:
	brne r1,0x1,L_8dc25e
L_8dc204:
	bl L_8e4694
L_8dc208:
	mov_s r14,r0
L_8dc20a:
	bl.d L_8ce85c
L_8dc20e:
	mov_s r0,0x1
L_8dc210:
	btst_s r13,0x8
L_8dc212:
	btst.eq r13,0x7
L_8dc216:
	btst.eq r13,0x6
L_8dc21a:
	btst.eq r13,0x5
L_8dc21e:
	beq_s L_8dc23c
L_8dc220:
	lsr r0,r13,0x8
L_8dc224:
	lsr r1,r13,0x7
L_8dc228:
	lsr r2,r13,0x6
L_8dc22c:
	lsr r3,r13,0x5
L_8dc230:
	bmsk_s r0,r0,0x0
L_8dc232:
	bmsk_s r1,r1,0x0
L_8dc234:
	bmsk_s r2,r2,0x0
L_8dc236:
	bl.d L_8ce044
L_8dc23a:
	bmsk_s r3,r3,0x0
	.global L_8dc23c
L_8dc23c:
	mov_s r0,0x0
L_8dc23e:
	bl.d L_8e4694
L_8dc242:
	st.as r0,[gp,0xa1]
L_8dc246:
	sub_s r0,r0,r14
L_8dc248:
	asl_s r13,r0,0x4
L_8dc24a:
	mov_s r2,0x1003b18
L_8dc250:
	ld.as r3,[gp,0xa1]
L_8dc254:
	mov_s r0,0xe
L_8dc256:
	mov_s r1,0x2
L_8dc258:
	mov_s r4,r13
	.global L_8dc25a
L_8dc25a:
	bl L_8edff8
	.global L_8dc25e
L_8dc25e:
	b L_8c0334
L_8dc262:
	nop_s
