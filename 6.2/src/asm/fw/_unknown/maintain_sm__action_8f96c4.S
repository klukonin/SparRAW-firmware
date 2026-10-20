/* maintain_sm__action_8f96c4 @ 0x8f96c4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__get_cid_of_obj, lmac_if_send_cmd_0x0f, maintain_sm__get_mid_idx, maintain_sm__lock_radio, mid_list__by_mid_fw, obj_vt802cc4__noop_vmethod
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__action_8f96c4
maintain_sm__action_8f96c4:
	.global L_8f96c4
L_8f96c4:
	push_s blink
L_8f96c6:
	bl L_8c01e4
L_8f96ca:
	mov_s r14,r0
L_8f96cc:
	mov_s r0,0x1
L_8f96ce:
	stb_s r0,[r14,0x3]
L_8f96d0:
	bl.d L_8cc3d4
L_8f96d4:
	ld_s r0,[r14,0x8]
L_8f96d6:
	bl L_8cc3dc
L_8f96da:
	ld_s r0,[r0,0x50]
L_8f96dc:
	mov_s r1,0x0
L_8f96de:
	cmp_s r0,0x2
L_8f96e0:
	cmp.ne r0,0x3
L_8f96e4:
	mov.ne r0,r1
L_8f96e8:
	bne_s L_8f96ec
L_8f96ea:
	mov_s r0,0x1
	.global L_8f96ec
L_8f96ec:
	extb_s r0,r0
L_8f96ee:
	st_s r0,[r14,0x7c]
L_8f96f0:
	mov_s r13,0x0
L_8f96f2:
	st_s r13,[r14,0x1c]
L_8f96f4:
	st_s r13,[r14,0x20]
L_8f96f6:
	st_s r13,[r14,0x24]
L_8f96f8:
	st_s r13,[r14,0x28]
L_8f96fa:
	st_s r13,[r14,0x78]
L_8f96fc:
	st.as r13,[gp,-0x20]
L_8f9700:
	st r13,[r14, 0x80]
L_8f9704:
	bl.d L_8c67b8
L_8f9708:
	mov_s r0,r14
L_8f970a:
	bl.d L_8cbeb8
L_8f970e:
	ld_s r0,[r14,0x8]
L_8f9710:
	extb_s r0,r0
L_8f9712:
	bl.d L_8dbd74
L_8f9716:
	mov_s r1,0x1
L_8f9718:
	ld_s r0,[r14,0xc]
L_8f971a:
	stb_s r13,[r14,0x18]
L_8f971c:
	cmp_s r0,0x1
L_8f971e:
	bl.ne.d L_8e2904
L_8f9722:
	mov.ne r0,r14
L_8f9726:
	b L_8c0254
L_8f972a:
	nop_s
