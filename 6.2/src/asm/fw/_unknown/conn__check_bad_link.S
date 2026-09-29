/* conn__check_bad_link @ 0x8c5ef8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Check bad link: max_mcs=%d success_bf_cnt=%d failed_bf_cnt=%d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, channels_switch__check_g800104, conn__get_cid_via_field8, conn_mgr__by_cid, fw_log_emit3, fw_sysassert_fatal
 * Глобалы (через gp): 0x80021c, 0x8002c0, 0x8002c4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__check_bad_link
conn__check_bad_link:
	.global L_8c5ef8
L_8c5ef8:
	push_s blink
L_8c5efa:
	bl L_8c01e4
L_8c5efe:
	mov_s r13,r0
L_8c5f00:
	ld_s r3,[r13,0x70]
L_8c5f02:
	ld_s r14,[r13,0x74]
L_8c5f04:
	mov_s r0,0x0
L_8c5f06:
	add.f 0x0,r14,r3
L_8c5f0a:
	st_s r0,[r13,0x20]
L_8c5f0c:
	beq_s L_8c5f22
L_8c5f0e:
	ld_s r2,[r13,0x6c]
L_8c5f10:
	mov_s r1,0x101471c
L_8c5f16:
	mov_s r0,0x20
L_8c5f18:
	bl.d L_8dcd00
L_8c5f1c:
	mov_s r4,r14
L_8c5f1e:
	ld_s r3,[r13,0x70]
L_8c5f20:
	ld_s r14,[r13,0x74]
	.global L_8c5f22
L_8c5f22:
	mov_s r0,0x803c00
L_8c5f28:
	ld_s r0,[r0,0x20]
L_8c5f2a:
	bbit0 r0,0x3,L_8c5f34
L_8c5f2e:
	ld.as r1,[gp,0x4f]
L_8c5f32:
	b_s L_8c5f38
	.global L_8c5f34
L_8c5f34:
	ldb r1,[gp, 0x97]
	.global L_8c5f38
L_8c5f38:
	bbit0 r0,0x3,L_8c5f40
L_8c5f3c:
	ld_s r0,[gp,0x140]
L_8c5f3e:
	b_s L_8c5f42
	.global L_8c5f40
L_8c5f40:
	ldb_s r0,[gp,0x98]
	.global L_8c5f42
L_8c5f42:
	ld_s r2,[r13,0x6c]
L_8c5f44:
	add_s r3,r3,r14
L_8c5f46:
	brne r2,0x1,L_8c5f4e
L_8c5f4a:
	brhs r3,r1,L_8c5f52
	.global L_8c5f4e
L_8c5f4e:
	brlo r3,r0,L_8c5f5e
	.global L_8c5f52
L_8c5f52:
	bl.d L_8cbec0
L_8c5f56:
	mov_s r0,r13
L_8c5f58:
	bl L_8cbffc
L_8c5f5c:
	breq_s r0,0,L_8c5f68
	.global L_8c5f5e
L_8c5f5e:
	bl.d L_8e46f4
L_8c5f62:
	mov_s r0,r13
L_8c5f64:
	b L_8c0254
	.global L_8c5f68
L_8c5f68:
	mov_s r0,blink
L_8c5f6a:
	mov_s r1,0x126c
L_8c5f70:
	bl L_8c9b28
L_8c5f74:
	b_s L_8c5f5e
L_8c5f76:
	nop_s
