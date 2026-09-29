/* pcie__ack__8e026c @ 0x8e026c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_read, pcie__dbi_transfer
 * Зовёт сам: pcie__dbi_ack_done, pcie__wait_882644_ready
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__ack__8e026c
pcie__ack__8e026c:
	.global L_8e026c
L_8e026c:
	push_s blink
L_8e026e:
	bl L_8d11f8
L_8e0272:
	breq_s r0,0,L_8e027e
L_8e0274:
	bl L_8d11e8
L_8e0278:
	bl L_8d11f8
L_8e027c:
	brne_s r0,0,L_8e0282
	.global L_8e027e
L_8e027e:
	mov_s r0,0x0
L_8e0280:
	b_s L_8e0284
	.global L_8e0282
L_8e0282:
	mov_s r0,0x1
	.global L_8e0284
L_8e0284:
	pop_s blink
L_8e0286:
	j_s [blink]
