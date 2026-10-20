/* bi_sm__action_935b4c @ 0x935b4c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bti__dispatch_sweep_step
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_935b4c
bi_sm__action_935b4c:
	.global L_935b4c
L_935b4c:
	st.a r13,[sp,-0xc]
L_935b50:
	st blink,[sp, 0x4]
L_935b54:
	st_s r14,[sp,0x8]
L_935b56:
	mov_s r14,r1
L_935b58:
	ldb_s r1,[r0]
L_935b5a:
	mov_s r13,r0
L_935b5c:
	bmsk_s r1,r1,0x3
L_935b5e:
	or r1,r1,0xcaf000
L_935b66:
	mov_s r32,r1
L_935b68:
	st.ab r1,[r25,0x4]
L_935b6c:
	bclr r25,r25,0xa
L_935b70:
	ldb_s r2,[r13]
L_935b72:
	mov_s r1,0x802ec0
L_935b78:
	ldw_s r0,[r1,0x4]
L_935b7a:
	stb_s r2,[r1,0x12]
L_935b7c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935b7e:
	stw_s r0,[r1,0x4]
L_935b80:
	mov r0,0x802f44
L_935b88:
	bl.d L_92b7dc
L_935b8c:
	mov r1,r14
L_935b90:
	ld blink,[sp, 0x4]
L_935b94:
	ld_s r14,[sp,0x8]
L_935b96:
	j_s.d [blink]
L_935b98:
	ld.ab r13,[sp,0xc]
