/* hwf_dc_calib_fix_dac1 @ 0x8d6948, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Post:hwf_dc_calib_measure_and_fix_dac1: Row %d, DC measured_7b (I)= %d ; (Q)= %d
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib_all
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit3, fw_sysassert_fatal, hwd_abif__rx_table_config_vga_dc, hwd_abif__rx_table_index_force_mode, hwd_phy__rx_cal_corr, hwf_vga_dc__calibrate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_dc_calib_fix_dac1
hwf_dc_calib_fix_dac1:
	.global L_8d6948
L_8d6948:
	push_s blink
L_8d694a:
	bl L_8c01cc
L_8d694e:
	sub_s sp,sp,0x14
L_8d6950:
	mov_s r13,r0
L_8d6952:
	mov_s r14,r1
L_8d6954:
	mov_s r16,r2
L_8d6956:
	brne r2,0x1,L_8d6a0a
	.global L_8d695a
L_8d695a:
	cmp_s r14,r13
L_8d695c:
	bcs L_8d6a5c
L_8d6960:
	sub r0,r14,r13
L_8d6964:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_8d6966
L_8d6966:
	mov_s r18,r13
L_8d6968:
	mov_s r19,r0
L_8d696a:
	mov r17,sp
L_8d696e:
	mov r20,0x400
L_8d6972:
	extb_s r13,r13
L_8d6974:
	brne r16,0x1,L_8d69c0
L_8d6978:
	mov_s r0,r13
L_8d697a:
	mov_s r1,0x2
L_8d697c:
	mov_s r2,0x0
L_8d697e:
	bl.d L_8cf36c
L_8d6982:
	mov_s r3,0xf
L_8d6984:
	mov_s r0,r13
L_8d6986:
	mov_s r1,0x3
L_8d6988:
	mov_s r2,0x0
L_8d698a:
	bl.d L_8cf36c
L_8d698e:
	mov_s r3,0xf
L_8d6990:
	mov_s r0,r13
L_8d6992:
	mov_s r1,0x4
L_8d6994:
	mov_s r2,0x0
L_8d6996:
	bl.d L_8cf36c
L_8d699a:
	mov_s r3,0xf
L_8d699c:
	mov_s r0,r13
L_8d699e:
	mov_s r1,0x2
L_8d69a0:
	mov_s r2,0x1
L_8d69a2:
	bl.d L_8cf36c
L_8d69a6:
	mov_s r3,0xf
L_8d69a8:
	mov_s r0,r13
L_8d69aa:
	mov_s r1,0x3
L_8d69ac:
	mov_s r2,0x1
L_8d69ae:
	bl.d L_8cf36c
L_8d69b2:
	mov_s r3,0xf
L_8d69b4:
	mov_s r0,r13
L_8d69b6:
	mov_s r1,0x4
L_8d69b8:
	mov_s r2,0x1
L_8d69ba:
	bl.d L_8cf36c
L_8d69be:
	mov_s r3,0xf
	.global L_8d69c0
L_8d69c0:
	mov_s r0,0x0
L_8d69c2:
	bl.d L_8cf5a8
L_8d69c6:
	mov_s r1,r13
L_8d69c8:
	mov_s r0,0x1
L_8d69ca:
	bl.d L_8cf5a8
L_8d69ce:
	mov_s r1,r13
L_8d69d0:
	bl.d L_8d23a0
L_8d69d4:
	mov_s r0,r17
L_8d69d6:
	mov_s r15,0x2
L_8d69d8:
	mov_s r14,0x0
	.global L_8d69da
L_8d69da:
	mov_s r0,r13
L_8d69dc:
	mov_s r1,r14
L_8d69de:
	mov_s r2,0xa
L_8d69e0:
	mov_s r3,0x2
L_8d69e2:
	bl.d L_8d67d8
L_8d69e6:
	mov r4,0x1
L_8d69ea:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8d69ec:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d69ee:
	brhs.d r15,0x1,L_8d69da
L_8d69f2:
	extb_s r14,r14
L_8d69f4:
	bl.d L_8d23a0
L_8d69f8:
	mov_s r0,r17
L_8d69fa:
	ld_s r1,[sp,0x0]
L_8d69fc:
	brlt.d r1,0x0,L_8d6a20
L_8d6a00:
	ld_s r0,[sp,0x4]
L_8d6a02:
	add_s r1,r1,r20
L_8d6a04:
	asr_s r1,r1,0xb
L_8d6a06:
	sexb_s r3,r1
L_8d6a08:
	b_s L_8d6a2a
	.global L_8d6a0a
L_8d6a0a:
	cmp r16,0x2
L_8d6a0e:
	mov.ne r0,blink
L_8d6a12:
	mov.ne r1,0x117a
L_8d6a1a:
	bl.ne L_8c9b28
L_8d6a1e:
	b_s L_8d695a
	.global L_8d6a20
L_8d6a20:
	sub r2,r20,r1
L_8d6a24:
	asr_s r2,r2,0xb
L_8d6a26:
	neg_s r2,r2
L_8d6a28:
	sexb_s r3,r2
	.global L_8d6a2a
L_8d6a2a:
	brlt.d r0,0x0,L_8d6a38
L_8d6a2e:
	mov_s r1,r20
L_8d6a30:
	add_s r0,r0,r1
L_8d6a32:
	asr_s r0,r0,0xb
L_8d6a34:
	sexb_s r13,r0
L_8d6a36:
	b_s L_8d6a40
	.global L_8d6a38
L_8d6a38:
	sub_s r1,r1,r0
L_8d6a3a:
	asr_s r1,r1,0xb
L_8d6a3c:
	neg_s r1,r1
L_8d6a3e:
	sexb_s r13,r1
	.global L_8d6a40
L_8d6a40:
	mov_s r1,0x101c8c4
L_8d6a46:
	mov_s r0,0x26
L_8d6a48:
	mov_s r2,r18
L_8d6a4a:
	bl.d L_8dcd00
L_8d6a4e:
	mov_s r4,r13
L_8d6a50:
	sub r0,r19,0x1
L_8d6a54:
	brhs.d r0,0x1,L_8d6966
L_8d6a58:
	add r13,r18,0x1
	.global L_8d6a5c
L_8d6a5c:
	b.d L_8c0224
L_8d6a60:
	add_s sp,sp,0x14
L_8d6a62:
	nop_s
