/* rgf_reg_88416c @ 0x8d15f8, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__apply_tx_power
 */
	.section .text.rgf_reg_88416c,"ax",@progbits
	.global rgf_reg_88416c
rgf_reg_88416c:
	.global L_8d15f8
L_8d15f8:
	breq_s r0,0,L_8d161c
L_8d15fa:
	mov lp_count,0x54
L_8d15fe:
	mov_s r1,0x0
L_8d1600:
	lp L_8d161a
L_8d1604:
	mov_s r0,0x802f38
L_8d160a:
	ldw.as r2,[r0,r1]
L_8d160e:
	mov_s r0,0x88416c
L_8d1614:
	add2_s r0,r0,r1
L_8d1616:
	st_s r2,[r0]
L_8d1618:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d161a
L_8d161a:
	b_s L_8d1642
	.global L_8d161c
L_8d161c:
	mov lp_count,0x54
L_8d1620:
	mov_s r1,0x0
L_8d1622:
	lp L_8d1642
L_8d1626:
	mov_s r0,0x802fb8
L_8d162c:
	sub r0,r0,0x80
L_8d1630:
	add1_s r0,r0,r1
L_8d1632:
	ldw r2,[r0, 0xa8]
L_8d1636:
	mov_s r0,0x88416c
L_8d163c:
	add2_s r0,r0,r1
L_8d163e:
	st_s r2,[r0]
L_8d1640:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8d1642
L_8d1642:
	j_s [blink]
