/* tx_desc_by_index @ 0x8cc1ec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, tx_ring__post_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_desc_by_index
tx_desc_by_index:
	.global L_8cc1ec
L_8cc1ec:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8cc1ee:
	ld_s r0,[r0]
L_8cc1f0:
	j_s.d [blink]
L_8cc1f2:
	add_s r0,r0,r1
