/* uc_log__init_ring @ 0x92d0a0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610
 * Зовёт сам: memset0_words_uc, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_log__init_ring
uc_log__init_ring:
	.global L_92d0a0
L_92d0a0:
	st.a r13,[sp,-0xc]
L_92d0a4:
	st blink,[sp, 0x4]
L_92d0a8:
	st_s r14,[sp,0x8]
L_92d0aa:
	mov_s r14,0x803234
L_92d0b0:
	ld r1,[0x800778]
L_92d0b8:
	add r13,r14,0x4
L_92d0bc:
	mov r4,0x0
L_92d0c0:
	breq.d r1,0x0,L_92d12c
L_92d0c4:
	st r4,[r14]
	.global L_92d0c8
L_92d0c8:
	mov_s r3,0x7
L_92d0ca:
	stb_s r3,[r13]
L_92d0cc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0ce:
	stb_s r3,[r13]
L_92d0d0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0d2:
	stb_s r3,[r13]
L_92d0d4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0d6:
	stb_s r3,[r13]
L_92d0d8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0da:
	stb_s r3,[r13]
L_92d0dc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0de:
	stb_s r3,[r13]
L_92d0e0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0e2:
	stb_s r3,[r13]
L_92d0e4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0e6:
	stb_s r3,[r13]
L_92d0e8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0ea:
	stb_s r3,[r13]
L_92d0ec:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0ee:
	stb_s r3,[r13]
L_92d0f0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0f2:
	stb_s r3,[r13]
L_92d0f4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0f6:
	stb_s r3,[r13]
L_92d0f8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0fa:
	stb_s r3,[r13]
L_92d0fc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d0fe:
	stb_s r3,[r13]
L_92d100:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d102:
	stb_s r3,[r13]
L_92d104:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d106:
	stb_s r3,[r13]
L_92d108:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92d10a:
	add r0,r14,0x14
L_92d10e:
	bl.d L_920a84
L_92d112:
	mov r1,0x400
L_92d116:
	mov_s r2,r14
L_92d118:
	st r2,[0x880008]
L_92d120:
	ld blink,[sp, 0x4]
L_92d124:
	ld_s r14,[sp,0x8]
L_92d126:
	j_s.d [blink]
L_92d128:
	ld.ab r13,[sp,0xc]
	.global L_92d12c
L_92d12c:
	mov r0,blink
L_92d130:
	bl.d L_926618
L_92d134:
	mov r1,0xf8
L_92d138:
	b_s L_92d0c8
L_92d13a:
	nop_s
