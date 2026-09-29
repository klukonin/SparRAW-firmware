/* popcount32 @ 0x8c6c5c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcn_tx_init_ss_params, lmac_if_send_cmd_0x0c
 */
	.section .text.popcount32,"ax",@progbits
	.global popcount32
popcount32:
	.global L_8c6c5c
L_8c6c5c:
	mov_s r1,0x0
L_8c6c5e:
	b_s L_8c6c68
	.global L_8c6c60
L_8c6c60:
	bmsk r2,r0,0x0
L_8c6c64:
	add_s r1,r1,r2
L_8c6c66:
	lsr_s r0,r0
	.global L_8c6c68
L_8c6c68:
	brne_s r0,0,L_8c6c60
L_8c6c6a:
	j_s.d [blink]
L_8c6c6c:
	mov_s r0,r1
L_8c6c6e:
	nop_s
