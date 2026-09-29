/* pcie_device_power_if__pcie_power_wake_signal @ 0x8e05b4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_if::pcie_power_wake_signal - send Wake signal to PCIE EP
 * Зовут его: pcie_power__wake_signal
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, hwd_pcie__rgf_882b80
 * Глобалы (через gp): 0x800198
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_device_power_if__pcie_power_wake_signal
pcie_device_power_if__pcie_power_wake_signal:
	.global L_8e05b4
L_8e05b4:
	push_s blink
L_8e05b6:
	push_s r13
L_8e05b8:
	ldb_s r0,[r0]
L_8e05ba:
	cmp_s r0,0x3
L_8e05bc:
	mov_s r0,0x1
L_8e05be:
	sub_s.ne r0,r0,r0
L_8e05c0:
	extb.f 0x0,r0
L_8e05c4:
	mov_s r13,0x1
L_8e05c6:
	beq_s L_8e05e4
L_8e05c8:
	ld_s r0,[gp,0x14]
L_8e05ca:
	brne_s r0,0,L_8e05e4
L_8e05cc:
	bl.d L_8d1294
L_8e05d0:
	mov_s r0,r13
L_8e05d2:
	st.as r13,[gp,0x5]
L_8e05d6:
	mov_s r1,0x1002280
L_8e05dc:
	bl.d L_8dcba8
L_8e05e0:
	mov_s r0,0x2e
L_8e05e2:
	b_s L_8e05e8
	.global L_8e05e4
L_8e05e4:
	st.as r13,[gp,-0x1b]
	.global L_8e05e8
L_8e05e8:
	b L_8c025c
