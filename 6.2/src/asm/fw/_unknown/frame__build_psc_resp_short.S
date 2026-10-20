/* frame__build_psc_resp_short @ 0x8d81cc, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_psc_sm__build_psc_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_psc_resp_short
frame__build_psc_resp_short:
	.global L_8d81cc
L_8d81cc:
	sub_s sp,sp,0x8
L_8d81ce:
	push_s blink
L_8d81d0:
	bl L_8c01dc
L_8d81d4:
	mov_s r16,r3
L_8d81d6:
	st r4,[sp, 0x18]
L_8d81da:
	mov_s r13,r0
L_8d81dc:
	mov_s r14,r1
L_8d81de:
	mov_s r15,r2
L_8d81e0:
	bl.d L_8c1cd8
L_8d81e4:
	mov_s r1,0xd
L_8d81e6:
	mov_s r0,0x10
L_8d81e8:
	stb_s r0,[r13]
L_8d81ea:
	mov_s r0,0x1
L_8d81ec:
	stb_s r0,[r13,0x1]
L_8d81ee:
	stb_s r14,[r13,0x2]
L_8d81f0:
	stb_s r15,[r13,0x3]
L_8d81f2:
	lsr_s r15,r15,0x8
L_8d81f4:
	stb r16,[r13, 0x5]
L_8d81f8:
	lsr r16,r16,0x8
L_8d81fc:
	stb r16,[r13, 0x6]
L_8d8200:
	lsr r16,r16,0x8
L_8d8204:
	stb r16,[r13, 0x7]
L_8d8208:
	lsr r16,r16,0x8
L_8d820c:
	ldw r1,[sp, 0x1a]
L_8d8210:
	stb r16,[r13, 0x8]
L_8d8214:
	stb_s r1,[r13,0xb]
L_8d8216:
	lsr_s r1,r1,0x8
L_8d8218:
	stb_s r1,[r13,0xc]
L_8d821a:
	ldw r1,[sp, 0x18]
L_8d821e:
	stb_s r15,[r13,0x4]
L_8d8220:
	stb_s r1,[r13,0x9]
L_8d8222:
	lsr_s r1,r1,0x8
L_8d8224:
	stb_s r1,[r13,0xa]
L_8d8226:
	mov_s r0,0xd
L_8d8228:
	mov_s r12,0xc
L_8d822a:
	b L_8c0246
L_8d822e:
	nop_s
