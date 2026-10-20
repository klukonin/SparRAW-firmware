/* frame__build_psc_req @ 0x8d80f4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sta_psc_sm__build_psc_req
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_psc_req
frame__build_psc_req:
	.global L_8d80f4
L_8d80f4:
	sub_s sp,sp,0x8
L_8d80f6:
	push_s blink
L_8d80f8:
	bl L_8c01dc
L_8d80fc:
	mov_s r16,r3
L_8d80fe:
	st r4,[sp, 0x18]
L_8d8102:
	mov_s r14,r0
L_8d8104:
	mov_s r15,r1
L_8d8106:
	mov_s r13,r2
L_8d8108:
	bl.d L_8c1cd8
L_8d810c:
	mov_s r1,0xe
L_8d810e:
	mov_s r0,0x10
L_8d8110:
	stb_s r0,[r14]
L_8d8112:
	mov_s r0,0x0
L_8d8114:
	stb_s r0,[r14,0x1]
L_8d8116:
	stb_s r15,[r14,0x2]
L_8d8118:
	stb_s r13,[r14,0x3]
L_8d811a:
	mov_s r0,0x8f
L_8d811c:
	stb_s r0,[r14,0x4]
L_8d811e:
	mov_s r0,0x8
L_8d8120:
	stb r16,[r14, 0x6]
L_8d8124:
	lsr r16,r16,0x8
L_8d8128:
	stb r16,[r14, 0x7]
L_8d812c:
	lsr r16,r16,0x8
L_8d8130:
	stb r16,[r14, 0x8]
L_8d8134:
	lsr r16,r16,0x8
L_8d8138:
	ldw r1,[sp, 0x1a]
L_8d813c:
	stb r16,[r14, 0x9]
L_8d8140:
	stb_s r1,[r14,0xc]
L_8d8142:
	lsr_s r1,r1,0x8
L_8d8144:
	stb_s r1,[r14,0xd]
L_8d8146:
	ldw r1,[sp, 0x18]
L_8d814a:
	stb_s r0,[r14,0x5]
L_8d814c:
	stb_s r1,[r14,0xa]
L_8d814e:
	lsr_s r1,r1,0x8
L_8d8150:
	stb_s r1,[r14,0xb]
L_8d8152:
	cmp_s r13,0x0
L_8d8154:
	mov_s r0,0x4
L_8d8156:
	mov.ne r0,0xe
L_8d815a:
	mov_s r12,0xc
L_8d815c:
	b L_8c0246
