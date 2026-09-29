/* get_reg882fd4_s19_w32 @ 0x8ce948, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: deep_sleep_enter
 */
	.section .text.get_reg882fd4_s19_w32,"ax",@progbits
	.global get_reg882fd4_s19_w32
get_reg882fd4_s19_w32:
	.global L_8ce948
L_8ce948:
	mov_s r0,0x882f80
L_8ce94e:
	ld_s r0,[r0,0x54]
L_8ce950:
	lsr_s r0,r0,0x13
L_8ce952:
	j_s.d [blink]
L_8ce954:
	bmsk_s r0,r0,0x0
L_8ce956:
	nop_s
