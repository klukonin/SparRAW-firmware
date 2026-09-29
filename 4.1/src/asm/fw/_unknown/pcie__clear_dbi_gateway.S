/* pcie__clear_dbi_gateway @ 0x8ea418, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Clearing DBI gateway
 * Зовут его: isr_pcie_main
 * Зовёт сам: fw_log__emit0, set_reg_882648
 */
	.section .text.pcie__clear_dbi_gateway,"ax",@progbits
	.global pcie__clear_dbi_gateway
pcie__clear_dbi_gateway:
	.global L_8ea418
L_8ea418:
	push_s blink
L_8ea41a:
	mov_s r2,0x1001684
L_8ea420:
	mov_s r0,0x0
L_8ea422:
	bl.d L_8edfb0
L_8ea426:
	mov_s r1,0x2
L_8ea428:
	bl L_8ce748
L_8ea42c:
	pop_s blink
L_8ea42e:
	j_s [blink]
