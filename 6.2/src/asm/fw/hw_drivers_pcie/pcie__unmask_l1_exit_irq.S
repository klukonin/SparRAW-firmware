/* pcie__unmask_l1_exit_irq @ 0x8d160c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__unmask_l1_exit_irq
pcie__unmask_l1_exit_irq:
	.global L_8d160c
L_8d160c:
	mov_s r0,0x882f80
L_8d1612:
	st 0x80000,[r0, 0x64]
L_8d161a:
	j_s [blink]
