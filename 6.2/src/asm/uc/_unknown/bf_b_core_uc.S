/* bf_b_core_uc @ 0x93ec7c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bits__set_u8_s0_w5_uc, bits__set_u8_s0_w6_uc, bits__set_u8_s0_w7_uc, bits__set_u8_s3_w5_uc, bits__set_u8_s6_w2_uc
 * Зовёт сам: bf__insert_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_b_core_uc
bf_b_core_uc:
	.global L_93ec7c
L_93ec7c:
	push_s r12
L_93ec7e:
	push_s blink
L_93ec80:
	bl.d L_93ebc0
L_93ec84:
	ldb_s r12,[r0]
L_93ec86:
	stb_s r12,[r0]
L_93ec88:
	ld.ab blink,[sp,0x4]
L_93ec8c:
	j_s.d [blink]
L_93ec8e:
	pop_s r12
