/* brp__rank_insert @ 0x92e904, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__flow, brp_responder_flow_enter
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__rank_insert
brp__rank_insert:
	.global L_92e904
L_92e904:
	push_s blink
L_92e906:
	bl.d L_920230
L_92e90a:
	mov_s r4,r1
L_92e90c:
	mov_s r5,r2
L_92e90e:
	mov_s r1,0x85776c
L_92e914:
	ld.as r2,[r1,r0]
L_92e918:
	bbit0 r2,r5,L_92e972
L_92e91c:
	mov_s r13,0x0
L_92e91e:
	b_s L_92e922
	.global L_92e920
L_92e920:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_92e922
L_92e922:
	mov_s r1,0x801ff4
L_92e928:
	ldb_s r14,[r1]
L_92e92a:
	brhs r13,r14,L_92e972
L_92e92e:
	asl_s r2,r0,0x6
L_92e930:
	add1 r1,r2,r13
L_92e934:
	mov_s r3,0x801c94
L_92e93a:
	ldb.a r15,[r1,r3]
L_92e93e:
	brlt r4,r15,L_92e920
L_92e942:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_92e944:
	breq r13,r14,L_92e96a
L_92e948:
	sub lp_count,r14,r13
L_92e94c:
	lp L_92e96a
L_92e950:
	asl_s r0,r14
L_92e952:
	/* sub_s r0,r0,0x2 */
	.byte 0x62,0xb8
L_92e954:
	add_s r0,r0,r2
L_92e956:
	add_s r13,r3,r0
L_92e958:
	ldb_s r13,[r13]
L_92e95a:
	add1 r15,r2,r14
L_92e95e:
	add_s r15,r15,r3
L_92e960:
	stb_s r13,[r15]
L_92e962:
	add_s r0,r0,r3
L_92e964:
	ldb_s r0,[r0,0x1]
L_92e966:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_92e968:
	stb_s r0,[r15,0x1]
	.global L_92e96a
L_92e96a:
	stb r4,[r1]
L_92e96e:
	stb r5,[r1, 0x1]
	.global L_92e972
L_92e972:
	b L_92029c
L_92e976:
	nop_s
