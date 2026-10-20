/* stream_mgr__build_params @ 0x8e2a50, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bits__set32_s16_w4, mac_ring_disable, memset0_words, qh__write_or_conn_alloc, stream_params__copy_hdr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__build_params
stream_mgr__build_params:
	.global L_8e2a50
L_8e2a50:
	push_s blink
L_8e2a52:
	bl L_8c01dc
L_8e2a56:
	sub_s sp,sp,0x70
L_8e2a58:
	mov_s r13,r0
L_8e2a5a:
	mov_s r14,r1
L_8e2a5c:
	mov_s r15,r2
L_8e2a5e:
	mov_s r16,r3
L_8e2a60:
	mov_s r0,sp
L_8e2a62:
	bl.d L_8c1cd8
L_8e2a66:
	mov_s r1,0x70
L_8e2a68:
	stb_s r14,[r13,0xb]
L_8e2a6a:
	ld_s r0,[sp,0x40]
L_8e2a6c:
	bmsk_s r15,r15,0x0
L_8e2a6e:
	bclr_s r0,r0,0x0
L_8e2a70:
	or_s r0,r0,r15
L_8e2a72:
	st_s r0,[sp,0x40]
L_8e2a74:
	bmsk r1,r16,0x3
L_8e2a78:
	add_s r0,sp,0x40
L_8e2a7a:
	bl L_8ed3f4
L_8e2a7e:
	mov_s r1,sp
L_8e2a80:
	bl.d L_8cc19c
L_8e2a84:
	mov_s r0,r13
L_8e2a86:
	mov_s r2,sp
L_8e2a88:
	ldb_s r0,[r13,0xa]
L_8e2a8a:
	mov_s r1,0x1f
L_8e2a8c:
	bl.d L_8ea5b0
L_8e2a90:
	mov_s r3,0x0
L_8e2a92:
	ldb_s r0,[r13,0xb]
L_8e2a94:
	cmp_s r0,0x5
L_8e2a96:
	cmp.ne r0,0x6
L_8e2a9a:
	beq_s L_8e2aa2
L_8e2a9c:
	bl.d L_8ea418
L_8e2aa0:
	ldb_s r0,[r13,0xa]
	.global L_8e2aa2
L_8e2aa2:
	mov_s r0,0x1
L_8e2aa4:
	stb_s r0,[r13,0xc]
L_8e2aa6:
	b.d L_8c0244
L_8e2aaa:
	add_s sp,sp,0x70
