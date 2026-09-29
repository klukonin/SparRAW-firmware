/* tx__await_rx_or_timeout @ 0x924c78, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__send_and_await_rx_frame
 * Зовёт сам: uc_wait_event1_or_event4, uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx__await_rx_or_timeout
tx__await_rx_or_timeout:
	.global L_924c78
L_924c78:
	push_s blink
L_924c7a:
	mov_s r0,0x2011000
L_924c80:
	mov_s r32,r0
L_924c82:
	st.ab r0,[r25,0x4]
L_924c86:
	bclr r25,r25,0xa
	.global L_924c8a
L_924c8a:
	mov_s r0,0x0
L_924c8c:
	bset_s r0,r0,0xc
L_924c8e:
	mov_s r1,0x40
L_924c90:
	bl.d L_9367e4
L_924c94:
	mov_s r2,0x0
L_924c96:
	mov_s r0,r42
L_924c98:
	bbit1 r0,0xc,L_924ca6
L_924c9c:
	mov_s r0,r54
L_924c9e:
	bbit0 r0,0x6,L_924c8a
L_924ca2:
	mov_s r0,0x1
L_924ca4:
	b_s L_924cfc
	.global L_924ca6
L_924ca6:
	mov_s r0,0x0
L_924ca8:
	bset_s r0,r0,0x10
L_924caa:
	bl.d L_9366e8
L_924cae:
	mov_s r1,0x0
L_924cb0:
	ldb_s r0,[gp,-0xf2]
L_924cb2:
	brne_s r0,0,L_924cd0
L_924cb4:
	ldb_s r0,[gp,-0xf9]
L_924cb6:
	bmsk_s r0,r0,0x0
L_924cb8:
	bset_s r0,r0,0x19
L_924cba:
	bset_s r0,r0,0x1c
L_924cbc:
	bset_s r0,r0,0x1d
L_924cbe:
	mov_s r32,r0
L_924cc0:
	st.ab r0,[r25,0x4]
L_924cc4:
	bclr r25,r25,0xa
L_924cc8:
	ldb_s r0,[gp,-0xf9]
L_924cca:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924ccc:
	stb r0,[gp, -0xf9]
	.global L_924cd0
L_924cd0:
	ld_s r0,[gp,0x50]
L_924cd2:
	mov_s r1,0x8022c8
L_924cd8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924cda:
	st.as r0,[gp,0x14]
L_924cde:
	ld_s r0,[r1,0x3c]
L_924ce0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924ce2:
	st_s r0,[r1,0x3c]
L_924ce4:
	mov_s r0,0x20d2000
L_924cea:
	mov_s r32,r0
L_924cec:
	st.ab r0,[r25,0x4]
L_924cf0:
	bclr r25,r25,0xa
L_924cf4:
	and r0,r37,0x10000
	.global L_924cfc
L_924cfc:
	pop_s blink
L_924cfe:
	j_s [blink]
