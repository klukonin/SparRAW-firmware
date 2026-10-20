/* boot__read_oob_strap_bits @ 0x8cc2ac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__init_subsystems, l2mgr__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__read_oob_strap_bits
boot__read_oob_strap_bits:
	.global L_8cc2ac
L_8cc2ac:
	mov_s r0,0x11
L_8cc2ae:
	asl_s r0,r0,0x13
L_8cc2b0:
	ld_s r0,[r0,0x18]
L_8cc2b2:
	j_s.d [blink]
L_8cc2b4:
	lsr_s r0,r0,0x1d
L_8cc2b6:
	nop_s
