/* frame__build_psc_resp @ 0x8ecc40, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcp_psc_sm__build_psc_resp
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.frame__build_psc_resp,"ax",@progbits
	.global frame__build_psc_resp
frame__build_psc_resp:
	.global L_8ecc40
L_8ecc40:
	sub_s sp,sp,0x8
L_8ecc42:
	push_s blink
L_8ecc44:
	bl L_8c02bc
L_8ecc48:
	mov_s r16,r3
L_8ecc4a:
	st r4,[sp, 0x18]
L_8ecc4e:
	mov_s r13,r0
L_8ecc50:
	mov_s r14,r1
L_8ecc52:
	mov_s r15,r2
L_8ecc54:
	bl.d L_8c1a78
L_8ecc58:
	mov_s r1,0xf
L_8ecc5a:
	mov_s r0,0x10
L_8ecc5c:
	stb_s r0,[r13]
L_8ecc5e:
	mov_s r0,0x1
L_8ecc60:
	stb_s r0,[r13,0x1]
L_8ecc62:
	stb_s r14,[r13,0x2]
L_8ecc64:
	stb_s r15,[r13,0x3]
L_8ecc66:
	lsr_s r15,r15,0x8
L_8ecc68:
	stb_s r15,[r13,0x4]
L_8ecc6a:
	mov_s r0,0x8f
L_8ecc6c:
	stb_s r0,[r13,0x5]
L_8ecc6e:
	mov_s r0,0x8
L_8ecc70:
	stb r16,[r13, 0x7]
L_8ecc74:
	lsr r16,r16,0x8
L_8ecc78:
	stb r16,[r13, 0x8]
L_8ecc7c:
	lsr r16,r16,0x8
L_8ecc80:
	stb r16,[r13, 0x9]
L_8ecc84:
	lsr r16,r16,0x8
L_8ecc88:
	ldw r1,[sp, 0x1a]
L_8ecc8c:
	stb r16,[r13, 0xa]
L_8ecc90:
	stb_s r1,[r13,0xd]
L_8ecc92:
	lsr_s r1,r1,0x8
L_8ecc94:
	stb_s r1,[r13,0xe]
L_8ecc96:
	ldw r1,[sp, 0x18]
L_8ecc9a:
	stb_s r0,[r13,0x6]
L_8ecc9c:
	stb_s r1,[r13,0xb]
L_8ecc9e:
	lsr_s r1,r1,0x8
L_8ecca0:
	stb_s r1,[r13,0xc]
L_8ecca2:
	mov_s r0,0xf
L_8ecca4:
	mov_s r12,0xc
L_8ecca6:
	b L_8c0326
L_8eccaa:
	nop_s
