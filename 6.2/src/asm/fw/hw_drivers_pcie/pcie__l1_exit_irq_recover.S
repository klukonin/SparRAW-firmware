/* pcie__l1_exit_irq_recover @ 0x8d161c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__l1_exit_irq_recover
pcie__l1_exit_irq_recover:
	.global L_8d161c
L_8d161c:
	mov_s r0,0x882f80
L_8d1622:
	st 0x80000,[r0, 0x58]
L_8d162a:
	j_s [blink]
