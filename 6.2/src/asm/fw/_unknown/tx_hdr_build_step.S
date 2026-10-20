/* tx_hdr_build_step @ 0x8d7cec, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__bf_ntf
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bits__set16h_s0_w2, bits__set16h_s0_w4, bits__set16h_s2_w2, bits__set16h_s4_w4, bits__set16h_s5_w2, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_hdr_build_step
tx_hdr_build_step:
	.global L_8d7cec
L_8d7cec:
	push_s blink
L_8d7cee:
	bl.d L_8c01d4
L_8d7cf2:
	mov_s r7,r1
L_8d7cf4:
	mov_s r14,r0
L_8d7cf6:
	mov_s r18,r2
L_8d7cf8:
	mov_s r17,r3
L_8d7cfa:
	mov_s r13,0x0
L_8d7cfc:
	mov_s r1,r13
L_8d7cfe:
	bl.d L_8ed2d4
L_8d7d02:
	mov r16,r6
L_8d7d06:
	bmsk r1,r7,0x3
L_8d7d0a:
	bl.d L_8ed310
L_8d7d0e:
	mov_s r2,r5
L_8d7d10:
	mov_s r1,0x2
L_8d7d12:
	bl.d L_8ed2f8
L_8d7d16:
	mov_s r15,r4
L_8d7d18:
	stw_s r13,[r14,0x2]
L_8d7d1a:
	ldw_s r0,[r14]
L_8d7d1c:
	brne r2,0x1,L_8d7d42
L_8d7d20:
	bset_s r0,r0,0x8
L_8d7d22:
	stw_s r0,[r14]
L_8d7d24:
	add_s r0,r14,0x4
L_8d7d26:
	mov_s r1,r15
L_8d7d28:
	bl.d L_8c0380
L_8d7d2c:
	mov_s r2,0x6
L_8d7d2e:
	add r0,r14,0xa
L_8d7d32:
	mov_s r1,r17
L_8d7d34:
	bl.d L_8c0380
L_8d7d38:
	mov_s r2,0x6
L_8d7d3a:
	add r0,r14,0x10
L_8d7d3e:
	mov_s r1,r18
L_8d7d40:
	b_s L_8d7d62
	.global L_8d7d42
L_8d7d42:
	bset_s r0,r0,0x9
L_8d7d44:
	stw_s r0,[r14]
L_8d7d46:
	add_s r0,r14,0x4
L_8d7d48:
	mov_s r1,r18
L_8d7d4a:
	bl.d L_8c0380
L_8d7d4e:
	mov_s r2,0x6
L_8d7d50:
	add r0,r14,0xa
L_8d7d54:
	mov_s r1,r15
L_8d7d56:
	bl.d L_8c0380
L_8d7d5a:
	mov_s r2,0x6
L_8d7d5c:
	add r0,r14,0x10
L_8d7d60:
	mov_s r1,r17
	.global L_8d7d62
L_8d7d62:
	bl.d L_8c0380
L_8d7d66:
	mov_s r2,0x6
L_8d7d68:
	stw_s r13,[r14,0x16]
L_8d7d6a:
	add r0,r14,0x18
L_8d7d6e:
	mov_s r1,0x0
L_8d7d70:
	bl.d L_8ed328
L_8d7d74:
	stw_s r13,[r14,0x18]
L_8d7d76:
	ldw_s r1,[r14,0x18]
L_8d7d78:
	bclr_s r1,r1,0x7
L_8d7d7a:
	bclr_s r1,r1,0x4
L_8d7d7c:
	bclr_s r1,r1,0x9
L_8d7d7e:
	stw_s r1,[r14,0x18]
L_8d7d80:
	bmsk r1,r16,0x3
L_8d7d84:
	bl L_8ed2ec
L_8d7d88:
	b.d L_8c0234
L_8d7d8c:
	mov_s r0,0x1a
L_8d7d8e:
	nop_s
