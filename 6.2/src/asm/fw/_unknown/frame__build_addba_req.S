/* frame__build_addba_req @ 0x8f4dc8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__send_addba_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bits__set8_s2_w4, frame__bits_set16_s4_w12, frame__bits_set16_s6_w10, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_addba_req
frame__build_addba_req:
	.global L_8f4dc8
L_8f4dc8:
	push_s blink
L_8f4dca:
	bl L_8c01d0
L_8f4dce:
	mov_s r13,r0
L_8f4dd0:
	mov_s r14,r1
L_8f4dd2:
	mov_s r15,r2
L_8f4dd4:
	mov_s r16,r3
L_8f4dd6:
	mov r17,r4
L_8f4dda:
	mov r18,r5
L_8f4dde:
	mov r19,r6
L_8f4de2:
	bl.d L_8c1cd8
L_8f4de6:
	mov_s r1,0x9
L_8f4de8:
	mov_s r0,0x3
L_8f4dea:
	stb_s r0,[r13]
L_8f4dec:
	mov_s r0,0x0
L_8f4dee:
	stb_s r0,[r13,0x1]
L_8f4df0:
	ldb_s r0,[r13,0x3]
L_8f4df2:
	bmsk r1,r19,0x0
L_8f4df6:
	bclr_s r0,r0,0x0
L_8f4df8:
	or_s r0,r0,r1
L_8f4dfa:
	bclr_s r0,r0,0x1
L_8f4dfc:
	stb_s r0,[r13,0x3]
L_8f4dfe:
	bmsk r1,r16,0x3
L_8f4e02:
	add_s r0,r13,0x3
L_8f4e04:
	bl.d L_8ed268
L_8f4e08:
	stb_s r14,[r13,0x2]
L_8f4e0a:
	bmsk r1,r15,0x9
L_8f4e0e:
	add_s r0,r13,0x3
L_8f4e10:
	bl L_8ed1cc
L_8f4e14:
	stb r17,[r13, 0x5]
L_8f4e18:
	lsr r17,r17,0x8
L_8f4e1c:
	bmsk r1,r18,0xb
L_8f4e20:
	add_s r0,r13,0x7
L_8f4e22:
	bl.d L_8ed1a8
L_8f4e26:
	stb r17,[r13, 0x6]
L_8f4e2a:
	b.d L_8c022c
L_8f4e2e:
	mov_s r0,0x9
