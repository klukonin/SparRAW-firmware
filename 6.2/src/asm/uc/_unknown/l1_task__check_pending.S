/* l1_task__check_pending @ 0x930d44, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Глобалы (через gp): 0x80054c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global l1_task__check_pending
l1_task__check_pending:
	.global L_930d44
L_930d44:
	push_s r13
L_930d46:
	mov_s r2,0x8014e8
L_930d4c:
	ldb_s r0,[r2,0x2]
L_930d4e:
	cmp r0,0xff
L_930d52:
	beq_s L_930da0
L_930d54:
	ldb_s r0,[r2,0x8]
L_930d56:
	brne_s r0,0,L_930d94
L_930d58:
	ldb_s r1,[r2,0xd]
L_930d5a:
	ldb_s r3,[r2,0x1]
L_930d5c:
	sub r0,r3,r1
L_930d60:
	max r0,r0,0x0
L_930d64:
	extb_s r1,r0
L_930d66:
	stb_s r0,[r2,0x7]
L_930d68:
	ldb_s r0,[gp,0x24]
L_930d6a:
	add_s r13,r0,r1
L_930d6c:
	extb_s r13,r13
L_930d6e:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_930d70:
	brlt r0,r13,L_930d76
L_930d74:
	ldb_s r13,[r2,0xc]
	.global L_930d76
L_930d76:
	ldb_s r0,[r2,0x9]
L_930d78:
	stb_s r3,[r2,0x3]
L_930d7a:
	min r0,r0,r13
L_930d7e:
	stb_s r0,[r2,0x6]
L_930d80:
	mov_s r0,0x1
L_930d82:
	ldb.x r3,[r2, 0x15]
L_930d86:
	stb_s r0,[r2,0x4]
L_930d88:
	ldb_s r0,[r2,0x12]
L_930d8a:
	add_s r1,r1,r3
L_930d8c:
	max r0,r0,r1
L_930d90:
	stb_s r0,[r2,0x13]
L_930d92:
	b_s L_930d98
	.global L_930d94
L_930d94:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_930d96:
	stb_s r0,[r2,0x8]
	.global L_930d98
L_930d98:
	mov_s r0,0x7f
L_930d9a:
	stb_s r0,[r2,0x1]
L_930d9c:
	mov_s r0,0xff
L_930d9e:
	stb_s r0,[r2,0x2]
	.global L_930da0
L_930da0:
	j_s.d [blink]
L_930da2:
	pop_s r13
