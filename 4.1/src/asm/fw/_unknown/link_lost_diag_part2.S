/* link_lost_diag_part2 @ 0x8eac48, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ====================================================================
 *   =========== LLD(Link Lost Diagnostic Part 2)           =============
 *   MARLON-M TEMP has not been MEASURED.
 *   MARLON-M TEMP MEASURED (%d).
 *   MARLON-M TEMP CHECK: HIGH (%d) !!!
 *   MARLON-R TEMP has not been MEASURED.
 *   MARLON-M TEMP CHECK: VERY HIGH (%d) !!!
 *   MARLON-R TEMP MEASURED (%d).
 * Зовут его: l2mgr__disconnect_done
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_div_unsigned, fw_log__emit0, fw_log__emit1, get_g_8000a0, get_g_80013c, link_lost_diag__rx_status
 */
	.section .text.link_lost_diag_part2,"ax",@progbits
	.global link_lost_diag_part2
link_lost_diag_part2:
	.global L_8eac48
L_8eac48:
	push_s blink
L_8eac4a:
	bl.d L_8c02c0
L_8eac4e:
	mov_s r0,0x0
L_8eac50:
	mov_s r13,0x1000cb8
L_8eac56:
	mov_s r1,0x2
L_8eac58:
	bl.d L_8edfb0
L_8eac5c:
	mov_s r2,r13
L_8eac5e:
	mov_s r2,0x1000e14
L_8eac64:
	mov_s r0,0x0
L_8eac66:
	bl.d L_8edfb0
L_8eac6a:
	mov_s r1,0x2
L_8eac6c:
	mov_s r0,0x0
L_8eac6e:
	mov_s r1,0x2
L_8eac70:
	bl.d L_8edfb0
L_8eac74:
	mov_s r2,r13
L_8eac76:
	bl.d L_8d4600
L_8eac7a:
	mov r15,-0x1
L_8eac7e:
	bl L_8c98a4
L_8eac82:
	bl.d L_8ca7fc
L_8eac86:
	mov_s r14,r0
L_8eac88:
	mov_s r13,r0
L_8eac8a:
	brne r14,r15,L_8eac9e
L_8eac8e:
	mov_s r2,0x1000e5c
L_8eac94:
	mov_s r0,0x0
L_8eac96:
	bl.d L_8edfb0
L_8eac9a:
	mov_s r1,0x2
L_8eac9c:
	b_s L_8eacd0
	.global L_8eac9e
L_8eac9e:
	mov_s r0,r14
L_8eaca0:
	bl.d L_8c03b4
L_8eaca4:
	mov r1,0x3e8
L_8eaca8:
	cmp_s r14,0x15f90
L_8eacae:
	mov_s r3,r0
L_8eacb0:
	bhs_s L_8eacba
L_8eacb2:
	mov_s r2,0x1000e84
L_8eacb8:
	b_s L_8eacc8
	.global L_8eacba
L_8eacba:
	brhs r14,0x186a0,L_8eace4
L_8eacc2:
	mov_s r2,0x1000ea4
	.global L_8eacc8
L_8eacc8:
	mov_s r0,0x0
L_8eacca:
	bl.d L_8edfcc
L_8eacce:
	mov_s r1,0x2
	.global L_8eacd0
L_8eacd0:
	brne r13,r15,L_8eacec
L_8eacd4:
	mov_s r2,0x1000ec8
L_8eacda:
	mov_s r0,0x0
L_8eacdc:
	bl.d L_8edfb0
L_8eace0:
	mov_s r1,0x2
L_8eace2:
	b_s L_8ead1e
	.global L_8eace4
L_8eace4:
	mov_s r2,0x1000ef0
L_8eacea:
	b_s L_8eacc8
	.global L_8eacec
L_8eacec:
	mov_s r0,r13
L_8eacee:
	bl.d L_8c03b4
L_8eacf2:
	mov r1,0x3e8
L_8eacf6:
	cmp_s r13,0x11170
L_8eacfc:
	mov_s r3,r0
L_8eacfe:
	bhs_s L_8ead08
L_8ead00:
	mov_s r2,0x1000f18
L_8ead06:
	b_s L_8ead16
	.global L_8ead08
L_8ead08:
	brhs r14,0x13880,L_8ead30
L_8ead10:
	mov_s r2,0x1000f38
	.global L_8ead16
L_8ead16:
	mov_s r0,0x0
L_8ead18:
	bl.d L_8edfcc
L_8ead1c:
	mov_s r1,0x2
	.global L_8ead1e
L_8ead1e:
	mov_s r2,0x1000f58
L_8ead24:
	mov_s r0,0x0
L_8ead26:
	bl.d L_8edfb0
L_8ead2a:
	mov_s r1,0x2
L_8ead2c:
	b L_8c032c
	.global L_8ead30
L_8ead30:
	mov_s r2,0x1000f98
L_8ead36:
	b_s L_8ead16
