/* sm_pring__update_slot @ 0x8e4edc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, pring__by_index, sm_pring__slot_optimized
 */
	.section .text.sm_pring__update_slot,"ax",@progbits
	.global sm_pring__update_slot
sm_pring__update_slot:
L_8e4edc:
	push_s blink
L_8e4ede:
	push_s r13
L_8e4ee0:
	mov_s r13,r0
L_8e4ee2:
	bl.d L_8ca7dc
L_8e4ee6:
	mov_s r0,r1
L_8e4ee8:
	bl.d L_8e4ef4
L_8e4eec:
	mov_s r1,r13
L_8e4eee:
	b L_8c033c
L_8e4ef2:
	nop_s
