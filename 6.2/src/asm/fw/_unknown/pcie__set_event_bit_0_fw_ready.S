/* pcie__set_event_bit_0_fw_ready @ 0x8d1af8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__send_fw_ready_evt
 * Зовёт сам: pcie__set_event_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_event_bit_0_fw_ready
pcie__set_event_bit_0_fw_ready:
	.global L_8d1af8
L_8d1af8:
	b.d L_8d1a98
L_8d1afc:
	mov_s r0,0x0
L_8d1afe:
	nop_s
