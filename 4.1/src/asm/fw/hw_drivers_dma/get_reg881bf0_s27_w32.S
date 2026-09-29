/* get_reg881bf0_s27_w32 @ 0x8cda0c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.get_reg881bf0_s27_w32,"ax",@progbits
	.global get_reg881bf0_s27_w32
get_reg881bf0_s27_w32:
	.global L_8cda0c
L_8cda0c:
	mov_s r0,0x881b80
L_8cda12:
	ld_s r0,[r0,0x70]
L_8cda14:
	lsr_s r0,r0,0x1b
L_8cda16:
	j_s.d [blink]
L_8cda18:
	bmsk_s r0,r0,0x0
L_8cda1a:
	nop_s
