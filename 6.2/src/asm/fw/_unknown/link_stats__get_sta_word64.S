/* link_stats__get_sta_word64 @ 0x8ccb50, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__fill_sta_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_stats__get_sta_word64
link_stats__get_sta_word64:
	.global L_8ccb50
L_8ccb50:
	b.d L_8ccb58
L_8ccb54:
	add_s r0,r0,0x10
L_8ccb56:
	nop_s
	.global L_8ccb58
L_8ccb58:
	b.d L_8ccb60
L_8ccb5c:
	add_s r0,r0,0x2c
L_8ccb5e:
	nop_s
	.global L_8ccb60
L_8ccb60:
	j_s.d [blink]
L_8ccb62:
	ld_s r0,[r0,0x28]
