/* tx_ring__advance_index @ 0x8c7f00, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, tx_ring__post_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_ring__advance_index
tx_ring__advance_index:
	.global L_8c7f00
L_8c7f00:
	ld_s r2,[r1]
L_8c7f02:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8c7f04:
	st_s r2,[r1]
L_8c7f06:
	ld_s r0,[r0,0x4]
L_8c7f08:
	brne r2,r0,L_8c7f10
L_8c7f0c:
	mov_s r0,0x0
L_8c7f0e:
	st_s r0,[r1]
	.global L_8c7f10
L_8c7f10:
	j_s [blink]
L_8c7f12:
	nop_s
