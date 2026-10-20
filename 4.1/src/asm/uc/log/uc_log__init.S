/* uc_log__init @ 0x937f68, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   log.c
 * Зовут его: uc_main_init
 * Зовёт сам: memset0_words_uc, uc_sysassert
 */
	.section .text.uc_log__init,"ax",@progbits
	.global uc_log__init
uc_log__init:
	.global L_937f68
L_937f68:
	st.a r13,[sp,-0xc]
L_937f6c:
	st blink,[sp, 0x4]
L_937f70:
	st_s r14,[sp,0x8]
L_937f72:
	mov_s r14,0x80209c
L_937f78:
	ld r1,[0x8006d4]
L_937f80:
	add r13,r14,0x4
L_937f84:
	mov r4,0x0
L_937f88:
	breq.d r1,0x0,L_937ff4
L_937f8c:
	st r4,[r14]
	.global L_937f90
L_937f90:
	mov_s r3,0x7
L_937f92:
	stb_s r3,[r13]
L_937f94:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937f96:
	stb_s r3,[r13]
L_937f98:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937f9a:
	stb_s r3,[r13]
L_937f9c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937f9e:
	stb_s r3,[r13]
L_937fa0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fa2:
	stb_s r3,[r13]
L_937fa4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fa6:
	stb_s r3,[r13]
L_937fa8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937faa:
	stb_s r3,[r13]
L_937fac:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fae:
	stb_s r3,[r13]
L_937fb0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fb2:
	stb_s r3,[r13]
L_937fb4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fb6:
	stb_s r3,[r13]
L_937fb8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fba:
	stb_s r3,[r13]
L_937fbc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fbe:
	stb_s r3,[r13]
L_937fc0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fc2:
	stb_s r3,[r13]
L_937fc4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fc6:
	stb_s r3,[r13]
L_937fc8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fca:
	stb_s r3,[r13]
L_937fcc:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fce:
	stb_s r3,[r13]
L_937fd0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_937fd2:
	add r0,r14,0x14
L_937fd6:
	bl.d L_92166c
L_937fda:
	mov r1,0x400
L_937fde:
	mov_s r2,r14
L_937fe0:
	st r2,[0x880008]
L_937fe8:
	ld blink,[sp, 0x4]
L_937fec:
	ld_s r14,[sp,0x8]
L_937fee:
	j_s.d [blink]
L_937ff0:
	ld.ab r13,[sp,0xc]
	.global L_937ff4
L_937ff4:
	mov_s r0,blink
L_937ff6:
	mov_s r2,0x1000620
L_937ffc:
	mov r1,0xf8
L_938000:
	bl.d L_925548
L_938004:
	mov r3,0x4c
L_938008:
	b_s L_937f90
L_93800a:
	nop_s
