/* pcie_device_power_if__pcie_power_wake_signal @ 0x8dc4ec, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_if::pcie_power_wake_signal - send Wake signal to PCIE EP
 * Зовут его: tail_pcie_device_power_if__pcie_power_wake_signal
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, hwd_pcie__rgf_882b80
 * Глобалы (через gp): 0x800188
 */
	.section .text.pcie_device_power_if__pcie_power_wake_signal,"ax",@progbits
	.global pcie_device_power_if__pcie_power_wake_signal
pcie_device_power_if__pcie_power_wake_signal:
	.global L_8dc4ec
L_8dc4ec:
	push_s blink
L_8dc4ee:
	push_s r13
L_8dc4f0:
	ldb_s r0,[r0]
L_8dc4f2:
	cmp_s r0,0x3
L_8dc4f4:
	mov_s r0,0x1
L_8dc4f6:
	sub_s.ne r0,r0,r0
L_8dc4f8:
	extb.f 0x0,r0
L_8dc4fc:
	mov_s r13,0x1
L_8dc4fe:
	beq_s L_8dc51e
L_8dc500:
	ld_s r0,[gp,0x18]
L_8dc502:
	brne_s r0,0,L_8dc51e
L_8dc504:
	bl.d L_8ce560
L_8dc508:
	mov_s r0,r13
L_8dc50a:
	st.as r13,[gp,0x6]
L_8dc50e:
	mov_s r2,0x1002568
L_8dc514:
	mov_s r0,0xe
L_8dc516:
	bl.d L_8edfb0
L_8dc51a:
	mov_s r1,0x2
L_8dc51c:
	b_s L_8dc522
	.global L_8dc51e
L_8dc51e:
	st.as r13,[gp,-0x18]
	.global L_8dc522
L_8dc522:
	.byte 0x1d,0x06
