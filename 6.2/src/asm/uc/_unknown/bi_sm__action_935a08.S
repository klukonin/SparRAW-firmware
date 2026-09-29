/* bi_sm__action_935a08 @ 0x935a08, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_935a08
bi_sm__action_935a08:
	.global L_935a08
L_935a08:
	st.a r13,[sp,-0x8]
L_935a0c:
	st_s r14,[sp,0x4]
L_935a0e:
	mov_s r14,blink
L_935a10:
	ldb_s r1,[r0]
L_935a12:
	mov_s r13,r0
L_935a14:
	bmsk_s r1,r1,0x3
L_935a16:
	or r1,r1,0xcaf000
L_935a1e:
	mov_s r32,r1
L_935a20:
	st.ab r1,[r25,0x4]
L_935a24:
	bclr r25,r25,0xa
L_935a28:
	ldb_s r2,[r13]
L_935a2a:
	mov_s r1,0x802ec0
L_935a30:
	ldw_s r0,[r1,0x6]
L_935a32:
	stb_s r2,[r1,0x12]
L_935a34:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_935a36:
	stw_s r0,[r1,0x6]
L_935a38:
	mov_s blink,r14
L_935a3a:
	ld_s r14,[sp,0x4]
L_935a3c:
	j.d [blink]
L_935a40:
	ld.ab r13,[sp,0x8]
