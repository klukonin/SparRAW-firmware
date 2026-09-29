/* l2_offload__set_rx_decap_cfg @ 0x8df5a8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_offload__set_rx_decap_cfg
l2_offload__set_rx_decap_cfg:
	.global L_8df5a8
L_8df5a8:
	mov_s r1,0x881b00
L_8df5ae:
	st_s r0,[r1,0x30]
L_8df5b0:
	j_s [blink]
L_8df5b2:
	nop_s
