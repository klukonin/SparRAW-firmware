/* pcie__ack_882644 @ 0x8eec3c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_transfer, pcie_serdes_step
 * Зовёт сам: pcie__wait_882644_ready, set_reg_882644
 */
	.section .text.pcie__ack_882644,"ax",@progbits
	.global pcie__ack_882644
pcie__ack_882644:
	.global L_8eec3c
L_8eec3c:
	push_s blink
L_8eec3e:
	bl L_8ce4b4
L_8eec42:
	breq_s r0,0,L_8eec4e
L_8eec44:
	bl L_8ce4a4
L_8eec48:
	bl L_8ce4b4
L_8eec4c:
	brne_s r0,0,L_8eec52
	.global L_8eec4e
L_8eec4e:
	mov_s r0,0x0
L_8eec50:
	b_s L_8eec54
	.global L_8eec52
L_8eec52:
	mov_s r0,0x1
	.global L_8eec54
L_8eec54:
	pop_s blink
L_8eec56:
	j_s [blink]
