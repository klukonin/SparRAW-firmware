/* pcie__mask_l1_enter_irq @ 0x8d15a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter, hwd_pcie_l1_enter_isr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__mask_l1_enter_irq
pcie__mask_l1_enter_irq:
	.global L_8d15a4
L_8d15a4:
	mov_s r0,0x882f80
L_8d15aa:
	st 0x4000,[r0, 0x60]
L_8d15b2:
	j_s [blink]
