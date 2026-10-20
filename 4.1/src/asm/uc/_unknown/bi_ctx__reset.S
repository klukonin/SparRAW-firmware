/* bi_ctx__reset @ 0x9280c4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: memset0_words_uc
 */
	.section .text.bi_ctx__reset,"ax",@progbits
	.global bi_ctx__reset
bi_ctx__reset:
	.global L_9280c4
L_9280c4:
	st.a r13,[sp,-0xc]
L_9280c8:
	st blink,[sp, 0x4]
L_9280cc:
	st_s r14,[sp,0x8]
L_9280ce:
	mov_s r13,r0
L_9280d0:
	mov_s r1,0x0
L_9280d2:
	st_s r1,[r0,0x18]
L_9280d4:
	st.as r1,[r0,0x50]
L_9280d8:
	st_s r1,[r0,0x1c]
L_9280da:
	st.as r1,[r0,0x51]
L_9280de:
	add r14,r0,0x200
L_9280e6:
	stb r1,[r14, -0xb8]
L_9280ea:
	add_s r0,r0,0x20
L_9280ec:
	bl.d L_92166c
L_9280f0:
	mov r1,0xc
L_9280f4:
	add r0,r13,0x2c
L_9280f8:
	bl.d L_92166c
L_9280fc:
	mov r1,0x10
L_928100:
	add3 r0,r13,0x9
L_928104:
	bl.d L_92166c
L_928108:
	mov r1,0x60
L_92810c:
	add3 r0,r13,0x15
L_928110:
	bl.d L_92166c
L_928114:
	mov r1,0x80
L_928118:
	mov_s r0,0xff
L_92811a:
	ld blink,[sp, 0x4]
L_92811e:
	stb r0,[r14, -0xd8]
L_928122:
	stb r0,[r14, -0xd7]
L_928126:
	ld_s r14,[sp,0x8]
L_928128:
	j.d [blink]
L_92812c:
	ld.ab r13,[sp,0xc]
