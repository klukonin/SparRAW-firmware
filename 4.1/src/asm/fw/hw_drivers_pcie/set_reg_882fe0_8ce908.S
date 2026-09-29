/* set_reg_882fe0_8ce908 @ 0x8ce908, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_pcie_l1_exit_isr
 */
	.section .text.set_reg_882fe0_8ce908,"ax",@progbits
	.global set_reg_882fe0_8ce908
set_reg_882fe0_8ce908:
	.global L_8ce908
L_8ce908:
	mov_s r0,0x882f80
L_8ce90e:
	st 0x80000,[r0, 0x60]
L_8ce916:
	j_s [blink]
