/* l1_task__check_pending @ 0x92ce0c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Глобалы (через gp): 0x800550
 */
	.section .text.l1_task__check_pending,"ax",@progbits
	.global l1_task__check_pending
l1_task__check_pending:
	.global L_92ce0c
L_92ce0c:
	push_s r13
L_92ce0e:
	mov_s r2,0x800a0c
L_92ce14:
	ldb_s r0,[r2,0x2]
L_92ce16:
	cmp r0,0xff
L_92ce1a:
	beq_s L_92ce68
L_92ce1c:
	ldb_s r0,[r2,0x8]
L_92ce1e:
	brne_s r0,0,L_92ce5c
L_92ce20:
	ldb_s r1,[r2,0xd]
L_92ce22:
	ldb_s r3,[r2,0x1]
L_92ce24:
	sub r0,r3,r1
L_92ce28:
	max r0,r0,0x0
L_92ce2c:
	extb_s r1,r0
L_92ce2e:
	stb_s r0,[r2,0x7]
L_92ce30:
	ldb_s r0,[gp,0x28]
L_92ce32:
	add_s r13,r0,r1
L_92ce34:
	extb_s r13,r13
L_92ce36:
	/* add_s r0,0x3 */
	.byte 0x03,0xe0
L_92ce38:
	brlt r0,r13,L_92ce3e
L_92ce3c:
	ldb_s r13,[r2,0xc]
	.global L_92ce3e
L_92ce3e:
	ldb_s r0,[r2,0x9]
L_92ce40:
	stb_s r3,[r2,0x3]
L_92ce42:
	min r0,r0,r13
L_92ce46:
	stb_s r0,[r2,0x6]
L_92ce48:
	mov_s r0,0x1
L_92ce4a:
	ldb.x r3,[r2, 0x15]
L_92ce4e:
	stb_s r0,[r2,0x4]
L_92ce50:
	ldb_s r0,[r2,0x12]
L_92ce52:
	add_s r1,r1,r3
L_92ce54:
	max r0,r0,r1
L_92ce58:
	stb_s r0,[r2,0x13]
L_92ce5a:
	b_s L_92ce60
	.global L_92ce5c
L_92ce5c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_92ce5e:
	stb_s r0,[r2,0x8]
	.global L_92ce60
L_92ce60:
	mov_s r0,0x7f
L_92ce62:
	stb_s r0,[r2,0x1]
L_92ce64:
	mov_s r0,0xff
L_92ce66:
	stb_s r0,[r2,0x2]
	.global L_92ce68
L_92ce68:
	j_s.d [blink]
L_92ce6a:
	pop_s r13
