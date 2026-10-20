/* silent_rssi__calibrate_single_rf_module @ 0x8c58c4, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__run_calibration_fragment
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, calib__classify_by_thresholds, calib_silent_rssi_sparrow__find_rf_gain, hwd__setup_pair, hwd_abif__dvs_rfca_cmd_enable, rf_cfg__get_rf_mask_45e, rfc__restore_txrx_sets_fw, rfc_field_write, ut_hw_modes__chain_3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__calibrate_single_rf_module
silent_rssi__calibrate_single_rf_module:
	.global L_8c58c4
L_8c58c4:
	sub_s sp,sp,0x4
L_8c58c6:
	push_s blink
L_8c58c8:
	bl L_8c01c8
L_8c58cc:
	mov_s r20,r1
L_8c58ce:
	mov_s r14,r0
L_8c58d0:
	mov_s r18,r2
L_8c58d2:
	mov_s r13,0x0
L_8c58d4:
	stb.a r13,[sp,-0xc]
L_8c58d8:
	mov r17,sp
L_8c58dc:
	mov r21,0x0
L_8c58e0:
	bset r21,r21,r2
L_8c58e4:
	extb r19,r21
L_8c58e8:
	mov_s r0,0x8042c8
L_8c58ee:
	bl.d L_8ccb3c
L_8c58f2:
	mov_s r16,r0
L_8c58f4:
	mov_s r15,r0
L_8c58f6:
	mov_s r1,r0
L_8c58f8:
	b_s L_8c5902
	.global L_8c58fa
L_8c58fa:
	sub_s r0,r1,0x1
L_8c58fc:
	and_s r1,r1,r0
L_8c58fe:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8c5900:
	extw_s r13,r13
	.global L_8c5902
L_8c5902:
	brne_s r1,0,L_8c58fa
L_8c5904:
	brlt r13,0x2,L_8c591c
L_8c5908:
	bic r0,r15,r21
L_8c590c:
	extb_s r0,r0
L_8c590e:
	bl.d L_8ce910
L_8c5912:
	mov_s r1,r17
L_8c5914:
	mov_s r0,0x0
L_8c5916:
	bl.d L_8d33f8
L_8c591a:
	mov_s r17,r0
	.global L_8c591c
L_8c591c:
	mov_s r1,r17
L_8c591e:
	bl.d L_8ce910
L_8c5922:
	mov_s r0,r19
L_8c5924:
	mov_s r0,r14
L_8c5926:
	bl.d L_8e2d5c
L_8c592a:
	mov_s r1,r18
L_8c592c:
	ld r0,[r16,0x468]
L_8c5934:
	brne r0,0x3,L_8c5944
L_8c5938:
	ldb r3,[r14, 0xb4]
L_8c593c:
	ldb.x r0,[gp, 0xc7]
L_8c5940:
	add_s r3,r3,r0
L_8c5942:
	b_s L_8c598a
	.global L_8c5944
L_8c5944:
	cmp_s r0,0x2
L_8c5946:
	cmp.ne r0,0x1
L_8c594a:
	bne_s L_8c5986
L_8c594c:
	mov_s r0,0x0
L_8c594e:
	mov_s r1,r15
L_8c5950:
	b_s L_8c595a
	.global L_8c5952
L_8c5952:
	sub_s r2,r1,0x1
L_8c5954:
	and_s r1,r1,r2
L_8c5956:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c5958:
	extw_s r0,r0
	.global L_8c595a
L_8c595a:
	brne_s r1,0,L_8c5952
L_8c595c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c595e:
	sexb_s r0,r0
L_8c5960:
	cmp_s r0,0x0
L_8c5962:
	mov.lt r0,0x0
L_8c5966:
	blt_s L_8c596c
L_8c5968:
	min r0,r0,0x7
	.global L_8c596c
L_8c596c:
	mov_s r2,0x802224
L_8c5972:
	ld_s r1,[r2]
L_8c5974:
	add_s r0,r0,sp
L_8c5976:
	ld_s r2,[r2,0x4]
L_8c5978:
	st_s r1,[sp,0x4]
L_8c597a:
	st_s r2,[sp,0x8]
L_8c597c:
	ldb_s r0,[r0,0x4]
L_8c597e:
	ldb r3,[r14, 0xb4]
L_8c5982:
	sub_s r3,r3,r0
L_8c5984:
	b_s L_8c598a
	.global L_8c5986
L_8c5986:
	ldb r3,[r14, 0xb4]
	.global L_8c598a
L_8c598a:
	lsr r2,r20,0x14
L_8c598e:
	mov_s r0,r14
L_8c5990:
	bl.d L_8ca8fc
L_8c5994:
	mov_s r1,r18
L_8c5996:
	brlt.d r13,0x2,L_8c59b2
L_8c599a:
	mov_s r16,r0
L_8c599c:
	bl.d L_8d7500
L_8c59a0:
	mov_s r0,r15
L_8c59a2:
	bl L_8d3460
L_8c59a6:
	mov_s r0,0x0
L_8c59a8:
	mov r1,0x44c
L_8c59ac:
	bl.d L_8d4308
L_8c59b0:
	mov_s r2,0x1
	.global L_8c59b2
L_8c59b2:
	ldb_s r0,[sp,0x0]
L_8c59b4:
	bl.d L_8ce910
L_8c59b8:
	mov_s r1,0x0
L_8c59ba:
	mov_s r0,r16
L_8c59bc:
	mov_s r12,0x8
L_8c59be:
	b.d L_8c021e
L_8c59c2:
	add_s sp,sp,0xc
