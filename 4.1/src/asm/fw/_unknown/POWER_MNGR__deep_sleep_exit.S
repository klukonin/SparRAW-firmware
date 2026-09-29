/* POWER_MNGR__deep_sleep_exit @ 0x8c7460, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR::deep_sleep_exit trigger=%d
 * Зовут его: POWER_MNGR__system_state_evt_handler, isr_880b50__dispatch_causes, isr_pcie_ltssm_dbg, isr_pcie_main, isr_ucode_fault
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, get_g_80035c, obj__get_field_0x424, phy__program_channel_regs, power_deep_sleep_exit_step, rf__apply_tx_power, u_schd__add
 */
	.section .text.POWER_MNGR__deep_sleep_exit,"ax",@progbits
	.global POWER_MNGR__deep_sleep_exit
POWER_MNGR__deep_sleep_exit:
	.global L_8c7460
L_8c7460:
	push_s blink
L_8c7462:
	bl L_8c02c4
L_8c7466:
	bl.d L_8ca008
L_8c746a:
	mov_s r14,r0
L_8c746c:
	mov_s r13,r0
L_8c746e:
	ld_s r0,[r0]
L_8c7470:
	lsr_s r0,r0,0xb
L_8c7472:
	bl.d L_8c74cc
L_8c7476:
	bmsk_s r0,r0,0x0
L_8c7478:
	breq_s r0,0,L_8c74b8
L_8c747a:
	ld_s r0,[r13,0x4]
L_8c747c:
	bbit0 r0,0x0,L_8c7494
L_8c7480:
	bl.d L_8de0d8
L_8c7484:
	mov_s r0,0x1
L_8c7486:
	mov_s r0,0x803e84
L_8c748c:
	bl L_8c9f98
L_8c7490:
	bl L_8cf83c
	.global L_8c7494
L_8c7494:
	mov_s r1,0x803590
L_8c749a:
	ld_s r0,[r1,0x30]
L_8c749c:
	mov_s r2,0x1002098
L_8c74a2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c74a4:
	st_s r0,[r1,0x30]
L_8c74a6:
	mov_s r0,0xe
L_8c74a8:
	mov_s r1,0x2
L_8c74aa:
	bl.d L_8edfcc
L_8c74ae:
	mov_s r3,r14
L_8c74b0:
	mov_s r0,0x1d4d0
L_8c74b6:
	b_s L_8c74be
	.global L_8c74b8
L_8c74b8:
	mov_s r0,0x1d458
	.global L_8c74be
L_8c74be:
	mov_s r1,0x0
L_8c74c0:
	mov_s r2,r1
L_8c74c2:
	bl.d L_8c2ac8
L_8c74c6:
	mov_s r3,0x2
L_8c74c8:
	b L_8c0334
