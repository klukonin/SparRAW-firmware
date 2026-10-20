/* mac__program_886f70_from_tbl @ 0x931cac, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x21_handler
 * Глобалы (через gp): 0x80054c
 */
	.section .text.mac__program_886f70_from_tbl,"ax",@progbits
	.global mac__program_886f70_from_tbl
mac__program_886f70_from_tbl:
	.global L_931cac
L_931cac:
	ld.as r3,[gp,0x9]
L_931cb0:
	mov_s r1,0x8019ec
L_931cb6:
	ld_s r2,[r1,0x4]
L_931cb8:
	cmp_s r3,0x0
L_931cba:
	cmp.ne r0,0x0
L_931cbe:
	beq_s L_931cc4
L_931cc0:
	ld_s r0,[gp,-0x28]
L_931cc2:
	lsr_s r2,r2,r0
	.global L_931cc4
L_931cc4:
	ld_s r0,[r1]
L_931cc6:
	st.as r2,[gp,-0x2d]
L_931cca:
	cmp_s r0,r2
L_931ccc:
	mov.cc r0,r2
L_931cd0:
	asl_s r2,r2,0x10
L_931cd2:
	or_s r2,r2,r0
L_931cd4:
	mov_s r3,0x886f00
L_931cda:
	st_s r2,[r3,0x70]
L_931cdc:
	ld_s r0,[r1,0x8]
L_931cde:
	ld_s r1,[r1,0xc]
L_931ce0:
	asl_s r1,r1,0x10
L_931ce2:
	or_s r0,r0,r1
L_931ce4:
	st_s r0,[r3,0x74]
L_931ce6:
	j_s [blink]
