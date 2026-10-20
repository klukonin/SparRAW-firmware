/* verify_pbc @ 0x8ebd68, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   verify_pbc: FALSE is_new_vc = %d,is_local_pbc_active %d is_remote_pbc_active= %d
 *   verify_pbc: TRUE is_new_vc = %d,is_local_pbc_active %d is_remote_pbc_active= %d
 * Зовут его: bss_join_verify
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit3, parse_wilocity_vs__get_flag3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global verify_pbc
verify_pbc:
	.global L_8ebd68
L_8ebd68:
	push_s blink
L_8ebd6a:
	push_s r13
L_8ebd6c:
	mov_s r0,r2
L_8ebd6e:
	ld r3,[r1, 0xa4]
L_8ebd72:
	mov_s r2,0x0
L_8ebd74:
	mov.f r13,r3
L_8ebd78:
	mov.ne r13,0x1
L_8ebd7c:
	cmp_s r3,0x0
L_8ebd7e:
	mov.eq r4,r2
L_8ebd82:
	beq_s L_8ebd92
L_8ebd84:
	add_s r0,r0,0x48
L_8ebd86:
	bl.d L_8df8ec
L_8ebd8a:
	add r1,r1,0xa0
L_8ebd8e:
	extw r4,r0
	.global L_8ebd92
L_8ebd92:
	cmp_s r13,0x0
L_8ebd94:
	cmp.ne r4,0x0
L_8ebd98:
	beq_s L_8ebdae
L_8ebd9a:
	mov_s r1,0x100c4b8
L_8ebda0:
	mov_s r0,0x2b
L_8ebda2:
	mov_s r2,r13
L_8ebda4:
	bl.d L_8dcd00
L_8ebda8:
	mov_s r3,0x0
L_8ebdaa:
	mov_s r0,0x0
L_8ebdac:
	b_s L_8ebdc0
	.global L_8ebdae
L_8ebdae:
	mov_s r1,0x100c50c
L_8ebdb4:
	mov_s r0,0x2b
L_8ebdb6:
	mov_s r2,r13
L_8ebdb8:
	bl.d L_8dcd00
L_8ebdbc:
	mov_s r3,0x0
L_8ebdbe:
	mov_s r0,0x1
	.global L_8ebdc0
L_8ebdc0:
	b L_8c025c
