/* pcie_debug__code_to_index @ 0x8ce480, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_debug
 */
	.section .text.pcie_debug__code_to_index,"ax",@progbits
	.global pcie_debug__code_to_index
pcie_debug__code_to_index:
	.global L_8ce480
L_8ce480:
	mov_s r2,0x0
L_8ce482:
	breq_s r1,0,L_8ce494
L_8ce484:
	breq r1,0x1,L_8ce498
L_8ce488:
	breq r1,0x2,L_8ce49c
L_8ce48c:
	breq r1,0x3,L_8ce49e
L_8ce490:
	mov_s r0,r2
L_8ce492:
	b_s L_8ce4a0
	.global L_8ce494
L_8ce494:
	lsr_s r0,r0,0x3
L_8ce496:
	b_s L_8ce49e
	.global L_8ce498
L_8ce498:
	lsr_s r0,r0,0xc
L_8ce49a:
	b_s L_8ce49e
	.global L_8ce49c
L_8ce49c:
	lsr_s r0,r0,0x9
	.global L_8ce49e
L_8ce49e:
	bmsk_s r0,r0,0x0
	.global L_8ce4a0
L_8ce4a0:
	j_s [blink]
L_8ce4a2:
	nop_s
