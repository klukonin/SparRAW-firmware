/* bcon__bits_set16_s7_w3 @ 0x8ed1f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: add_bcon, add_discovery_bcon, bcon_tx_build_step
 * Зовёт сам: bf__set_field_u16_le
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bcon__bits_set16_s7_w3
bcon__bits_set16_s7_w3:
	.global L_8ed1f0
L_8ed1f0:
	mov r10,0x7
L_8ed1f4:
	b.d L_8edc34
L_8ed1f8:
	mov r11,0x2
