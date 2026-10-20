/* link_lost_diag__noop_dump_hook @ 0x8c8564, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_all
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__noop_dump_hook
link_lost_diag__noop_dump_hook:
	.global L_8c8564
L_8c8564:
	j_s [blink]
L_8c8566:
	nop_s
