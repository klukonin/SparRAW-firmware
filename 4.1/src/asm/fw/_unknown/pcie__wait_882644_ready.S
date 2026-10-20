/* pcie__wait_882644_ready @ 0x8ce4b4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ack_882644
 */
	.section .text.pcie__wait_882644_ready,"ax",@progbits
	.global pcie__wait_882644_ready
pcie__wait_882644_ready:
	.global L_8ce4b4
L_8ce4b4:
	mov_s r1,0xa5
L_8ce4b6:
	mov lp_count,0x5281
L_8ce4be:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8ce4c0:
	lp L_8ce4d2
L_8ce4c4:
	mov_s r0,0x882600
L_8ce4ca:
	ld_s r0,[r0,0x44]
L_8ce4cc:
	bbit0 r0,0x1d,L_8ce4d2
L_8ce4d0:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_8ce4d2
L_8ce4d2:
	cmp_s r1,0x0
L_8ce4d4:
	mov_s r0,0x1
L_8ce4d6:
	j_s.d [blink]
L_8ce4d8:
	sub.le r0,r0,r0
