/* pcie__l1_idle_and_park @ 0x8d10ac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ready_for_deep_sleep
 * Зовёт сам: hwd_pcie_ltssm_is_l1_idle, pcie__ack_l1_exit_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__l1_idle_and_park
pcie__l1_idle_and_park:
	.global L_8d10ac
L_8d10ac:
	push_s blink
L_8d10ae:
	bl L_8d1070
L_8d10b2:
	breq_s r0,0,L_8d10c2
L_8d10b4:
	bl L_8d15ec
L_8d10b8:
	bl L_8d1070
L_8d10bc:
	cmp_s r0,0x0
L_8d10be:
	mov_s r0,0x1
L_8d10c0:
	bne_s L_8d10c4
	.global L_8d10c2
L_8d10c2:
	mov_s r0,0x0
	.global L_8d10c4
L_8d10c4:
	pop_s blink
L_8d10c6:
	j_s [blink]
