/* irq_enable @ 0x8c0384, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.irq_enable,"ax",@progbits
	.global irq_enable
irq_enable:
	.global L_8c0384
L_8c0384:
	lr r0,[0xa]
L_8c0388:
	or r0,r0,0x6
L_8c038c:
	j.d [blink]
L_8c0390:
	flag r0
