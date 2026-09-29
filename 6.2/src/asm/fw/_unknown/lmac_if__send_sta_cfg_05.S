/* lmac_if__send_sta_cfg_05 @ 0x8e7604, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__teardown_mac_rules, conn_main_sm__action_8e7a3c
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if__send_sta_cfg_05
lmac_if__send_sta_cfg_05:
	.global L_8e7604
L_8e7604:
	push_s blink
L_8e7606:
	bl L_8c01e4
L_8e760a:
	mov_s r13,r0
L_8e760c:
	bl.d L_8c3284
L_8e7610:
	mov_s r14,r1
L_8e7612:
	st_s r14,[r0,0x10]
L_8e7614:
	ldb_s r1,[r13,0x8]
L_8e7616:
	add3 r3,r13,0xe
L_8e761a:
	stb_s r1,[r0,0xc]
L_8e761c:
	ldb_s r1,[r3,0x12]
L_8e761e:
	mov_s r2,0x8042c8
L_8e7624:
	stw_s r1,[r0,0x2]
L_8e7626:
	ldb_s r1,[r2]
L_8e7628:
	stb_s r1,[r0]
L_8e762a:
	ldb_s r1,[r3,0x11]
L_8e762c:
	stw_s r1,[r0,0x6]
L_8e762e:
	ldb_s r1,[r2]
L_8e7630:
	stb_s r1,[r0,0x4]
L_8e7632:
	ld_s r3,[r13,0x18]
L_8e7634:
	ld_s r3,[r3,0x50]
L_8e7636:
	mov_s r1,0x0
L_8e7638:
	cmp_s r3,0x2
L_8e763a:
	cmp.ne r3,0x3
L_8e763e:
	mov.eq r1,0x1
L_8e7642:
	extb.f 0x0,r1
L_8e7646:
	beq_s L_8e7652
L_8e7648:
	stw 0xffff,[r0, 0xa]
L_8e7650:
	b_s L_8e7656
	.global L_8e7652
L_8e7652:
	ldw_s r1,[r13,0xc]
L_8e7654:
	stw_s r1,[r0,0xa]
	.global L_8e7656
L_8e7656:
	ldb_s r1,[r2]
L_8e7658:
	mov_s r3,0x803c00
L_8e765e:
	stb_s r1,[r0,0x8]
L_8e7660:
	mov_s r1,0x0
L_8e7662:
	stw_s r1,[r0,0xe]
L_8e7664:
	ld_s r1,[r3,0xc]
L_8e7666:
	add r2,r0,0x20
L_8e766a:
	stb_s r1,[r2,0x4]
L_8e766c:
	ld_s r1,[r3,0xc]
L_8e766e:
	brne r1,0x1,L_8e767a
L_8e7672:
	ldb_s r1,[r3,0x14]
L_8e7674:
	stb_s r1,[r2,0x5]
L_8e7676:
	ldb_s r1,[r3,0x15]
L_8e7678:
	stb_s r1,[r2,0x6]
	.global L_8e767a
L_8e767a:
	ld_s r1,[r13,0x1c]
L_8e767c:
	st_s r1,[r0,0x1c]
L_8e767e:
	ldw_s r1,[r13,0x20]
L_8e7680:
	stw_s r1,[r2]
L_8e7682:
	mov_s r1,0x5
L_8e7684:
	mov_s r2,0x28
L_8e7686:
	bl.d L_8e5204
L_8e768a:
	mov_s r3,0x0
L_8e768c:
	b L_8c0254
