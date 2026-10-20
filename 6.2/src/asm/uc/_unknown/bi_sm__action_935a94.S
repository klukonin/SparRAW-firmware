/* bi_sm__action_935a94 @ 0x935a94, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi__after_enter_aw
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_935a94
bi_sm__action_935a94:
	.global L_935a94
L_935a94:
	st.a r13,[sp,-0x8]
L_935a98:
	st blink,[sp, 0x4]
L_935a9c:
	ldb_s r2,[r0]
L_935a9e:
	mov_s r13,r0
L_935aa0:
	bmsk_s r2,r2,0x3
L_935aa2:
	or r2,r2,0xcaf220
L_935aaa:
	mov_s r32,r2
L_935aac:
	st.ab r2,[r25,0x4]
L_935ab0:
	bclr r25,r25,0xa
L_935ab4:
	ldb_s r3,[r13]
L_935ab6:
	mov_s r2,0x802ec0
L_935abc:
	ldw_s r1,[r2,0xa]
L_935abe:
	stb_s r3,[r2,0x12]
L_935ac0:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_935ac2:
	mov_s r0,0x0
L_935ac4:
	st.as r0,[gp,-0x34]
L_935ac8:
	mov r0,0x802f44
L_935ad0:
	bl.d L_92b798
L_935ad4:
	stw r1,[r2, 0xa]
L_935ad8:
	ld blink,[sp, 0x4]
L_935adc:
	j.d [blink]
L_935ae0:
	ld.ab r13,[sp,0x8]
