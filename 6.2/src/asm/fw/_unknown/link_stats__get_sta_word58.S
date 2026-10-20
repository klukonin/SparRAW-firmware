/* link_stats__get_sta_word58 @ 0x8ccf64, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__fill_sta_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__get_sta_word58
link_stats__get_sta_word58:
	.global L_8ccf64
L_8ccf64:
	b.d L_8ccf6c
L_8ccf68:
	add_s r0,r0,0x10
L_8ccf6a:
	nop_s
	.global L_8ccf6c
L_8ccf6c:
	b.d L_8ccf74
L_8ccf70:
	add_s r0,r0,0x2c
L_8ccf72:
	nop_s
	.global L_8ccf74
L_8ccf74:
	j_s.d [blink]
L_8ccf76:
	ld_s r0,[r0,0x1c]
