/* bf_ctrl__lowest_trigger_bit @ 0x8d97d4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__action_8cab64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf_ctrl__lowest_trigger_bit
bf_ctrl__lowest_trigger_bit:
	.global L_8d97d4
L_8d97d4:
	mov_s r0,0x0
L_8d97d6:
	mov_s r3,0x80147c
L_8d97dc:
	ldw_s r2,[r3,0x24]
L_8d97de:
	ldw_s r1,[r3,0x22]
L_8d97e0:
	asl_s r2,r2,0x10
L_8d97e2:
	or_s r1,r1,r2
L_8d97e4:
	bclr_s r1,r1,0x0
L_8d97e6:
	b_s L_8d97ea
	.global L_8d97e8
L_8d97e8:
	mov_s r1,r2
	.global L_8d97ea
L_8d97ea:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d97ec:
	lsr_s r2,r1
L_8d97ee:
	bbit0 r1,0x1,L_8d97e8
L_8d97f2:
	j_s [blink]
