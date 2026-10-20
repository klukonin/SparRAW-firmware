/* hwd_pcie_l1_sub_timing_config @ 0x8ce9ac, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_l1_sub_timing_config: pcie_l1_sub_timing_reg: l12_entry=0x%x, l12=0x%x, mac_phy_pclk_max_delay=0x%x
 *   hwd_pcie_l1_sub_timing_config:: EP under SWITCH Not supported yet!!!
 * Зовут его: pcie__l1_latency_wa, pcie__l1_sub_timing_setup
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf_w_s2_w4, fw_log__emit0, fw_log__emit3, get_reg8825bc_bit3_inv, hwd_pcie_dbi_write, pcie_serdes_step
 */
	.section .text.hwd_pcie_l1_sub_timing_config,"ax",@progbits
	.global hwd_pcie_l1_sub_timing_config
hwd_pcie_l1_sub_timing_config:
	.global L_8ce9ac
L_8ce9ac:
	push_s blink
L_8ce9ae:
	bl L_8c02bc
L_8ce9b2:
	bl.d L_8ce774
L_8ce9b6:
	sub_s sp,sp,0x8
L_8ce9b8:
	mov_s r13,0x0
L_8ce9ba:
	breq_s r0,0,L_8cea24
L_8ce9bc:
	add r16,sp,0x4
L_8ce9c0:
	mov_s r0,0xb44
L_8ce9c6:
	mov_s r1,r13
L_8ce9c8:
	mov_s r2,0x1
L_8ce9ca:
	mov_s r3,r13
L_8ce9cc:
	mov_s r4,r13
L_8ce9ce:
	mov r5,0x1
L_8ce9d2:
	bl.d L_8eaa64
L_8ce9d6:
	mov r6,r16
L_8ce9da:
	mov_s r1,0xf
L_8ce9dc:
	mov_s r0,r16
L_8ce9de:
	bl.d L_8e84b0
L_8ce9e2:
	mov_s r2,r13
L_8ce9e4:
	st_s r13,[sp,0x0]
L_8ce9e6:
	mov_s r0,0xb44
L_8ce9ec:
	ld_s r1,[sp,0x4]
L_8ce9ee:
	mov_s r3,0x1
L_8ce9f0:
	mov_s r4,r13
L_8ce9f2:
	mov_s r5,r13
L_8ce9f4:
	mov r6,0x1
L_8ce9f8:
	bl.d L_8eab94
L_8ce9fc:
	mov r7,0x1
L_8cea00:
	ld_s r3,[sp,0x4]
L_8cea02:
	mov_s r2,0x1018dec
L_8cea08:
	lsr r14,r3,0x2
L_8cea0c:
	lsr r15,r3,0x6
L_8cea10:
	mov_s r0,r13
L_8cea12:
	mov_s r1,0x2
L_8cea14:
	bmsk_s r3,r3,0x1
L_8cea16:
	bmsk r4,r14,0x3
L_8cea1a:
	bl.d L_8ee034
L_8cea1e:
	bmsk r5,r15,0x1
L_8cea22:
	b_s L_8cea32
	.global L_8cea24
L_8cea24:
	mov_s r2,0x1018e5c
L_8cea2a:
	mov_s r0,0x1
L_8cea2c:
	bl.d L_8edfb0
L_8cea30:
	mov_s r1,r13
	.global L_8cea32
L_8cea32:
	b.d L_8c0324
L_8cea36:
	add_s sp,sp,0x8
