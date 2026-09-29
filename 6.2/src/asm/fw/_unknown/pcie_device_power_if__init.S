/* pcie_device_power_if__init @ 0x8d90d8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_if::init
 * Зовут его: power_mngr__init
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, pcie_device_power_sm__init
 * Глобалы (через gp): 0x800198
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_device_power_if__init
pcie_device_power_if__init:
	.global L_8d90d8
L_8d90d8:
	push_s blink
L_8d90da:
	push_s r13
L_8d90dc:
	mov_s r13,r0
L_8d90de:
	mov_s r1,0x10021d8
L_8d90e4:
	bl.d L_8dcba8
L_8d90e8:
	mov_s r0,0x2e
L_8d90ea:
	bl.d L_8d9100
L_8d90ee:
	mov_s r0,r13
L_8d90f0:
	mov_s r0,0x0
L_8d90f2:
	st.as r0,[gp,-0x1b]
L_8d90f6:
	b.d L_8c025c
L_8d90fa:
	st.as r0,[gp,0x5]
L_8d90fe:
	nop_s
