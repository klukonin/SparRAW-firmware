/* sta_ctx__reset_counters @ 0x93d004, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x05_handler
 * Зовёт сам: memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sta_ctx__reset_counters
sta_ctx__reset_counters:
	.global L_93d004
L_93d004:
	st.a r13,[sp,-0x14]
L_93d008:
	st blink,[sp, 0x4]
L_93d00c:
	st_s r14,[sp,0x8]
L_93d00e:
	st_s r15,[sp,0xc]
L_93d010:
	st r16,[sp, 0x10]
L_93d014:
	mov_s r13,r0
L_93d016:
	mov_s r15,r1
L_93d018:
	mov r16,0x0
L_93d01c:
	st.as r16,[r0,0x50]
L_93d020:
	st.as r16,[r0,0x51]
L_93d024:
	add r14,r0,0x200
L_93d02c:
	stb r16,[r14, -0xb8]
L_93d030:
	add r0,r0,0x20
L_93d034:
	bl.d L_920a84
L_93d038:
	mov r1,0xc
L_93d03c:
	add r0,r13,0x2c
L_93d040:
	bl.d L_920a84
L_93d044:
	mov r1,0x10
L_93d048:
	asl_s r1,r15,0x2
L_93d04a:
	add1_s r1,r1,r1
L_93d04c:
	add3 r0,r13,0x9
L_93d050:
	add r0,r0,r1
L_93d054:
	bl.d L_920a84
L_93d058:
	mov r1,0xc
L_93d05c:
	asl_s r3,r15,0x4
L_93d05e:
	add3 r0,r13,0x15
L_93d062:
	add_s r0,r0,r3
L_93d064:
	bl.d L_920a84
L_93d068:
	mov r1,0x10
L_93d06c:
	ldb r3,[r14, -0xd8]
L_93d070:
	asl r2,0x1,r15
L_93d078:
	or_s r3,r3,r2
L_93d07a:
	ldb r4,[r14, -0xd7]
L_93d07e:
	stb r3,[r14, -0xd8]
L_93d082:
	or r4,r4,r2
L_93d086:
	ldb r2,[r14, -0x88]
L_93d08a:
	stb r4,[r14, -0xd7]
L_93d08e:
	bclr r2,r2,r15
L_93d092:
	stb r16,[r14, -0x87]
L_93d096:
	ld blink,[sp, 0x4]
L_93d09a:
	stb r2,[r14, -0x88]
L_93d09e:
	ld_s r14,[sp,0x8]
L_93d0a0:
	ld_s r15,[sp,0xc]
L_93d0a2:
	ld r16,[sp, 0x10]
L_93d0a6:
	j_s.d [blink]
L_93d0a8:
	ld.ab r13,[sp,0x14]
