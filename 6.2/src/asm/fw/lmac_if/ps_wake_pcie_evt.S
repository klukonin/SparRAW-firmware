/* ps_wake_pcie_evt @ 0x8dc224, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: pcie_power__wake_signal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_wake_pcie_evt
ps_wake_pcie_evt:
	.global L_8dc224
L_8dc224:
	b L_8ec05c
