/* isr16__pcie_l1_latency_wa @ 0x8f173c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 * Зовёт сам: pcie__l1_latency_wa
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global isr16__pcie_l1_latency_wa
isr16__pcie_l1_latency_wa:
	.global L_8f173c
L_8f173c:
	b L_8ed7b4
