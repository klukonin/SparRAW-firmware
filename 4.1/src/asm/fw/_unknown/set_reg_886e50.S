/* set_reg_886e50 @ 0x8e49d4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_ucode_fault
 */
	.section .text.set_reg_886e50,"ax",@progbits
	.global set_reg_886e50
set_reg_886e50:
	.global L_8e49d4
L_8e49d4:
	mov_s r0,0x886e00
L_8e49da:
	st 0x8000,[r0, 0x50]
L_8e49e2:
	j_s [blink]
