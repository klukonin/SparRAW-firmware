/* tx_ring__post_frame @ 0x8e1e98, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r22_to_r13_ret, __st_r22_to_r13, fw_sysassert_fatal, hwd_dma__write_ring_reg, macq__kick_queue, ring__is_full, tx_desc__build, tx_desc__init_32, tx_desc_by_index, tx_ring__advance_index, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_ring__post_frame
tx_ring__post_frame:
	.global L_8e1e98
L_8e1e98:
	push_s blink
L_8e1e9a:
	bl L_8c01c4
L_8e1e9e:
	sub_s sp,sp,0xc
L_8e1ea0:
	mov_s r14,r0
L_8e1ea2:
	mov_s r21,r1
L_8e1ea4:
	mov_s r20,r2
L_8e1ea6:
	mov_s r19,r3
L_8e1ea8:
	st r4,[sp, 0x8]
L_8e1eac:
	mov r17,r5
L_8e1eb0:
	mov r18,r6
L_8e1eb4:
	mov r16,r7
L_8e1eb8:
	add_s r13,r0,0x4
L_8e1eba:
	bl.d L_8da2d8
L_8e1ebe:
	mov_s r0,r13
L_8e1ec0:
	cmp_s r0,0x0
L_8e1ec2:
	mov_s r0,0x0
L_8e1ec4:
	bne_s L_8e1f36
L_8e1ec6:
	mov_s r0,r13
L_8e1ec8:
	bl.d L_8cc1ec
L_8e1ecc:
	ld_s r1,[r13,0xc]
L_8e1ece:
	mov_s r15,r0
L_8e1ed0:
	ld_s r0,[r0,0x1c]
L_8e1ed2:
	bbit1 r0,0x8,L_8e1f3c
	.global L_8e1ed6
L_8e1ed6:
	mov_s r0,r15
L_8e1ed8:
	ld_s r1,[r14,0x14]
L_8e1eda:
	mov r22,0x1
L_8e1ede:
	mov_s r2,r22
L_8e1ee0:
	mov_s r3,r21
L_8e1ee2:
	mov r4,r20
L_8e1ee6:
	bl.d L_8e9bf4
L_8e1eea:
	mov r5,r18
L_8e1eee:
	bl.d L_8ccfd8
L_8e1ef2:
	ld_s r0,[r14,0x14]
L_8e1ef4:
	mov.f r3,r16
L_8e1ef8:
	mov.ne r3,0x1
L_8e1efc:
	ldb_s r1,[sp,0x38]
L_8e1efe:
	st r17,[sp]
L_8e1f02:
	st_s r1,[sp,0x4]
L_8e1f04:
	mov_s r1,r15
L_8e1f06:
	ld_s r2,[sp,0x3c]
L_8e1f08:
	mov r4,r22
L_8e1f0c:
	mov r5,r16
L_8e1f10:
	mov r6,r19
L_8e1f14:
	bl.d L_8ca4d8
L_8e1f18:
	ld r7,[sp, 0x8]
L_8e1f1c:
	add r1,r13,0xc
L_8e1f20:
	bl.d L_8c7f00
L_8e1f24:
	mov_s r0,r13
L_8e1f26:
	ld_s r0,[r14,0x18]
L_8e1f28:
	bl.d L_8d0c00
L_8e1f2c:
	ld_s r1,[r13,0xc]
L_8e1f2e:
	bl.d L_8e1c7c
L_8e1f32:
	ld_s r0,[r14,0x14]
L_8e1f34:
	mov_s r0,r22
	.global L_8e1f36
L_8e1f36:
	b.d L_8c0214
L_8e1f3a:
	add_s sp,sp,0xc
	.global L_8e1f3c
L_8e1f3c:
	mov_s r0,blink
L_8e1f3e:
	mov_s r1,0x1227
L_8e1f44:
	bl L_8c9b28
L_8e1f48:
	b_s L_8e1ed6
L_8e1f4a:
	nop_s
