/* vring_hw__clear_tx_ctl_bit0 @ 0x8df5b4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__configure_tx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_hw__clear_tx_ctl_bit0
vring_hw__clear_tx_ctl_bit0:
	.global L_8df5b4
L_8df5b4:
	mov_s r1,0x881b00
L_8df5ba:
	ld_s r0,[r1,0x24]
L_8df5bc:
	bclr_s r0,r0,0x0
L_8df5be:
	st_s r0,[r1,0x24]
L_8df5c0:
	j_s [blink]
L_8df5c2:
	nop_s
