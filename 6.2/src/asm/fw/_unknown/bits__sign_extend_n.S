/* bits__sign_extend_n @ 0x8ea8c0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__get_883b80, phy_rx__read_rssi_adc, phy_rx__read_rssi_adc_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bits__sign_extend_n
bits__sign_extend_n:
	.global L_8ea8c0
L_8ea8c0:
	mov_s r2,0x0
L_8ea8c2:
	bset r2,r2,r1
L_8ea8c6:
	lsr_s r1,r2
L_8ea8c8:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8ea8ca:
	sub r3,r0,r2
L_8ea8ce:
	cmp_s r0,r1
L_8ea8d0:
	j_s.d [blink]
L_8ea8d2:
	mov.hi r0,r3
L_8ea8d6:
	nop_s
