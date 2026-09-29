/* bcn_tx_init_bi_cfg @ 0x8c3c98, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bcn_tx_init_bi_cfg(): discovery_mode = %x
 * Зовут его: lmac_if__build_bcon_cfg
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 */
	.section .text.bcn_tx_init_bi_cfg,"ax",@progbits
	.global bcn_tx_init_bi_cfg
bcn_tx_init_bi_cfg:
	.global L_8c3c98
L_8c3c98:
	sub_s sp,sp,0x8
L_8c3c9a:
	push_s blink
L_8c3c9c:
	push_s r13
L_8c3c9e:
	st_s r1,[sp,0x8]
L_8c3ca0:
	ldb r1,[sp, 0xb]
L_8c3ca4:
	st_s r2,[sp,0xc]
L_8c3ca6:
	lsr_s r1,r1,0x5
L_8c3ca8:
	add3 r2,r0,0xc
L_8c3cac:
	stb_s r1,[r2,0x18]
L_8c3cae:
	ldw r1,[sp, 0xc]
L_8c3cb2:
	ldb r3,[sp, 0xb]
L_8c3cb6:
	lsr_s r1,r1,0x6
L_8c3cb8:
	bmsk_s r1,r1,0x5
L_8c3cba:
	stb_s r1,[r2,0x19]
L_8c3cbc:
	ldb r1,[sp, 0x9]
L_8c3cc0:
	asl_s r3,r3,0x8
L_8c3cc2:
	lsr_s r1,r1,0x2
L_8c3cc4:
	bmsk_s r1,r1,0x3
L_8c3cc6:
	stb_s r1,[r2,0x1b]
L_8c3cc8:
	mov_s r1,0x0
L_8c3cca:
	stb_s r1,[r2,0x1c]
L_8c3ccc:
	ldb r1,[sp, 0xa]
L_8c3cd0:
	add r0,r0,0x80
L_8c3cd4:
	or_s r1,r1,r3
L_8c3cd6:
	lsr_s r1,r1,0x6
L_8c3cd8:
	bmsk_s r1,r1,0x6
L_8c3cda:
	stb_s r1,[r2,0x1d]
L_8c3cdc:
	ldb_s r1,[sp,0x8]
L_8c3cde:
	ld_s r3,[r0,0x8]
L_8c3ce0:
	bmsk r13,r1,0x0
L_8c3ce4:
	bclr_s r3,r3,0x0
L_8c3ce6:
	or_s r3,r3,r13
L_8c3ce8:
	lsr_s r1,r1
L_8c3cea:
	bmsk_s r1,r1,0x0
L_8c3cec:
	asl_s r1,r1
L_8c3cee:
	bclr_s r3,r3,0x1
L_8c3cf0:
	or_s r3,r3,r1
L_8c3cf2:
	ldb r1,[sp, 0xd]
L_8c3cf6:
	bic r3,r3,0xc
L_8c3cfa:
	lsr_s r1,r1,0x4
L_8c3cfc:
	bmsk_s r1,r1,0x0
L_8c3cfe:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_8c3d00:
	or_s r3,r3,r1
L_8c3d02:
	st_s r3,[r0,0x8]
L_8c3d04:
	ldb r1,[sp, 0x9]
L_8c3d08:
	ldb_s r0,[sp,0x8]
L_8c3d0a:
	asl_s r1,r1,0x8
L_8c3d0c:
	or_s r0,r0,r1
L_8c3d0e:
	lsr_s r0,r0,0x7
L_8c3d10:
	bmsk_s r0,r0,0x2
L_8c3d12:
	stb_s r0,[r2,0x1e]
L_8c3d14:
	mov_s r2,0x1004e64
L_8c3d1a:
	lsr_s r3,r3
L_8c3d1c:
	mov_s r0,0x5
L_8c3d1e:
	mov_s r1,0x2
L_8c3d20:
	bl.d L_8edfcc
L_8c3d24:
	bmsk_s r3,r3,0x0
L_8c3d26:
	mov_s r12,0xc
L_8c3d28:
	b L_8c033e
