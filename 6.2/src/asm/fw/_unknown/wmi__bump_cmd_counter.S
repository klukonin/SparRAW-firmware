/* wmi__bump_cmd_counter @ 0x8dd4b8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__by_cid, link_stats__fill_sta_entry, mem_pool__alloc_locked, rx_mgmt_prs__alloc_ei, wmi_evt__post
 * Глобалы (через gp): 0x80024c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__bump_cmd_counter
wmi__bump_cmd_counter:
	.global L_8dd4b8
L_8dd4b8:
	push_s blink
L_8dd4ba:
	bl L_8c01dc
L_8dd4be:
	mov_s r16,r0
L_8dd4c0:
	ldb_s r0,[gp,0xc8]
L_8dd4c2:
	mov_s r14,r1
L_8dd4c4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dd4c6:
	extb_s r0,r0
L_8dd4c8:
	sub_s sp,sp,0x4
L_8dd4ca:
	stb r0,[gp, 0xc8]
L_8dd4ce:
	brne r0,0x3c,L_8dd4d8
L_8dd4d2:
	mov_s r0,0x0
L_8dd4d4:
	stb r0,[gp, 0xc8]
	.global L_8dd4d8
L_8dd4d8:
	bl.d L_8cbffc
L_8dd4dc:
	ldb_s r0,[r14]
L_8dd4de:
	breq_s r0,0,L_8dd520
L_8dd4e0:
	ld_s r1,[r14,0x4]
L_8dd4e2:
	mov_s r14,0x0
L_8dd4e4:
	add3 r13,r0,0xe
L_8dd4e8:
	brne_s r1,0,L_8dd518
L_8dd4ea:
	bl.d L_8c33d0
L_8dd4ee:
	mov_s r0,r16
L_8dd4f0:
	mov_s r15,r0
L_8dd4f2:
	mov_s r0,r13
L_8dd4f4:
	bl.d L_8ca554
L_8dd4f8:
	mov_s r1,r15
L_8dd4fa:
	st_s r14,[sp,0x0]
L_8dd4fc:
	mov_s r0,r16
L_8dd4fe:
	mov_s r1,r15
L_8dd500:
	mov_s r2,r14
L_8dd502:
	mov_s r3,0x1863
L_8dd508:
	mov r4,0x2c
L_8dd50c:
	mov_s r5,r14
L_8dd50e:
	mov_s r6,r14
L_8dd510:
	bl.d L_8e4fc4
L_8dd514:
	mov_s r7,r14
L_8dd516:
	b_s L_8dd520
	.global L_8dd518
L_8dd518:
	mov_s r0,r13
L_8dd51a:
	bl.d L_8e0a78
L_8dd51e:
	mov_s r2,r14
	.global L_8dd520
L_8dd520:
	b.d L_8c0244
L_8dd524:
	add_s sp,sp,0x4
L_8dd526:
	nop_s
