/* hwd_pcie_l1_sub_timing_config @ 0x8d169c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_pcie_l1_sub_timing_config: pcie_l1_sub_timing_reg: l12_entry=0x%x, l12=0x%x, mac_phy_pclk_max_delay=0x%x
 *   hwd_pcie_l1_sub_timing_config:: EP under SWITCH Not supported yet!!!
 * Зовут его: pcie__l1_latency_wa, pcie_serdes__init_seq
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, dbi_write, fw_log_emit0, fw_log_emit3, hwd_pcie__is_ep_under_serdes, pcie__bits_set32_s2_w4, pcie__dbi_read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie_l1_sub_timing_config
hwd_pcie_l1_sub_timing_config:
	.global L_8d169c
L_8d169c:
	push_s blink
L_8d169e:
	bl L_8c01e4
L_8d16a2:
	bl.d L_8d1470
L_8d16a6:
	sub_s sp,sp,0x8
L_8d16a8:
	breq_s r0,0,L_8d170c
L_8d16aa:
	add_s r14,sp,0x4
L_8d16ac:
	mov_s r0,0xb44
L_8d16b2:
	mov_s r13,0x0
L_8d16b4:
	mov_s r1,r13
L_8d16b6:
	mov_s r2,0x1
L_8d16b8:
	mov_s r3,r13
L_8d16ba:
	mov_s r4,r13
L_8d16bc:
	mov r5,0x1
L_8d16c0:
	bl.d L_8c8208
L_8d16c4:
	mov_s r6,r14
L_8d16c6:
	mov_s r1,0xf
L_8d16c8:
	mov_s r0,r14
L_8d16ca:
	bl.d L_8ed4d8
L_8d16ce:
	mov_s r2,r13
L_8d16d0:
	st_s r13,[sp,0x0]
L_8d16d2:
	mov_s r0,0xb44
L_8d16d8:
	ld_s r1,[sp,0x4]
L_8d16da:
	mov_s r3,0x1
L_8d16dc:
	mov_s r4,r13
L_8d16de:
	mov_s r5,r13
L_8d16e0:
	mov r6,0x1
L_8d16e4:
	bl.d L_8c8338
L_8d16e8:
	mov r7,0x1
L_8d16ec:
	ld_s r2,[sp,0x4]
L_8d16ee:
	mov_s r1,0x101df9c
L_8d16f4:
	lsr r3,r2,0x2
L_8d16f8:
	lsr r13,r2,0x6
L_8d16fc:
	mov_s r0,0x20
L_8d16fe:
	bmsk_s r2,r2,0x1
L_8d1700:
	bmsk_s r3,r3,0x3
L_8d1702:
	bl.d L_8dcd00
L_8d1706:
	bmsk r4,r13,0x1
L_8d170a:
	b_s L_8d1718
	.global L_8d170c
L_8d170c:
	mov_s r1,0x101e00c
L_8d1712:
	bl.d L_8dcba8
L_8d1716:
	mov_s r0,0x1
	.global L_8d1718
L_8d1718:
	b.d L_8c0254
L_8d171c:
	add_s sp,sp,0x8
L_8d171e:
	nop_s
