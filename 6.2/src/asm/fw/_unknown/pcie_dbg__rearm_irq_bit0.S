/* pcie_dbg__rearm_irq_bit0 @ 0x8fa864, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__copy_ie_max96
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_dbg__rearm_irq_bit0
pcie_dbg__rearm_irq_bit0:
	.global L_8fa864
L_8fa864:
	mov_s r1,0x1
L_8fa866:
	mov_s r0,0x882680
L_8fa86c:
	st_s r1,[r0,0xc]
L_8fa86e:
	st_s r1,[r0,0x20]
L_8fa870:
	j_s [blink]
L_8fa872:
	nop_s
