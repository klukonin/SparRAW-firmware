/* bf__set_field_half_fw @ 0x8edce0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bits__set16h_s0_w2, bits__set16h_s0_w4, bits__set16h_s2_w2, bits__set16h_s4_w4, bits__set16h_s4_w5, bits__set16h_s5_w2, ese__bits_set16h_s0_w3, mac_filter__bits_set16h_s4_w2, rx_chain__bits_set16h_s0_w12
 * Зовёт сам: bf__insert_field_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bf__set_field_half_fw
bf__set_field_half_fw:
	.global L_8edce0
L_8edce0:
	push_s r12
L_8edce2:
	push_s blink
L_8edce4:
	bl.d L_8edc10
L_8edce8:
	ldw_s r12,[r0]
L_8edcea:
	stw_s r12,[r0]
L_8edcec:
	ld.ab blink,[sp,0x4]
L_8edcf0:
	j_s.d [blink]
L_8edcf2:
	pop_s r12
