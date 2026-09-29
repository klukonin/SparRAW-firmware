/* pcie_device_power_if__pcie_power_pcie_interrupt @ 0x8e0470, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_if::pcie_power_pcie_interrupt - send Wake signal to PCIE EP
 * Зовут его: fw_vector_16
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, fw_sysassert_fatal, hwd_pcie__rgf_882b80
 * Глобалы (через gp): 0x800198
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_device_power_if__pcie_power_pcie_interrupt
pcie_device_power_if__pcie_power_pcie_interrupt:
	.global L_8e0470
L_8e0470:
	mov_s r1,r0
L_8e0472:
	mov_s r0,0x803d10
L_8e0478:
	b L_8e047c
	.global L_8e047c
L_8e047c:
	/* sub_s r1,r1,0x5 */
	.byte 0x65,0xb9
L_8e047e:
	push_s blink
L_8e0480:
	brhs.d r1,0x5,L_8e04d6
L_8e0484:
	push_s r13
L_8e0486:
	ldb.x r1,[0x801be4,r1]
L_8e048e:
	add r2,pcl,0xa
L_8e0492:
	add1_s r2,r2,r1
L_8e0494:
	j_s [r2]
L_8e0496:
	mov_s r1,0x3
	.global L_8e0498
L_8e0498:
	mov_s r2,0x0
L_8e049a:
	mov_s r3,r2
L_8e049c:
	bl.d L_8d9b6c
L_8e04a0:
	mov_s r4,r2
L_8e04a2:
	b_s L_8e04e2
L_8e04a4:
	mov_s r1,0x2
L_8e04a6:
	mov_s r2,0x0
L_8e04a8:
	mov_s r3,r2
L_8e04aa:
	bl.d L_8d9b6c
L_8e04ae:
	mov_s r4,r2
L_8e04b0:
	ld_s r0,[gp,-0x6c]
L_8e04b2:
	breq_s r0,0,L_8e04e2
L_8e04b4:
	mov_s r13,0x1
L_8e04b6:
	bl.d L_8d1294
L_8e04ba:
	mov_s r0,r13
L_8e04bc:
	st.as r13,[gp,0x5]
L_8e04c0:
	mov_s r1,0x10022cc
L_8e04c6:
	bl.d L_8dcba8
L_8e04ca:
	mov_s r0,0x2e
L_8e04cc:
	b_s L_8e04e2
L_8e04ce:
	mov_s r1,0x1
L_8e04d0:
	b_s L_8e0498
L_8e04d2:
	mov_s r1,0x4
L_8e04d4:
	b_s L_8e0498
	.global L_8e04d6
L_8e04d6:
	mov_s r0,blink
L_8e04d8:
	mov_s r1,0x1445
L_8e04de:
	bl L_8c9b28
	.global L_8e04e2
L_8e04e2:
	b L_8c025c
L_8e04e6:
	nop_s
