/* sta_rec__unpack_5bit_caps @ 0x8cab58, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__build_mac_config
 * Зовёт сам: __ld_r13_ret, bf_b_s0_w5, bf_b_s2_w5, bf_u16_s5_w5, bf_u16_s7_w5
 */
	.section .text.sta_rec__unpack_5bit_caps,"ax",@progbits
	.global sta_rec__unpack_5bit_caps
sta_rec__unpack_5bit_caps:
	.global L_8cab58
L_8cab58:
	push_s blink
L_8cab5a:
	push_s r13
L_8cab5c:
	mov_s r13,r1
L_8cab5e:
	ldb_s r1,[r1]
L_8cab60:
	mov_s r3,r0
L_8cab62:
	bmsk_s r1,r1,0x4
L_8cab64:
	add3 r2,r0,0x2c
L_8cab68:
	add r0,r2,0x1b
L_8cab6c:
	bl L_8e8210
L_8cab70:
	ldb_s r1,[r13,0x1]
L_8cab72:
	add r0,r2,0x1c
L_8cab76:
	lsr_s r1,r1,0x2
L_8cab78:
	bmsk_s r1,r1,0x4
L_8cab7a:
	bl L_8e824c
L_8cab7e:
	ldb_s r0,[r13,0x1]
L_8cab80:
	ldb_s r1,[r13]
L_8cab82:
	asl_s r0,r0,0x8
L_8cab84:
	or_s r1,r1,r0
L_8cab86:
	lsr_s r1,r1,0x5
L_8cab88:
	bmsk_s r1,r1,0x4
L_8cab8a:
	mov_s r0,r3
L_8cab8c:
	add r0,r0,0x17b
L_8cab90:
	bl L_8e8180
L_8cab94:
	ldb_s r0,[r13,0x2]
L_8cab96:
	ldb_s r1,[r13,0x1]
L_8cab98:
	asl_s r0,r0,0x8
L_8cab9a:
	or_s r1,r1,r0
L_8cab9c:
	lsr_s r1,r1,0x7
L_8cab9e:
	bmsk_s r1,r1,0x4
L_8caba0:
	mov_s r0,r3
L_8caba2:
	add r0,r0,0x17c
L_8caba6:
	bl L_8e81c8
L_8cabaa:
	ldb_s r0,[r13,0x2]
L_8cabac:
	lsr_s r0,r0,0x5
L_8cabae:
	bmsk_s r0,r0,0x0
L_8cabb0:
	asl_s r1,r0,0x5
L_8cabb2:
	ldb_s r0,[r2,0x1d]
L_8cabb4:
	bclr_s r0,r0,0x5
L_8cabb6:
	or_s r1,r1,r0
L_8cabb8:
	stb_s r1,[r2,0x1d]
L_8cabba:
	ldb_s r0,[r13,0x2]
L_8cabbc:
	bclr_s r1,r1,0x4
L_8cabbe:
	lsr_s r0,r0,0x4
L_8cabc0:
	bmsk_s r0,r0,0x0
L_8cabc2:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8cabc4:
	or_s r0,r0,r1
L_8cabc6:
	b.d L_8c033c
L_8cabca:
	stb_s r0,[r2,0x1d]
