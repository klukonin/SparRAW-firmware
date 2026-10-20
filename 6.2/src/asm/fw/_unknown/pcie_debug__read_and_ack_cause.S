/* pcie_debug__read_and_ack_cause @ 0x8d11b8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_15
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_debug__read_and_ack_cause
pcie_debug__read_and_ack_cause:
	.global L_8d11b8
L_8d11b8:
	mov_s r1,0x882680
L_8d11be:
	ld_s r0,[r1,0x10]
L_8d11c0:
	st_s r0,[r1,0xc]
L_8d11c2:
	j_s [blink]
