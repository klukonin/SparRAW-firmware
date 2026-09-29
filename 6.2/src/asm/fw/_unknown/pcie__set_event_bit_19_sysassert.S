/* pcie__set_event_bit_19_sysassert @ 0x8d1b00, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__log_1003a68
 * Зовёт сам: pcie__set_event_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcie__set_event_bit_19_sysassert
pcie__set_event_bit_19_sysassert:
	.global L_8d1b00
L_8d1b00:
	b.d L_8d1a98
L_8d1b04:
	mov_s r0,0x19
L_8d1b06:
	nop_s
