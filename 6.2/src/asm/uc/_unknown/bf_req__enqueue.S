/* bf_req__enqueue @ 0x921bd4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_unexpected, bf_init_sm, ucode_cmd_0x31_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_req__enqueue
bf_req__enqueue:
	.global L_921bd4
L_921bd4:
	push_s blink
L_921bd6:
	bl L_920230
L_921bda:
	mov_s r14,0x80207c
L_921be0:
	ld_s r13,[r14,0x34]
L_921be2:
	mov_s r15,0x0
L_921be4:
	cmp_s r13,0x0
L_921be6:
	mov_s r13,0x1
L_921be8:
	ld_s r3,[r14,0x34]
L_921bea:
	sub_s.ne r13,r13,r13
L_921bec:
	bset r3,r3,r0
L_921bf0:
	st_s r3,[r14,0x34]
L_921bf2:
	asl_s r3,r0,0x2
L_921bf4:
	add2_s r3,r3,r3
L_921bf6:
	add_s r3,r3,0x801ffc
L_921bfc:
	st_s r1,[r3]
L_921bfe:
	st_s r15,[r3,0x4]
L_921c00:
	stb_s r15,[r3,0xa]
L_921c02:
	st_s r2,[r3,0xc]
L_921c04:
	ld_s r1,[r14,0x44]
L_921c06:
	bmsk r3,r1,0x2
L_921c0a:
	add r2,r3,0x8020b4
L_921c12:
	stb_s r0,[r2]
L_921c14:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_921c16:
	st_s r1,[r14,0x44]
L_921c18:
	ld_s r0,[r14,0x44]
L_921c1a:
	ld_s r1,[r14,0x40]
L_921c1c:
	sub_s r0,r0,r1
L_921c1e:
	brhs r0,0x9,L_921c28
	.global L_921c22
L_921c22:
	b.d L_92029c
L_921c26:
	mov_s r0,r13
	.global L_921c28
L_921c28:
	mov_s r0,blink
L_921c2a:
	bl.d L_926618
L_921c2e:
	mov_s r1,0x12
L_921c30:
	b_s L_921c22
L_921c32:
	nop_s
