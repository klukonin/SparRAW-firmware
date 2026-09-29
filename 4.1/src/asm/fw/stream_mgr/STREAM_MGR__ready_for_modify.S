/* STREAM_MGR__ready_for_modify @ 0x8ddfc0, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   STREAM_MGR::ready_for_modify: vring stopped for index %d.
 *   stream_mgr.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, frag_8f1908, fw_log__emit1, fw_sysassert_fatal, vring__get_pring_id
 */
	.section .text.STREAM_MGR__ready_for_modify,"ax",@progbits
	.global STREAM_MGR__ready_for_modify
STREAM_MGR__ready_for_modify:
L_8ddfc0:
	push_s blink
L_8ddfc2:
	bl.d L_8c02c4
L_8ddfc6:
	mov_s r1,0x2
L_8ddfc8:
	mov_s r13,r0
L_8ddfca:
	mov_s r2,0x100e788
L_8ddfd0:
	mov_s r0,0xb
L_8ddfd2:
	bl.d L_8edfcc
L_8ddfd6:
	mov_s r3,r13
L_8ddfd8:
	mov_s r0,0x8485dc
L_8ddfde:
	sub3 r0,r0,0x100
L_8ddfe2:
	add2_s r0,r0,r13
L_8ddfe4:
	ld r13,[r0,0x818]
L_8ddfec:
	breq_s r13,0,L_8de01c
	.global L_8ddfee
L_8ddfee:
	ldb_s r0,[r13,0x7]
L_8ddff0:
	breq r0,0x9,L_8de018
L_8ddff4:
	ld_s r0,[r13,0xc]
L_8ddff6:
	brne_s r0,0,L_8de00e
L_8ddff8:
	bl.d L_8c9d94
L_8ddffc:
	mov_s r0,r13
L_8ddffe:
	bl L_8c9e44
L_8de002:
	mov.f r14,r0
L_8de006:
	beq_s L_8de032
	.global L_8de008
L_8de008:
	bl.d L_8f1908
L_8de00c:
	mov_s r0,r14
	.global L_8de00e
L_8de00e:
	ld r0,[r13, 0xd4]
L_8de012:
	ld_s r1,[r0,0x10]
L_8de014:
	jl_s.d [r1]
L_8de016:
	mov_s r0,r13
	.global L_8de018
L_8de018:
	b L_8c0334
	.global L_8de01c
L_8de01c:
	mov_s r0,blink
L_8de01e:
	mov_s r2,0x100e398
L_8de024:
	mov_s r1,0x128d
L_8de02a:
	bl.d L_8c82c0
L_8de02e:
	mov_s r3,0xca
L_8de030:
	b_s L_8ddfee
	.global L_8de032
L_8de032:
	mov_s r0,blink
L_8de034:
	mov_s r2,0x100e398
L_8de03a:
	mov_s r1,0x128e
L_8de040:
	bl.d L_8c82c0
L_8de044:
	mov_s r3,0xd3
L_8de046:
	b_s L_8de008
