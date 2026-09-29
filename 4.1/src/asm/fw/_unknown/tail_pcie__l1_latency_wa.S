/* tail_pcie__l1_latency_wa @ 0x8ea124, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 * Зовёт сам: pcie__l1_latency_wa
 */
	.section .text.tail_pcie__l1_latency_wa,"ax",@progbits
	.global tail_pcie__l1_latency_wa
tail_pcie__l1_latency_wa:
	.global L_8ea124
L_8ea124:
	b L_8e8648
