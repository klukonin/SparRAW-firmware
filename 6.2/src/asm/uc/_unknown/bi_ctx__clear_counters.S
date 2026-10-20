/* bi_ctx__clear_counters @ 0x92ae1c, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_mode_init_sequence
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_ctx__clear_counters
bi_ctx__clear_counters:
	.global L_92ae1c
L_92ae1c:
	st.a r13,[sp,-0x10]
L_92ae20:
	st blink,[sp, 0x4]
L_92ae24:
	st_s r14,[sp,0x8]
L_92ae26:
	st_s r15,[sp,0xc]
L_92ae28:
	mov_s r13,r0
L_92ae2a:
	mov_s r14,0x0
L_92ae2c:
	st_s r14,[r0,0x18]
L_92ae2e:
	st.as r14,[r0,0x50]
L_92ae32:
	st_s r14,[r0,0x1c]
L_92ae34:
	st.as r14,[r0,0x51]
L_92ae38:
	add r15,r0,0x200
L_92ae40:
	stb r14,[r15, -0xb8]
L_92ae44:
	add r0,r0,0x20
L_92ae48:
	bl.d L_920a84
L_92ae4c:
	mov r1,0xc
L_92ae50:
	add r0,r13,0x2c
L_92ae54:
	bl.d L_920a84
L_92ae58:
	mov r1,0x10
L_92ae5c:
	add3 r0,r13,0x9
L_92ae60:
	bl.d L_920a84
L_92ae64:
	mov r1,0x60
L_92ae68:
	add3 r0,r13,0x15
L_92ae6c:
	bl.d L_920a84
L_92ae70:
	mov r1,0x80
L_92ae74:
	mov_s r1,0xff
L_92ae76:
	mov_s r0,0x1
L_92ae78:
	stb r14,[r15, -0x9b]
L_92ae7c:
	stb r14,[r15, -0x9a]
L_92ae80:
	stb r14,[r15, -0x94]
L_92ae84:
	stb r14,[r15, -0x93]
L_92ae88:
	stb r14,[r15, -0x8c]
L_92ae8c:
	ld blink,[sp, 0x4]
L_92ae90:
	stb r1,[r15, -0xd8]
L_92ae94:
	stb r1,[r15, -0xd7]
L_92ae98:
	stb r0,[r15, -0x9c]
L_92ae9c:
	st.as r14,[r13,0x5c]
L_92aea0:
	ld_s r14,[sp,0x8]
L_92aea2:
	st.as 0x4b87f0,[r13,0x5a]
L_92aeaa:
	ld_s r15,[sp,0xc]
L_92aeac:
	j.d [blink]
L_92aeb0:
	ld.ab r13,[sp,0x10]
