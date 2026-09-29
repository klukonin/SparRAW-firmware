/* pcie_device_power_if__pcie_power_pcie_interrupt @ 0x8dc3a4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_if::pcie_power_pcie_interrupt - send Wake signal to PCIE EP
 *   pcie_device_power_if.cpp
 * Зовут его: isr_pcie_main
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, fw_sysassert_fatal, hwd_pcie__rgf_882b80
 * Глобалы (через gp): 0x800188
 */
	.section .text.pcie_device_power_if__pcie_power_pcie_interrupt,"ax",@progbits
	.global pcie_device_power_if__pcie_power_pcie_interrupt
pcie_device_power_if__pcie_power_pcie_interrupt:
	.global L_8dc3a4
L_8dc3a4:
	mov_s r1,r0
L_8dc3a6:
	mov_s r0,0x803510
L_8dc3ac:
	b L_8dc3b0
	.global L_8dc3b0
L_8dc3b0:
	/* sub_s r1,r1,0x5 */
	.byte 0x65,0xb9
L_8dc3b2:
	push_s blink
L_8dc3b4:
	brhs.d r1,0x5,L_8dc40c
L_8dc3b8:
	push_s r13
L_8dc3ba:
	ldb.x r1,[0x8018c8,r1]
L_8dc3c2:
	add r2,pcl,0xa
L_8dc3c6:
	add1_s r2,r2,r1
L_8dc3c8:
	j_s [r2]
L_8dc3ca:
	mov_s r1,0x3
	.global L_8dc3cc
L_8dc3cc:
	mov_s r2,0x0
L_8dc3ce:
	mov_s r3,r2
L_8dc3d0:
	bl.d L_8d6a1c
L_8dc3d4:
	mov_s r4,r2
L_8dc3d6:
	b_s L_8dc420
L_8dc3d8:
	mov_s r1,0x2
L_8dc3da:
	mov_s r2,0x0
L_8dc3dc:
	mov_s r3,r2
L_8dc3de:
	bl.d L_8d6a1c
L_8dc3e2:
	mov_s r4,r2
L_8dc3e4:
	ld_s r0,[gp,-0x60]
L_8dc3e6:
	breq_s r0,0,L_8dc420
L_8dc3e8:
	mov_s r13,0x1
L_8dc3ea:
	bl.d L_8ce560
L_8dc3ee:
	mov_s r0,r13
L_8dc3f0:
	st.as r13,[gp,0x6]
L_8dc3f4:
	mov_s r2,0x10025b4
L_8dc3fa:
	mov_s r0,0xe
L_8dc3fc:
	bl.d L_8edfb0
L_8dc400:
	mov_s r1,0x2
L_8dc402:
	b_s L_8dc420
L_8dc404:
	mov_s r1,0x1
L_8dc406:
	b_s L_8dc3cc
L_8dc408:
	mov_s r1,0x4
L_8dc40a:
	b_s L_8dc3cc
	.global L_8dc40c
L_8dc40c:
	mov_s r0,blink
L_8dc40e:
	mov_s r2,0x1002604
L_8dc414:
	mov_s r1,0x1445
L_8dc41a:
	bl.d L_8c82c0
L_8dc41e:
	mov_s r3,0x72
	.global L_8dc420
L_8dc420:
	b L_8c033c
