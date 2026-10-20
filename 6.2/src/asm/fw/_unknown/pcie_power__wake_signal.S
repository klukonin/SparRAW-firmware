/* pcie_power__wake_signal @ 0x8ec05c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_wake_pcie_evt
 * Зовёт сам: pcie_device_power_if__pcie_power_wake_signal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_power__wake_signal
pcie_power__wake_signal:
	.global L_8ec05c
L_8ec05c:
	mov_s r0,0x803d10
L_8ec062:
	b L_8e05b4
L_8ec066:
	nop_s
