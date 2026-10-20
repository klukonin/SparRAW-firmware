/* mac_clk__div165 @ 0x936b94, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow_step, txrx_api_step_b_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_clk__div165
mac_clk__div165:
	.global L_936b94
L_936b94:
	mov_s r2,0x0
L_936b96:
	b_s L_936b9c
	.global L_936b98
L_936b98:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_936b9a:
	sub_s r0,r0,r3
	.global L_936b9c
L_936b9c:
	mov_s r3,0xa5
L_936b9e:
	brhs r0,r3,L_936b98
L_936ba2:
	stb_s r2,[r1,0x1]
L_936ba4:
	j_s.d [blink]
L_936ba6:
	stb_s r0,[r1]
