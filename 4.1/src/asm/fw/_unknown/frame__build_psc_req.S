/* frame__build_psc_req @ 0x8ecbd4, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sta_psc_sm__build_psc_req
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, memset0_words
 */
	.section .text.frame__build_psc_req,"ax",@progbits
	.global frame__build_psc_req
frame__build_psc_req:
	.global L_8ecbd4
L_8ecbd4:
	sub_s sp,sp,0x8
L_8ecbd6:
	push_s blink
L_8ecbd8:
	bl L_8c02bc
L_8ecbdc:
	mov_s r16,r3
L_8ecbde:
	st r4,[sp, 0x18]
L_8ecbe2:
	mov_s r14,r0
L_8ecbe4:
	mov_s r15,r1
L_8ecbe6:
	mov_s r13,r2
L_8ecbe8:
	bl.d L_8c1a78
L_8ecbec:
	mov_s r1,0xe
L_8ecbee:
	mov_s r0,0x10
L_8ecbf0:
	stb_s r0,[r14]
L_8ecbf2:
	mov_s r0,0x0
L_8ecbf4:
	stb_s r0,[r14,0x1]
L_8ecbf6:
	stb_s r15,[r14,0x2]
L_8ecbf8:
	stb_s r13,[r14,0x3]
L_8ecbfa:
	mov_s r0,0x8f
L_8ecbfc:
	stb_s r0,[r14,0x4]
L_8ecbfe:
	mov_s r0,0x8
L_8ecc00:
	stb r16,[r14, 0x6]
L_8ecc04:
	lsr r16,r16,0x8
L_8ecc08:
	stb r16,[r14, 0x7]
L_8ecc0c:
	lsr r16,r16,0x8
L_8ecc10:
	stb r16,[r14, 0x8]
L_8ecc14:
	lsr r16,r16,0x8
L_8ecc18:
	ldw r1,[sp, 0x1a]
L_8ecc1c:
	stb r16,[r14, 0x9]
L_8ecc20:
	stb_s r1,[r14,0xc]
L_8ecc22:
	lsr_s r1,r1,0x8
L_8ecc24:
	stb_s r1,[r14,0xd]
L_8ecc26:
	ldw r1,[sp, 0x18]
L_8ecc2a:
	stb_s r0,[r14,0x5]
L_8ecc2c:
	stb_s r1,[r14,0xa]
L_8ecc2e:
	lsr_s r1,r1,0x8
L_8ecc30:
	stb_s r1,[r14,0xb]
L_8ecc32:
	cmp_s r13,0x0
L_8ecc34:
	mov_s r0,0x4
L_8ecc36:
	mov.ne r0,0xe
L_8ecc3a:
	mov_s r12,0xc
L_8ecc3c:
	b L_8c0326
