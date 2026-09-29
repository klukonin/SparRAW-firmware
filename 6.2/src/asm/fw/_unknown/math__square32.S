/* math__square32 @ 0x8e75fc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy_rx_sar_rssi_measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global math__square32
math__square32:
	.global L_8e75fc
L_8e75fc:
	mul64_s r0,r0
L_8e75fe:
	j_s.d [blink]
L_8e7600:
	mov_s r0,mlo
L_8e7602:
	nop_s
