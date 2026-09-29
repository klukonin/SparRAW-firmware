/* oob__mode_flags @ 0x8ccac8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: oob__mode_flags_default
 * Глобалы (через gp): 0x800190, 0x800194
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global oob__mode_flags
oob__mode_flags:
	.global L_8ccac8
L_8ccac8:
	ldb_s r0,[r0]
L_8ccaca:
	mov_s r1,0x0
L_8ccacc:
	cmp_s r0,0x0
L_8ccace:
	jeq.d [blink]
L_8ccad2:
	mov.eq r0,r1
L_8ccad6:
	ld_s r0,[gp,0xc]
L_8ccad8:
	ld.as r1,[gp,0x4]
L_8ccadc:
	cmp_s r0,0x0
L_8ccade:
	mov.ne r0,0x1
L_8ccae2:
	cmp_s r1,0x0
L_8ccae4:
	jne.d [blink]
L_8ccae8:
	bset.ne r0,r0,0x1
L_8ccaec:
	j_s [blink]
L_8ccaee:
	nop_s
