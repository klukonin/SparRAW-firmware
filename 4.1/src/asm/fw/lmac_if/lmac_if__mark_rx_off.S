/* lmac_if__mark_rx_off @ 0x8d89c4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x03
 */
	.section .text.lmac_if__mark_rx_off,"ax",@progbits
	.global lmac_if__mark_rx_off
lmac_if__mark_rx_off:
	.global L_8d89c4
L_8d89c4:
	mov_s r1,0x1
L_8d89c6:
	j_s.d [blink]
L_8d89c8:
	st_s r1,[r0]
L_8d89ca:
	nop_s
