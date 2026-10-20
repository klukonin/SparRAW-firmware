/* hwf_vga_dc__calibrate @ 0x8d67d8, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_row_step, calib_silent_rssi_sparrow__correction_alg, calib_vga_gain_step, hwf_dc_calib_fix_dac1
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, fw_sysassert_fatal, hwd_abif__rx_table_config_vga_dc, hwd_abif__rx_table_index_force_mode, hwd_abif__rx_table_read_vga_dc, hwf_vga_dc__measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_vga_dc__calibrate
hwf_vga_dc__calibrate:
	.global L_8d67d8
L_8d67d8:
	push_s blink
L_8d67da:
	bl L_8c01bc
L_8d67de:
	mov_s r15,r0
L_8d67e0:
	mov_s r17,r1
L_8d67e2:
	st.a r2,[sp,-0xc]
L_8d67e6:
	mov_s r23,r3
L_8d67e8:
	mov_s r0,0x8037f8
L_8d67ee:
	ld_s r0,[r0]
L_8d67f0:
	mov_s r13,r4
L_8d67f2:
	st_s r0,[sp,0x4]
L_8d67f4:
	mov_s r14,0x1
L_8d67f6:
	mov r16,0x4
	.global L_8d67fa
L_8d67fa:
	extb r2,r17
L_8d67fe:
	mov_s r0,r15
L_8d6800:
	bl.d L_8cf718
L_8d6804:
	mov_s r1,r14
L_8d6806:
	sub r22,sp,0x1
L_8d680a:
	add r12,r22,r14
L_8d680e:
	stb_s r0,[r12,0x4]
L_8d6810:
	sub r16,r16,0x1
L_8d6814:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d6816:
	brhs.d r16,0x1,L_8d67fa
L_8d681a:
	extb_s r14,r14
L_8d681c:
	mov_s r0,0x0
L_8d681e:
	bl.d L_8cf5a8
L_8d6822:
	mov_s r1,r0
L_8d6824:
	mov_s r0,0x1
L_8d6826:
	bl.d L_8cf5a8
L_8d682a:
	mov_s r1,r15
L_8d682c:
	mov_s r0,r17
L_8d682e:
	bl.d L_8d6ad4
L_8d6832:
	ld_s r1,[sp,0x0]
L_8d6834:
	lsr r1,r0,0x1f
L_8d6838:
	abs_s r2,r0
L_8d683a:
	extb_s r2,r2
L_8d683c:
	cmp r23,r2
L_8d6840:
	mov r24,0x1
L_8d6844:
	sub.ge r24,r24,r24
L_8d6848:
	mov_s r3,r24
L_8d684a:
	add r14,r22,r13
L_8d684e:
	ldb_s r14,[r14,0x4]
L_8d6850:
	b_s L_8d68de
	.global L_8d6852
L_8d6852:
	brne r19,0x0,L_8d6860
L_8d6856:
	add r14,r18,0x1
L_8d685a:
	min r14,r14,0x1f
L_8d685e:
	b_s L_8d6868
	.global L_8d6860
L_8d6860:
	sub r14,r18,0x1
L_8d6864:
	max r14,r14,0x0
	.global L_8d6868
L_8d6868:
	extb_s r14,r14
L_8d686a:
	extb r16,r17
L_8d686e:
	mov_s r0,r15
L_8d6870:
	mov_s r1,r13
L_8d6872:
	mov_s r2,r16
L_8d6874:
	bl.d L_8cf36c
L_8d6878:
	mov_s r3,r14
L_8d687a:
	mov_s r0,0x0
L_8d687c:
	bl.d L_8cf5a8
L_8d6880:
	mov_s r1,r0
L_8d6882:
	mov_s r0,0x1
L_8d6884:
	bl.d L_8cf5a8
L_8d6888:
	mov_s r1,r15
L_8d688a:
	mov_s r0,r17
L_8d688c:
	bl.d L_8d6ad4
L_8d6890:
	ld_s r1,[sp,0x0]
L_8d6892:
	lsr r1,r0,0x1f
L_8d6896:
	abs_s r2,r0
L_8d6898:
	extb_s r2,r2
L_8d689a:
	brne r1,r19,L_8d68aa
L_8d689e:
	cmp_s r0,0x0
L_8d68a0:
	cmp.ne r14,0x1f
L_8d68a4:
	cmp.ne r14,0x0
L_8d68a8:
	bne_s L_8d68ce
	.global L_8d68aa
L_8d68aa:
	brge r20,r2,L_8d68c0
L_8d68ae:
	mov_s r0,r15
L_8d68b0:
	mov_s r1,r13
L_8d68b2:
	mov_s r2,r16
L_8d68b4:
	bl.d L_8cf36c
L_8d68b8:
	mov_s r3,r18
L_8d68ba:
	mov_s r2,r20
L_8d68bc:
	mov_s r1,r19
L_8d68be:
	mov_s r0,r21
	.global L_8d68c0
L_8d68c0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d68c2:
	extb_s r13,r13
L_8d68c4:
	brlt r13,0x1,L_8d68ce
L_8d68c8:
	add r14,r22,r13
L_8d68cc:
	ldb_s r14,[r14,0x4]
	.global L_8d68ce
L_8d68ce:
	cmp_s r2,r23
L_8d68d0:
	mov.le r3,0x0
L_8d68d4:
	ble_s L_8d68de
L_8d68d6:
	cmp_s r13,0x0
L_8d68d8:
	mov_s r3,0x1
L_8d68da:
	sub.le r3,r3,r3
	.global L_8d68de
L_8d68de:
	mov_s r21,r0
L_8d68e0:
	mov_s r19,r1
L_8d68e2:
	mov_s r20,r2
L_8d68e4:
	mov_s r18,r14
L_8d68e6:
	breq r3,0x1,L_8d6852
L_8d68ea:
	brne r24,0x1,L_8d6924
L_8d68ee:
	mov_s r14,0x1
L_8d68f0:
	mov_s r13,0x4
	.global L_8d68f2
L_8d68f2:
	extb r2,r17
L_8d68f6:
	mov_s r0,r15
L_8d68f8:
	bl.d L_8cf718
L_8d68fc:
	mov_s r1,r14
L_8d68fe:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8d6900:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d6902:
	brhs.d r13,0x1,L_8d68f2
L_8d6906:
	extb_s r14,r14
L_8d6908:
	brlt r15,0x1,L_8d692c
L_8d690c:
	cmp_s r15,0x3f
L_8d690e:
	bgt_s L_8d692c
	.global L_8d6910
L_8d6910:
	asl r0,r17,0x6
L_8d6914:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d6916:
	add_s r0,r0,r15
L_8d6918:
	add r1,r0,0x853840
L_8d6920:
	stb r21,[r1]
	.global L_8d6924
L_8d6924:
	brge r23,r20,L_8d693a
L_8d6928:
	mov_s r0,0x2
L_8d692a:
	b_s L_8d6942
	.global L_8d692c
L_8d692c:
	mov_s r0,blink
L_8d692e:
	mov_s r1,0x12f2
L_8d6934:
	bl L_8c9b28
L_8d6938:
	b_s L_8d6910
	.global L_8d693a
L_8d693a:
	cmp r24,0x1
L_8d693e:
	mov_s r0,0x1
L_8d6940:
	sub_s.ne r0,r0,r0
	.global L_8d6942
L_8d6942:
	b.d L_8c0204
L_8d6946:
	add_s sp,sp,0xc
