/* pcie_dbg__rearm_irq_bit9 @ 0x8fa854, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mgmt_tx__copy_ie_max96
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie_dbg__rearm_irq_bit9
pcie_dbg__rearm_irq_bit9:
	.global L_8fa854
L_8fa854:
	mov r1,0x200
L_8fa858:
	mov_s r0,0x882680
L_8fa85e:
	st_s r1,[r0,0xc]
L_8fa860:
	st_s r1,[r0,0x20]
L_8fa862:
	j_s [blink]
