/* boot__read_strap_bit @ 0x8da2f0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__read_strap_bit
boot__read_strap_bit:
	.global L_8da2f0
L_8da2f0:
	mov_s r1,0x11
L_8da2f2:
	asl_s r1,r1,0x13
L_8da2f4:
	ld_s r0,[r1,0x1c]
L_8da2f6:
	btst_s r0,0x0
L_8da2f8:
	mov.ne r0,0x1
L_8da2fc:
	bne_s L_8da304
L_8da2fe:
	bset_s r0,r0,0x0
L_8da300:
	st_s r0,[r1,0x1c]
L_8da302:
	mov_s r0,0x0
	.global L_8da304
L_8da304:
	j_s [blink]
L_8da306:
	nop_s
