/* bf__set_field_word @ 0x93ec68, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bits__uc_set32_s4_w3, bits__uc_set32_s4_w4, bits__uc_set32_s8_w15, brp__bits_uc_set32_s1_w8, brp__bits_uc_set32_s4_w5, frame_hdr__bits_uc_set32_s0_w7, frame_hdr__bits_uc_set32_s15_w8, frame_hdr__bits_uc_set32_s23_w9, frame_hdr__bits_uc_set32_s7_w8, rx_mode__bits_uc_set32_s0_w4
 * Зовёт сам: bf__insert_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__set_field_word
bf__set_field_word:
	.global L_93ec68
L_93ec68:
	push_s r12
L_93ec6a:
	push_s blink
L_93ec6c:
	bl.d L_93ebc0
L_93ec70:
	ld_s r12,[r0]
L_93ec72:
	st_s r12,[r0]
L_93ec74:
	ld.ab blink,[sp,0x4]
L_93ec78:
	j_s.d [blink]
L_93ec7a:
	pop_s r12
