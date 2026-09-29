/* pcie_dbg__rearm_irq_bit3 @ 0x8fa874, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__copy_ie_max96, wbe_driver__pcie_debug_isr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_dbg__rearm_irq_bit3
pcie_dbg__rearm_irq_bit3:
	.global L_8fa874
L_8fa874:
	mov_s r1,0x8
L_8fa876:
	mov_s r0,0x882680
L_8fa87c:
	st_s r1,[r0,0xc]
L_8fa87e:
	st_s r1,[r0,0x20]
L_8fa880:
	j_s [blink]
L_8fa882:
	nop_s
