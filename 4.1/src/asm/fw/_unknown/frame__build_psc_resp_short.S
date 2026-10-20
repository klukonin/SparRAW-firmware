/* frame__build_psc_resp_short @ 0x8eccac, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_psc_sm__build_psc_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.frame__build_psc_resp_short,"ax",@progbits
	.global frame__build_psc_resp_short
frame__build_psc_resp_short:
	.global L_8eccac
L_8eccac:
	sub_s sp,sp,0x8
L_8eccae:
	push_s blink
L_8eccb0:
	bl L_8c02bc
L_8eccb4:
	mov_s r16,r3
L_8eccb6:
	st r4,[sp, 0x18]
L_8eccba:
	mov_s r13,r0
L_8eccbc:
	mov_s r14,r1
L_8eccbe:
	mov_s r15,r2
L_8eccc0:
	bl.d L_8c1a78
L_8eccc4:
	mov_s r1,0xd
L_8eccc6:
	mov_s r0,0x10
L_8eccc8:
	stb_s r0,[r13]
L_8eccca:
	mov_s r0,0x1
L_8ecccc:
	stb_s r0,[r13,0x1]
L_8eccce:
	stb_s r14,[r13,0x2]
L_8eccd0:
	stb_s r15,[r13,0x3]
L_8eccd2:
	lsr_s r15,r15,0x8
L_8eccd4:
	stb r16,[r13, 0x5]
L_8eccd8:
	lsr r16,r16,0x8
L_8eccdc:
	stb r16,[r13, 0x6]
L_8ecce0:
	lsr r16,r16,0x8
L_8ecce4:
	stb r16,[r13, 0x7]
L_8ecce8:
	lsr r16,r16,0x8
L_8eccec:
	ldw r1,[sp, 0x1a]
L_8eccf0:
	stb r16,[r13, 0x8]
L_8eccf4:
	stb_s r1,[r13,0xb]
L_8eccf6:
	lsr_s r1,r1,0x8
L_8eccf8:
	stb_s r1,[r13,0xc]
L_8eccfa:
	ldw r1,[sp, 0x18]
L_8eccfe:
	stb_s r15,[r13,0x4]
L_8ecd00:
	stb_s r1,[r13,0x9]
L_8ecd02:
	lsr_s r1,r1,0x8
L_8ecd04:
	stb_s r1,[r13,0xa]
L_8ecd06:
	mov_s r0,0xd
L_8ecd08:
	mov_s r12,0xc
L_8ecd0a:
	b L_8c0326
L_8ecd0e:
	nop_s
