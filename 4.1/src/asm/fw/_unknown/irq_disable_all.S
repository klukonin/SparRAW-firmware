/* irq_disable_all @ 0x8c042c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__wmi_lock_notice
 */
	.section .text.irq_disable_all,"ax",@progbits
	.global irq_disable_all
irq_disable_all:
	.global L_8c042c
L_8c042c:
	lr r0,[0xa]
L_8c0430:
	bic r0,r0,0x6
L_8c0434:
	j.d [blink]
L_8c0438:
	flag r0
