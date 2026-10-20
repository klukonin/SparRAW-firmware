/* mac__read_pair64_consistent @ 0x93257c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__compute_tbtt_from_hw, power_mngr_peer_update
 */
	.section .text.mac__read_pair64_consistent,"ax",@progbits
	.global mac__read_pair64_consistent
mac__read_pair64_consistent:
	.global L_93257c
L_93257c:
	mov r5,0x887000
L_932584:
	breq r2,0x0,L_932590
	.global L_932588
L_932588:
	ld.as r4,[r5,-0x53]
L_93258c:
	bbit0 r4,0x1f,L_932588
	.global L_932590
L_932590:
	ld r6,[r5, -0x3c]
L_932594:
	st r6,[r1]
L_932598:
	ld r2,[r5, -0x38]
L_93259c:
	st_s r2,[r1,0x4]
L_93259e:
	ld r3,[r5, -0x3c]
L_9325a2:
	cmp r6,r3
L_9325a6:
	jeq_s [blink]
L_9325a8:
	b_s L_932590
L_9325aa:
	nop_s
