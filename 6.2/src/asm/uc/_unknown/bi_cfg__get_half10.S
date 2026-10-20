/* bi_cfg__get_half10 @ 0x927d04, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_prog__cmd02_body
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_cfg__get_half10
bi_cfg__get_half10:
	.global L_927d04
L_927d04:
	j.d [blink]
L_927d08:
	ldw_s r0,[r0,0x10]
L_927d0a:
	nop_s
