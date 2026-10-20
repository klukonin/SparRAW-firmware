/* mid__setup_bcast_vring @ 0x8e1360, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: encap_trans_type, wmi_handler_bcast_vring_cfg
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, mac_enable_bcast_ring, mid__type_of, rgf_reg_881b00_8db324, sw_vring__set_ba_params, vring__init_bcast_ctx, vring__program_tx_desc_and_ba, vring_by_index
 */
	.section .text.mid__setup_bcast_vring,"ax",@progbits
	.global mid__setup_bcast_vring
mid__setup_bcast_vring:
	.global L_8e1360
L_8e1360:
	push_s blink
L_8e1362:
	bl.d L_8c02ac
L_8e1366:
	mov r4,0x0
L_8e136a:
	sub_s sp,sp,0xc
L_8e136c:
	mov_s r17,r1
L_8e136e:
	mov_s r13,r2
L_8e1370:
	mov_s r15,r5
L_8e1372:
	mov r16,r6
L_8e1376:
	mov r18,r7
L_8e137a:
	ldb r6,[sp, 0x30]
L_8e137e:
	ld_s r14,[sp,0x3c]
L_8e1380:
	ld r7,[sp, 0x38]
L_8e1384:
	st_s r14,[sp,0x0]
L_8e1386:
	bl.d L_8d6638
L_8e138a:
	mov_s r5,r1
L_8e138c:
	bl.d L_8cacc0
L_8e1390:
	mov_s r0,r17
L_8e1392:
	mov_s r19,r0
L_8e1394:
	breq_s r14,0,L_8e13b4
L_8e1396:
	mov_s r1,0x801f64
L_8e139c:
	ld_s r0,[r1]
L_8e139e:
	ldb r4,[sp, 0x34]
L_8e13a2:
	st_s r0,[sp,0x4]
L_8e13a4:
	ldw_s r0,[r1,0x4]
L_8e13a6:
	add_s r1,sp,0x4
L_8e13a8:
	stw r0,[sp, 0x8]
L_8e13ac:
	mov_s r0,r19
L_8e13ae:
	mov_s r2,r1
L_8e13b0:
	mov_s r3,0x8
L_8e13b2:
	b_s L_8e13ce
	.global L_8e13b4
L_8e13b4:
	ld_s r0,[r13,0xc]
L_8e13b6:
	add r20,r13,0x10
L_8e13ba:
	add r17,r0,0xa
L_8e13be:
	bl.d L_8cabe4
L_8e13c2:
	ldb_s r13,[r13,0x8]
L_8e13c4:
	mov_s r4,r0
L_8e13c6:
	mov_s r0,r19
L_8e13c8:
	mov_s r1,r20
L_8e13ca:
	mov_s r2,r17
L_8e13cc:
	mov_s r3,r13
	.global L_8e13ce
L_8e13ce:
	bl.d L_8c5e88
L_8e13d2:
	mov r5,0xff
L_8e13d6:
	cmp_s r15,0x0
L_8e13d8:
	cmp.ne r15,0x1
L_8e13dc:
	beq_s L_8e13e6
L_8e13de:
	bl L_8c1498
L_8e13e2:
	mov_s r1,0x0
L_8e13e4:
	b_s L_8e13ec
	.global L_8e13e6
L_8e13e6:
	bl L_8db324
L_8e13ea:
	mov_s r1,0x1
	.global L_8e13ec
L_8e13ec:
	mov_s r0,r19
L_8e13ee:
	mov_s r2,r18
L_8e13f0:
	mov_s r3,r16
L_8e13f2:
	bl.d L_8c60fc
L_8e13f6:
	mov r4,0x0
L_8e13fa:
	b.d L_8c0304
L_8e13fe:
	add_s sp,sp,0xc
