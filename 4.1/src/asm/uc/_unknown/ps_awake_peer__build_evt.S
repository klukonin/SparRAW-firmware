/* ps_awake_peer__build_evt @ 0x92feec, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_ps_awake_peer__build_evt
 * Зовёт сам: memset0_words_uc, uc_send_evt__ps_awake_peer
 */
	.section .text.ps_awake_peer__build_evt,"ax",@progbits
	.global ps_awake_peer__build_evt
ps_awake_peer__build_evt:
	.global L_92feec
L_92feec:
	st.a r13,[sp,-0x10]
L_92fef0:
	st blink,[sp, 0x4]
L_92fef4:
	st_s r14,[sp,0x8]
L_92fef6:
	st_s r15,[sp,0xc]
L_92fef8:
	sub_s sp,sp,0x8
L_92fefa:
	mov_s r15,r0
L_92fefc:
	add r0,sp,0x4
L_92ff00:
	bl.d L_92166c
L_92ff04:
	mov r1,0x4
L_92ff08:
	ld.as r1,[gp,-0x11]
L_92ff0c:
	and r1,r1,0xfff0ffff
L_92ff14:
	or r3,r1,0xa0000
L_92ff1c:
	or r1,r1,0x1d0a0000
L_92ff24:
	st.as r3,[gp,-0x11]
L_92ff28:
	mov r32,r1
L_92ff2c:
	st.ab r1,[r25,0x4]
L_92ff30:
	bclr r25,r25,0xa
L_92ff34:
	nop_s
L_92ff36:
	nop_s
L_92ff38:
	nop_s
L_92ff3a:
	mov r9,r47
L_92ff3e:
	extw r13,r9
L_92ff42:
	stw r9,[sp]
L_92ff46:
	ldb r10,[r15, 0x1]
L_92ff4a:
	lsr r2,r13,0xa
L_92ff4e:
	bmsk_s r2,r2,0x2
L_92ff50:
	ldb r14,[sp]
L_92ff54:
	brne.d r2,r10,L_92ffa0
L_92ff58:
	stb r14,[sp, 0x5]
L_92ff5c:
	mov_s r0,0x80aaaa00
L_92ff62:
	mov_s r32,r0
L_92ff64:
	st.ab r0,[r25,0x4]
L_92ff68:
	bclr r25,r25,0xa
L_92ff6c:
	bset_s r14,r14,0x1f
L_92ff6e:
	mov_s r32,r14
L_92ff70:
	st.ab r14,[r25,0x4]
L_92ff74:
	bclr r25,r25,0xa
L_92ff78:
	lsr r5,r13,0x8
L_92ff7c:
	bmsk.f 0x0,r5,0x1
L_92ff80:
	bne L_92ffc8
L_92ff84:
	mov r8,0x1f000601
L_92ff8c:
	mov r32,r8
L_92ff90:
	st.ab r8,[r25,0x4]
L_92ff94:
	bclr r25,r25,0xa
L_92ff98:
	b.d L_92ffc8
L_92ff9c:
	ldw r13,[sp]
	.global L_92ffa0
L_92ffa0:
	mov r7,0x80aaaa01
L_92ffa8:
	mov r32,r7
L_92ffac:
	st.ab r7,[r25,0x4]
L_92ffb0:
	bclr r25,r25,0xa
L_92ffb4:
	mov r4,0x2040000
L_92ffbc:
	mov r32,r4
L_92ffc0:
	st.ab r4,[r25,0x4]
L_92ffc4:
	bclr r25,r25,0xa
	.global L_92ffc8
L_92ffc8:
	mov r6,0x3
L_92ffcc:
	stb r6,[sp, 0x7]
L_92ffd0:
	bl.d L_925ba4
L_92ffd4:
	add r0,sp,0x4
L_92ffd8:
	lsr_s r13,r13,0xa
L_92ffda:
	bmsk_s r13,r13,0x2
L_92ffdc:
	stb_s r13,[r15,0x1]
L_92ffde:
	add_s sp,sp,0x8
L_92ffe0:
	ld blink,[sp, 0x4]
L_92ffe4:
	ld_s r14,[sp,0x8]
L_92ffe6:
	ld_s r15,[sp,0xc]
L_92ffe8:
	j.d [blink]
L_92ffec:
	ld.ab r13,[sp,0x10]
