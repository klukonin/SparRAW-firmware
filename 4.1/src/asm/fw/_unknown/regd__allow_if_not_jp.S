/* regd__allow_if_not_jp @ 0x8d7380, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__apply_tx_power
 * Глобалы (через gp): 0x8001fc
 */
	.section .text.regd__allow_if_not_jp,"ax",@progbits
	.global regd__allow_if_not_jp
regd__allow_if_not_jp:
	.global L_8d7380
L_8d7380:
	ld_s r0,[gp,-0xb4]
L_8d7382:
	mov_s r1,0x0
L_8d7384:
	brne_s r0,0,L_8d7390
L_8d7386:
	ldw_s r0,[gp,0x8c]
L_8d7388:
	brne r0,0x4a50,L_8d7394
	.global L_8d7390
L_8d7390:
	mov_s r0,r1
L_8d7392:
	b_s L_8d7396
	.global L_8d7394
L_8d7394:
	mov_s r0,0x1
	.global L_8d7396
L_8d7396:
	j_s.d [blink]
L_8d7398:
	extb_s r0,r0
L_8d739a:
	nop_s
