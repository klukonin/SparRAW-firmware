/* regd__jp_or_unset @ 0x8d7364, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__apply_tx_power
 * Глобалы (через gp): 0x8001fc
 */
	.section .text.regd__jp_or_unset,"ax",@progbits
	.global regd__jp_or_unset
regd__jp_or_unset:
	.global L_8d7364
L_8d7364:
	ld_s r0,[gp,-0xb4]
L_8d7366:
	mov_s r1,0x0
L_8d7368:
	breq_s r0,0,L_8d7378
L_8d736a:
	ldw_s r0,[gp,0x8c]
L_8d736c:
	cmp_s r0,0x4a50
L_8d7372:
	mov.ne r0,r1
L_8d7376:
	bne_s L_8d737a
	.global L_8d7378
L_8d7378:
	mov_s r0,0x1
	.global L_8d737a
L_8d737a:
	j_s.d [blink]
L_8d737c:
	extb_s r0,r0
L_8d737e:
	nop_s
