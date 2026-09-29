/* irq_set_level @ 0x8c31f8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init, timer__start
 */
	.section .text.irq_set_level,"ax",@progbits
	.global irq_set_level
irq_set_level:
	.global L_8c31f8
L_8c31f8:
	lr r2,[0x200]
L_8c31fc:
	bclr r2,r2,r0
L_8c3200:
	asl_s r1,r1,r0
L_8c3202:
	or_s r1,r1,r2
L_8c3204:
	sr r1,[0x200]
L_8c3208:
	j_s [blink]
L_8c320a:
	nop_s
