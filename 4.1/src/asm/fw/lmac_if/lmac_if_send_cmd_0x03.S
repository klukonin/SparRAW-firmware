/* lmac_if_send_cmd_0x03 @ 0x8d89cc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_ch_switch_sm__fwtx_channel_stopped
 * Зовёт сам: basic_if__alloc_mbox_slot, lmac_if__mark_rx_off, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x03,"ax",@progbits
	.global lmac_if_send_cmd_0x03
lmac_if_send_cmd_0x03:
	.global L_8d89cc
L_8d89cc:
	push_s blink
L_8d89ce:
	mov_s r0,0x803e3c
L_8d89d4:
	bl L_8c2c38
L_8d89d8:
	bl.d L_8d89c4
L_8d89dc:
	mov_s r2,r0
L_8d89de:
	mov_s r0,r2
L_8d89e0:
	mov_s r1,0x3
L_8d89e2:
	mov_s r2,0x4
L_8d89e4:
	bl.d L_8e0694
L_8d89e8:
	mov_s r3,0x0
L_8d89ea:
	pop_s blink
L_8d89ec:
	j_s [blink]
L_8d89ee:
	nop_s
