/* txop__apply_limits_regs @ 0x936ba8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x21_set_txop_limits
 * Глобалы (через gp): 0x800548
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txop__apply_limits_regs
txop__apply_limits_regs:
	.global L_936ba8
L_936ba8:
	ld.as r3,[gp,0x8]
L_936bac:
	mov_s r1,0x80294c
L_936bb2:
	ld_s r2,[r1,0x4]
L_936bb4:
	cmp_s r3,0x0
L_936bb6:
	cmp.ne r0,0x0
L_936bba:
	beq_s L_936bc0
L_936bbc:
	ld_s r0,[gp,-0x24]
L_936bbe:
	lsr_s r2,r2,r0
	.global L_936bc0
L_936bc0:
	ld_s r0,[r1]
L_936bc2:
	st.as r2,[gp,-0x2c]
L_936bc6:
	cmp_s r0,r2
L_936bc8:
	mov.cc r0,r2
L_936bcc:
	asl_s r2,r2,0x10
L_936bce:
	or_s r2,r2,r0
L_936bd0:
	mov_s r3,0x886f00
L_936bd6:
	st_s r2,[r3,0x70]
L_936bd8:
	ld_s r0,[r1,0x8]
L_936bda:
	ld_s r1,[r1,0xc]
L_936bdc:
	asl_s r1,r1,0x10
L_936bde:
	or_s r0,r0,r1
L_936be0:
	st_s r0,[r3,0x74]
L_936be2:
	j_s [blink]
