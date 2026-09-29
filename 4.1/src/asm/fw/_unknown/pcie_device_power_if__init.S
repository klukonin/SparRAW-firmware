/* pcie_device_power_if__init @ 0x8d6028, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcie_device_power_if::init
 * Зовут его: POWER_MNGR__init
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, pcie_device_power_sm__init
 * Глобалы (через gp): 0x800188
 */
	.section .text.pcie_device_power_if__init,"ax",@progbits
	.global pcie_device_power_if__init
pcie_device_power_if__init:
	.global L_8d6028
L_8d6028:
	push_s blink
L_8d602a:
	push_s r13
L_8d602c:
	mov_s r13,r0
L_8d602e:
	mov_s r2,0x10024c0
L_8d6034:
	mov_s r0,0xe
L_8d6036:
	bl.d L_8edfb0
L_8d603a:
	mov_s r1,0x2
L_8d603c:
	bl.d L_8d6050
L_8d6040:
	mov_s r0,r13
L_8d6042:
	mov_s r0,0x0
L_8d6044:
	st.as r0,[gp,-0x18]
L_8d6048:
	b.d L_8c033c
L_8d604c:
	st.as r0,[gp,0x6]
