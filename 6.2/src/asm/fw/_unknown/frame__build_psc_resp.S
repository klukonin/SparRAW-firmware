/* frame__build_psc_resp @ 0x8d8160, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_psc_sm__build_psc_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_psc_resp
frame__build_psc_resp:
	.global L_8d8160
L_8d8160:
	sub_s sp,sp,0x8
L_8d8162:
	push_s blink
L_8d8164:
	bl L_8c01dc
L_8d8168:
	mov_s r16,r3
L_8d816a:
	st r4,[sp, 0x18]
L_8d816e:
	mov_s r13,r0
L_8d8170:
	mov_s r14,r1
L_8d8172:
	mov_s r15,r2
L_8d8174:
	bl.d L_8c1cd8
L_8d8178:
	mov_s r1,0xf
L_8d817a:
	mov_s r0,0x10
L_8d817c:
	stb_s r0,[r13]
L_8d817e:
	mov_s r0,0x1
L_8d8180:
	stb_s r0,[r13,0x1]
L_8d8182:
	stb_s r14,[r13,0x2]
L_8d8184:
	stb_s r15,[r13,0x3]
L_8d8186:
	lsr_s r15,r15,0x8
L_8d8188:
	stb_s r15,[r13,0x4]
L_8d818a:
	mov_s r0,0x8f
L_8d818c:
	stb_s r0,[r13,0x5]
L_8d818e:
	mov_s r0,0x8
L_8d8190:
	stb r16,[r13, 0x7]
L_8d8194:
	lsr r16,r16,0x8
L_8d8198:
	stb r16,[r13, 0x8]
L_8d819c:
	lsr r16,r16,0x8
L_8d81a0:
	stb r16,[r13, 0x9]
L_8d81a4:
	lsr r16,r16,0x8
L_8d81a8:
	ldw r1,[sp, 0x1a]
L_8d81ac:
	stb r16,[r13, 0xa]
L_8d81b0:
	stb_s r1,[r13,0xd]
L_8d81b2:
	lsr_s r1,r1,0x8
L_8d81b4:
	stb_s r1,[r13,0xe]
L_8d81b6:
	ldw r1,[sp, 0x18]
L_8d81ba:
	stb_s r0,[r13,0x6]
L_8d81bc:
	stb_s r1,[r13,0xb]
L_8d81be:
	lsr_s r1,r1,0x8
L_8d81c0:
	stb_s r1,[r13,0xc]
L_8d81c2:
	mov_s r0,0xf
L_8d81c4:
	mov_s r12,0xc
L_8d81c6:
	b L_8c0246
L_8d81ca:
	nop_s
