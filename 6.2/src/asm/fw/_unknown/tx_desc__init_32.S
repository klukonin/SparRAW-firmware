/* tx_desc__init_32 @ 0x8e9bf4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ring__post_frame
 * Зовёт сам: TX_API__handle_completed_packets, __ld_r18_to_r13_ret, __st_r18_to_r13, bits__set32_s16_w5, fw_sysassert_fatal, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_desc__init_32
tx_desc__init_32:
	.global L_8e9bf4
L_8e9bf4:
	push_s blink
L_8e9bf6:
	bl L_8c01d4
L_8e9bfa:
	mov_s r14,r0
L_8e9bfc:
	mov_s r13,r1
L_8e9bfe:
	mov_s r15,r2
L_8e9c00:
	mov_s r16,r3
L_8e9c02:
	mov r17,r4
L_8e9c06:
	mov r18,r5
L_8e9c0a:
	bl.d L_8c1cd8
L_8e9c0e:
	mov_s r1,0x20
L_8e9c10:
	stw r17,[r14, 0x1e]
L_8e9c14:
	ld_s r0,[r14,0x10]
L_8e9c16:
	stb r18,[r14, 0x8]
L_8e9c1a:
	bic r0,r0,0x700
L_8e9c1e:
	or r0,r0,0x300
L_8e9c22:
	bmsk_s r15,r15,0x0
L_8e9c24:
	asl_s r15,r15,0xa
L_8e9c26:
	or_s r15,r15,r0
L_8e9c28:
	bmsk r1,r13,0x4
L_8e9c2c:
	add r0,r14,0x10
L_8e9c30:
	bl.d L_8ed400
L_8e9c34:
	st_s r15,[r14,0x10]
L_8e9c36:
	bmsk r0,r16,0x11
L_8e9c3a:
	b.d L_8c0234
L_8e9c3e:
	st_s r0,[r14,0x14]
L_8e9c40:
	push_s blink
L_8e9c42:
	breq r0,0x3,L_8e9c6c
L_8e9c46:
	breq r0,0x5,L_8e9c64
L_8e9c4a:
	breq r0,0x6,L_8e9c5c
L_8e9c4e:
	mov_s r0,blink
L_8e9c50:
	mov_s r1,0x1222
L_8e9c56:
	bl L_8c9b28
L_8e9c5a:
	b_s L_8e9c76
	.global L_8e9c5c
L_8e9c5c:
	mov_s r0,0x842154
L_8e9c62:
	b_s L_8e9c72
	.global L_8e9c64
L_8e9c64:
	mov_s r0,0x842274
L_8e9c6a:
	b_s L_8e9c72
	.global L_8e9c6c
L_8e9c6c:
	mov_s r0,0x8421e4
	.global L_8e9c72
L_8e9c72:
	bl L_8cd5dc
	.global L_8e9c76
L_8e9c76:
	pop_s blink
L_8e9c78:
	j_s [blink]
L_8e9c7a:
	nop_s
