/* ps_connection_mgr__on_assoc @ 0x8c3388, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ps_connection_mgr.cpp
 * Зовут его: ps_conn_mgr__dispatch
 * Зовёт сам: PS_CONNECTION__assoc_ntf, __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__by_cid, fw_sysassert_fatal
 * Глобалы (через gp): 0x80025c, 0x800424
 */
	.section .text.ps_connection_mgr__on_assoc,"ax",@progbits
	.global ps_connection_mgr__on_assoc
ps_connection_mgr__on_assoc:
	.byte 0x4f
	.byte 0xfe
	.global sub_8c338a
sub_8c338a:
L_8c338a:
	nop_s
	.global L_8c338c
L_8c338c:
	push_s blink
L_8c338e:
	bl L_8c02c4
L_8c3392:
	bl.d L_8c9e44
L_8c3396:
	mov_s r13,r0
L_8c3398:
	mov.f r14,r0
L_8c339c:
	beq_s L_8c33bc
	.global L_8c339e
L_8c339e:
	ld_s r1,[r14,0xc]
L_8c33a0:
	ld_s r1,[r1,0x50]
L_8c33a2:
	mov_s r0,0x0
L_8c33a4:
	cmp_s r1,0x2
L_8c33a6:
	cmp.ne r1,0x3
L_8c33aa:
	mov.eq r0,0x1
L_8c33ae:
	extb.f 0x0,r0
L_8c33b2:
	bne_s L_8c33d2
L_8c33b4:
	ld_s r0,[gp,0x2b4]
L_8c33b6:
	breq_s r0,0,L_8c33d2
L_8c33b8:
	mov_s r2,0x1
L_8c33ba:
	b_s L_8c33d4
	.global L_8c33bc
L_8c33bc:
	mov_s r0,blink
L_8c33be:
	mov_s r2,0x1002840
L_8c33c4:
	mov_s r1,0x1428
L_8c33ca:
	bl.d L_8c82c0
L_8c33ce:
	mov_s r3,0x2d
L_8c33d0:
	b_s L_8c339e
	.global L_8c33d2
L_8c33d2:
	mov_s r2,0x0
	.global L_8c33d4
L_8c33d4:
	ld_s r0,[gp,0xec]
L_8c33d6:
	mul64 r13,0xf4
L_8c33da:
	bset r0,r0,r13
L_8c33de:
	st.as r0,[gp,0x3b]
L_8c33e2:
	add r0,mlo,0x80361c
L_8c33ea:
	bl.d L_8c3308
L_8c33ee:
	mov_s r1,r14
L_8c33f0:
	b L_8c0334
