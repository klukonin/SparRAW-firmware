/* set_reg_886e40_x2 @ 0x8e49bc, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.set_reg_886e40_x2,"ax",@progbits
	.global set_reg_886e40_x2
set_reg_886e40_x2:
	.global L_8e49bc
L_8e49bc:
	mov_s r0,0x886e00
L_8e49c2:
	st 0x8000,[r0, 0x40]
L_8e49ca:
	st 0x8000,[r0, 0x54]
L_8e49d2:
	j_s [blink]
