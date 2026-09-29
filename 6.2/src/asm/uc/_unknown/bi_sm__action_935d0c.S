/* bi_sm__action_935d0c @ 0x935d0c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi__after_enter_dti
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_935d0c
bi_sm__action_935d0c:
	.global L_935d0c
L_935d0c:
	st.a r13,[sp,-0x8]
L_935d10:
	st blink,[sp, 0x4]
L_935d14:
	ldb_s r2,[r0]
L_935d16:
	mov_s r13,r0
L_935d18:
	bmsk_s r2,r2,0x3
L_935d1a:
	or r2,r2,0xcaf110
L_935d22:
	mov_s r32,r2
L_935d24:
	st.ab r2,[r25,0x4]
L_935d28:
	bclr r25,r25,0xa
L_935d2c:
	ldb_s r3,[r13]
L_935d2e:
	mov_s r2,0x802ec0
L_935d34:
	ldw_s r1,[r2,0x8]
L_935d36:
	stb_s r3,[r2,0x12]
L_935d38:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_935d3a:
	mov_s r0,0x1
L_935d3c:
	st.as r0,[gp,-0xa]
L_935d40:
	mov r0,0x802f44
L_935d48:
	bl.d L_92b85c
L_935d4c:
	stw r1,[r2, 0x8]
L_935d50:
	ld blink,[sp, 0x4]
L_935d54:
	j.d [blink]
L_935d58:
	ld.ab r13,[sp,0x8]
