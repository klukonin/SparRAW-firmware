/* sdp__init_pair @ 0x8d4768, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp__init_int_ctrl
 * Зовёт сам: sdp__icr_ack_bit, sdp__icr_unmask_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__init_pair
sdp__init_pair:
	.global L_8d4768
L_8d4768:
	push_s blink
L_8d476a:
	bl.d L_8d4758
L_8d476e:
	mov_s r2,r0
L_8d4770:
	bl.d L_8d477c
L_8d4774:
	mov_s r0,r2
L_8d4776:
	pop_s blink
L_8d4778:
	j_s [blink]
L_8d477a:
	nop_s
