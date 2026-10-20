/* pcie__l1_sub_timing_setup @ 0x8ebc90, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__serdes_init
 * Зовёт сам: hwd_pcie_exit_l1, hwd_pcie_l1_sub_timing_config, pcie__fix_max_read_req
 */
	.section .text.pcie__l1_sub_timing_setup,"ax",@progbits
	.global pcie__l1_sub_timing_setup
pcie__l1_sub_timing_setup:
	.global L_8ebc90
L_8ebc90:
	push_s blink
L_8ebc92:
	bl.d L_8ce578
L_8ebc96:
	mov_s r0,0x1
L_8ebc98:
	bl L_8ceb80
L_8ebc9c:
	bl L_8ce9ac
L_8ebca0:
	bl.d L_8ce578
L_8ebca4:
	mov_s r0,0x0
L_8ebca6:
	pop_s blink
