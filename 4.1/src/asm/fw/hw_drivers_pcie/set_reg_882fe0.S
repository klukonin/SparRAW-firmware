/* set_reg_882fe0 @ 0x8ce8ac, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, hwd_pcie_l1_enter_isr
 */
	.section .text.set_reg_882fe0,"ax",@progbits
	.global set_reg_882fe0
set_reg_882fe0:
	.global L_8ce8ac
L_8ce8ac:
	mov_s r0,0x882f80
L_8ce8b2:
	st 0x4000,[r0, 0x60]
L_8ce8ba:
	j_s [blink]
