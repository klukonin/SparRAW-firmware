/* conn__get_radio_ctx_byte10 @ 0x8cc414, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: maintain_sm__get_mid_idx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__get_radio_ctx_byte10
conn__get_radio_ctx_byte10:
	.global L_8cc414
L_8cc414:
	ld_s r0,[r0,0x4]
L_8cc416:
	ld_s r0,[r0,0x18]
L_8cc418:
	j_s.d [blink]
L_8cc41a:
	ldb_s r0,[r0,0x10]
