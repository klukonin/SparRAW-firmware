/* rs_abort @ 0x92fb80, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rs_abort cid=%u mcs=%u
 * Зовут его: bf__flow_exit, sta__reset_link_state, ucode_cmd_0x12_handler_uc, ucode_cmd_0x13_handler, ucode_cmd_0x30_handler_uc
 * Зовёт сам: __ld_r13_to_r13_ret, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rs_abort
rs_abort:
	.global L_92fb80
L_92fb80:
	push_s blink
L_92fb82:
	push_s r13
L_92fb84:
	mov_s r2,r0
L_92fb86:
	asl_s r13,r0,0x2
L_92fb88:
	add1_s r13,r13,r13
L_92fb8a:
	add_s r13,r13,0x802610
L_92fb90:
	ld_s r0,[r13]
L_92fb92:
	breq_s r0,0,L_92fbb0
L_92fb94:
	mul64 r2,0x2c
L_92fb98:
	add r0,mlo,0x802670
L_92fba0:
	ldb_s r3,[r0,0x1c]
L_92fba2:
	mov_s r1,0x10013b8
L_92fba8:
	stb_s r3,[r0,0x1e]
L_92fbaa:
	bl.d L_92d27c
L_92fbae:
	mov_s r0,0x20
	.global L_92fbb0
L_92fbb0:
	mov_s r0,0x1
L_92fbb2:
	st_s r0,[r13,0x4]
L_92fbb4:
	st_s r0,[r13,0x8]
L_92fbb6:
	mov_s r0,0x0
L_92fbb8:
	b.d L_9202ac
L_92fbbc:
	st_s r0,[r13]
L_92fbbe:
	nop_s
