/* rgf_reg_880a80_8cd62c @ 0x8cd62c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__apply_mode_flags
 */
	.section .text.rgf_reg_880a80_8cd62c,"ax",@progbits
	.global rgf_reg_880a80_8cd62c
rgf_reg_880a80_8cd62c:
	.global L_8cd62c
L_8cd62c:
	mov_s r3,0xbc
L_8cd62e:
	asl_s r3,r3,0x18
L_8cd630:
	mov_s r1,0x880a80
L_8cd636:
	cmp_s r0,0x0
L_8cd638:
	ld_s r0,[r1,0x7c]
L_8cd63a:
	mov_s r2,0x43ffffff
L_8cd640:
	and_s r0,r0,r2
L_8cd642:
	or.ne r0,r0,r3
L_8cd646:
	st_s r0,[r1,0x7c]
L_8cd648:
	j_s [blink]
L_8cd64a:
	nop_s
