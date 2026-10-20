/* IF_GAIN__GAIN @ 0x8d2828, 1360 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_if_gain_calibration.c
 *   IF_GAIN::GAIN NOT-CONVERGED  ina_rssi_adc_db=%d   ; rx_packet_rssi_db=%d  (%d iterations)
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf_if_gain_fin_est
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, approx_magnitude, fw_log__emit3, fw_sysassert_fatal, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_agc004_w4, hwd_abif__set_agc208_w4, hwd_phy__read_status_pair, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_884000, hwd_phy__rgf_884100
 * Глобалы (через gp): 0x80020e
 */
	.section .text.IF_GAIN__GAIN,"ax",@progbits
	.global IF_GAIN__GAIN
IF_GAIN__GAIN:
	.global L_8d2828
L_8d2828:
	push_s blink
L_8d282a:
	bl L_8c0298
L_8d282e:
	st.a r0,[sp,-0x6c]
L_8d2832:
	st_s r1,[sp,0x4]
L_8d2834:
	st_s r2,[sp,0x8]
L_8d2836:
	ldb_s r0,[r3,0x2]
L_8d2838:
	ldb r22,[r3, 0x1]
L_8d283c:
	st_s r0,[sp,0xc]
L_8d283e:
	ldb_s r0,[r3,0xe]
L_8d2840:
	ldb r18,[r3, 0x6]
L_8d2844:
	st_s r0,[sp,0x10]
L_8d2846:
	ldb_s r0,[r3,0xf]
L_8d2848:
	ldb r24,[r3, 0x4]
L_8d284c:
	st_s r0,[sp,0x14]
L_8d284e:
	ld_s r0,[sp,0xc]
L_8d2850:
	ldb r16,[r3]
L_8d2854:
	mov_s r14,r3
L_8d2856:
	brhs.d r0,0x13,L_8d28b0
L_8d285a:
	ldb r23,[r3, 0x7]
	.global L_8d285e
L_8d285e:
	brhs r24,0x12,L_8d28c8
	.global L_8d2862
L_8d2862:
	ld_s r0,[sp,0xc]
L_8d2864:
	mov_s r1,0x80174c
L_8d286a:
	ldb_s r0,[r1,r0]
L_8d286c:
	st_s r0,[sp,0x18]
L_8d286e:
	mov_s r0,0x801760
L_8d2874:
	ldb r0,[r0,r24]
L_8d2878:
	st_s r0,[sp,0x1c]
L_8d287a:
	ld_s r0,[sp,0x0]
L_8d287c:
	breq_s r0,0,L_8d28e0
L_8d287e:
	breq r0,0x1,L_8d2902
L_8d2882:
	mov_s r0,blink
L_8d2884:
	mov_s r2,0x1017e9c
L_8d288a:
	mov_s r1,0x1309
L_8d2890:
	mov r3,0x139
L_8d2894:
	mov_s r13,0x7f
L_8d2896:
	st_s r13,[sp,0x20]
L_8d2898:
	mov_s r13,0xff
L_8d289a:
	st_s r13,[sp,0x24]
L_8d289c:
	mov_s r13,0x0
L_8d289e:
	mov_s r20,r13
L_8d28a0:
	mov_s r25,r13
L_8d28a2:
	st_s r13,[sp,0x28]
L_8d28a4:
	mov_s r21,r13
L_8d28a6:
	st_s r13,[sp,0x2c]
L_8d28a8:
	st_s r13,[sp,0x30]
L_8d28aa:
	b.d L_8d2d10
L_8d28ae:
	mov_s r17,r13
	.global L_8d28b0
L_8d28b0:
	mov_s r0,blink
L_8d28b2:
	mov_s r2,0x1017e9c
L_8d28b8:
	mov_s r1,0x147e
L_8d28be:
	bl.d L_8c82c0
L_8d28c2:
	mov r3,0x11c
L_8d28c6:
	b_s L_8d285e
	.global L_8d28c8
L_8d28c8:
	mov_s r0,blink
L_8d28ca:
	mov_s r2,0x1017e9c
L_8d28d0:
	mov_s r1,0x147f
L_8d28d6:
	bl.d L_8c82c0
L_8d28da:
	mov r3,0x11d
L_8d28de:
	b_s L_8d2862
	.global L_8d28e0
L_8d28e0:
	bl.d L_8d0388
L_8d28e4:
	mov_s r0,0x1
	.global L_8d28e6
L_8d28e6:
	mov_s r0,0x7f
L_8d28e8:
	st_s r0,[sp,0x20]
L_8d28ea:
	mov_s r0,0xff
L_8d28ec:
	st_s r0,[sp,0x24]
L_8d28ee:
	mov_s r13,0x0
L_8d28f0:
	mov_s r20,r13
L_8d28f2:
	mov_s r25,r13
L_8d28f4:
	st_s r13,[sp,0x28]
L_8d28f6:
	mov_s r21,r13
L_8d28f8:
	st_s r13,[sp,0x2c]
L_8d28fa:
	st_s r13,[sp,0x30]
L_8d28fc:
	b.d L_8d2b70
L_8d2900:
	mov_s r17,r13
	.global L_8d2902
L_8d2902:
	bl.d L_8cf4fc
L_8d2906:
	mov_s r0,0x1
L_8d2908:
	ld_s r0,[sp,0x4]
L_8d290a:
	cmp_s r0,0x1
L_8d290c:
	mov.eq r0,0xffff
L_8d2914:
	mov.eq r1,0x7
L_8d2918:
	mov.eq r3,0x4d2
L_8d2920:
	bl.eq.d L_8d01e8
L_8d2924:
	mov.eq r2,0xa
L_8d2928:
	b_s L_8d28e6
	.global L_8d292a
L_8d292a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d292c:
	extb_s r0,r0
L_8d292e:
	st_s r0,[sp,0x28]
L_8d2930:
	ld_s r1,[sp,0x18]
L_8d2932:
	mov_s r0,0x1
L_8d2934:
	bl.d L_8d006c
L_8d2938:
	mov_s r2,r1
L_8d293a:
	mov_s r0,r16
L_8d293c:
	bl.d L_8cccb4
L_8d2940:
	ld_s r1,[sp,0x1c]
L_8d2942:
	add1 r15,r18,r18
L_8d2946:
	add_s r15,r15,0x801774
L_8d294c:
	mov_s r0,r16
L_8d294e:
	mov_s r1,0x1
L_8d2950:
	bl.d L_8cccf4
L_8d2954:
	ldb_s r2,[r15]
L_8d2956:
	mov_s r0,r16
L_8d2958:
	mov_s r1,0x2
L_8d295a:
	bl.d L_8cccf4
L_8d295e:
	ldb_s r2,[r15,0x1]
L_8d2960:
	mov_s r0,r16
L_8d2962:
	mov_s r1,0x3
L_8d2964:
	bl.d L_8cccf4
L_8d2968:
	ldb_s r2,[r15,0x2]
L_8d296a:
	mov_s r0,r22
L_8d296c:
	mov_s r1,0x1
L_8d296e:
	bl.d L_8cc0c8
L_8d2972:
	ldb_s r2,[r15]
L_8d2974:
	mov_s r0,r22
L_8d2976:
	mov_s r1,0x2
L_8d2978:
	bl.d L_8cc0c8
L_8d297c:
	ldb_s r2,[r15,0x1]
L_8d297e:
	mov_s r0,r22
L_8d2980:
	mov_s r1,0x3
L_8d2982:
	bl.d L_8cc0c8
L_8d2986:
	ldb_s r2,[r15,0x2]
L_8d2988:
	bl.d L_8cb8d8
L_8d298c:
	mov_s r0,0x0
L_8d298e:
	bl.d L_8cb8d8
L_8d2992:
	mov_s r0,0x1
L_8d2994:
	ldb_s r0,[gp,0x9e]
L_8d2996:
	breq_s r0,0,L_8d29aa
L_8d2998:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d299a:
	add2_s r0,r0,r0
L_8d299c:
	mov lp_count,r0
L_8d29a0:
	nop_s
L_8d29a2:
	lp L_8d29aa
L_8d29a6:
	nop_s
L_8d29a8:
	nop_s
	.global L_8d29aa
L_8d29aa:
	ld_s r0,[sp,0x4]
L_8d29ac:
	breq_s r0,0,L_8d29d8
L_8d29ae:
	breq r0,0x1,L_8d2a50
L_8d29b2:
	cmp_s r0,0x2
L_8d29b4:
	beq_s L_8d2a90
L_8d29b6:
	mov_s r0,blink
L_8d29b8:
	mov_s r2,0x1017e9c
L_8d29be:
	mov_s r1,0x130a
L_8d29c4:
	bl.d L_8c82c0
L_8d29c8:
	mov r3,0x1e0
L_8d29cc:
	mov r19,0x0
L_8d29d0:
	mov_s r1,0x0
L_8d29d2:
	b.d L_8d2b6c
L_8d29d6:
	mov_s r15,0x0
	.global L_8d29d8
L_8d29d8:
	mov_s r13,0x0
L_8d29da:
	bset_s r13,r13,0xf
L_8d29dc:
	bl.d L_8cf4c8
L_8d29e0:
	mov_s r0,0x0
L_8d29e2:
	bl.d L_8cf6f8
L_8d29e6:
	add_s r0,sp,0x34
L_8d29e8:
	ldw.x r0,[sp, 0x34]
L_8d29ec:
	ldw.x r1,[sp, 0x38]
L_8d29f0:
	cmp_s r0,0x0
L_8d29f2:
	add.ge r0,r0,0x2
L_8d29f6:
	asr.ge r0,r0,0x2
L_8d29fa:
	bge_s L_8d2a04
L_8d29fc:
	rsub r2,r0,0x2
L_8d2a00:
	/* asr_s r2,r2,0x2 */
	.byte 0x42,0xba
L_8d2a02:
	neg_s r0,r2
	.global L_8d2a04
L_8d2a04:
	cmp_s r1,0x0
L_8d2a06:
	add.ge r1,r1,0x2
L_8d2a0a:
	asr.ge r1,r1,0x2
L_8d2a0e:
	bge_s L_8d2a18
L_8d2a10:
	rsub r2,r1,0x2
L_8d2a14:
	/* asr_s r2,r2,0x2 */
	.byte 0x42,0xba
L_8d2a16:
	neg_s r1,r2
	.global L_8d2a18
L_8d2a18:
	bl L_8d3708
L_8d2a1c:
	bl.d L_8d406c
L_8d2a20:
	mov_s r1,0x10
L_8d2a22:
	brlt r0,0x0,L_8d2a2c
L_8d2a26:
	add_s r13,r13,r0
L_8d2a28:
	asr_s r13,r13,0x10
L_8d2a2a:
	b_s L_8d2a32
	.global L_8d2a2c
L_8d2a2c:
	sub_s r13,r13,r0
L_8d2a2e:
	asr_s r13,r13,0x10
L_8d2a30:
	neg_s r13,r13
	.global L_8d2a32
L_8d2a32:
	ld_s r15,[sp,0x10]
L_8d2a34:
	sexb_s r13,r13
L_8d2a36:
	sub_s r15,r15,r13
L_8d2a38:
	sexb_s r15,r15
L_8d2a3a:
	abs_s r0,r15
L_8d2a3c:
	extb r19,r0
L_8d2a40:
	ld_s r0,[sp,0x14]
L_8d2a42:
	brge.d r0,r19,L_8d2a8a
L_8d2a46:
	lsr r1,r15,0x1f
	.global L_8d2a4a
L_8d2a4a:
	mov r21,0x0
L_8d2a4e:
	b_s L_8d2b6c
	.global L_8d2a50
L_8d2a50:
	bl.d L_8cf958
L_8d2a54:
	mov_s r0,0x0
L_8d2a56:
	bl.d L_8cf4c8
L_8d2a5a:
	mov_s r0,0x1
L_8d2a5c:
	mov_s r0,0xf0
L_8d2a5e:
	mov lp_count,r0
L_8d2a62:
	nop_s
L_8d2a64:
	lp L_8d2a6c
L_8d2a68:
	nop_s
L_8d2a6a:
	nop_s
	.global L_8d2a6c
L_8d2a6c:
	bl.d L_8d3140
L_8d2a70:
	mov_s r0,0x4
L_8d2a72:
	ld_s r15,[sp,0x10]
L_8d2a74:
	mov_s r17,r0
L_8d2a76:
	sub_s r15,r15,r0
L_8d2a78:
	sexb_s r15,r15
L_8d2a7a:
	abs_s r0,r15
L_8d2a7c:
	extb r19,r0
L_8d2a80:
	ld_s r0,[sp,0x14]
L_8d2a82:
	brlt.d r0,r19,L_8d2a4a
L_8d2a86:
	lsr r1,r15,0x1f
	.global L_8d2a8a
L_8d2a8a:
	mov r21,0x1
L_8d2a8e:
	b_s L_8d2b6c
	.global L_8d2a90
L_8d2a90:
	bl.d L_8cf958
L_8d2a94:
	mov_s r0,0x2
L_8d2a96:
	bl.d L_8cf4c8
L_8d2a9a:
	mov_s r0,0x1
L_8d2a9c:
	bl L_8cfc80
L_8d2aa0:
	mov_s r0,0x3
L_8d2aa2:
	mov r1,0x1ef
L_8d2aa6:
	mov_s r2,0xa
L_8d2aa8:
	bl.d L_8d01e8
L_8d2aac:
	mov r3,0x4d2
L_8d2ab0:
	mov r0,0x140
L_8d2ab4:
	mov lp_count,r0
L_8d2ab8:
	nop_s
L_8d2aba:
	lp L_8d2ac2
L_8d2abe:
	nop_s
L_8d2ac0:
	nop_s
	.global L_8d2ac2
L_8d2ac2:
	bl L_8d02ac
L_8d2ac6:
	mov r0,0x140
L_8d2aca:
	mov lp_count,r0
L_8d2ace:
	nop_s
L_8d2ad0:
	lp L_8d2ad8
L_8d2ad4:
	nop_s
L_8d2ad6:
	nop_s
	.global L_8d2ad8
L_8d2ad8:
	bl.d L_8cf4c8
L_8d2adc:
	mov_s r0,0x0
L_8d2ade:
	bl L_8cfc9c
L_8d2ae2:
	bl.d L_8cf8e8
L_8d2ae6:
	add_s r0,sp,0x34
L_8d2ae8:
	bl L_8cfc80
L_8d2aec:
	mov_s r0,0x883700
L_8d2af2:
	ld_s r0,[r0,0x8]
L_8d2af4:
	mov_s r1,0x7
L_8d2af6:
	bmsk_s r0,r0,0x5
L_8d2af8:
	st_s r0,[sp,0x30]
L_8d2afa:
	ldw r0,[sp, 0x48]
L_8d2afe:
	mov_s r2,0xa
L_8d2b00:
	st_s r0,[sp,0x2c]
L_8d2b02:
	mov_s r0,0xffff
L_8d2b08:
	bl.d L_8d01e8
L_8d2b0c:
	mov r3,0x4d2
L_8d2b10:
	bl.d L_8cf958
L_8d2b14:
	mov_s r0,0x0
L_8d2b16:
	bl.d L_8cf4c8
L_8d2b1a:
	mov_s r0,0x1
L_8d2b1c:
	mov_s r0,0xa0
L_8d2b1e:
	mov lp_count,r0
L_8d2b22:
	nop_s
L_8d2b24:
	lp L_8d2b2c
L_8d2b28:
	nop_s
L_8d2b2a:
	nop_s
	.global L_8d2b2c
L_8d2b2c:
	bl.d L_8d3140
L_8d2b30:
	mov_s r0,0x4
L_8d2b32:
	mov_s r17,r0
L_8d2b34:
	mov_s r0,0x1
L_8d2b36:
	mov_s r1,0xa
L_8d2b38:
	mov_s r2,r0
L_8d2b3a:
	bl.d L_8d01e8
L_8d2b3e:
	mov_s r3,0x64
L_8d2b40:
	bl L_8d02ac
L_8d2b44:
	ld_s r15,[sp,0x10]
L_8d2b46:
	sub r15,r15,r17
L_8d2b4a:
	sexb_s r15,r15
L_8d2b4c:
	abs_s r0,r15
L_8d2b4e:
	extb r19,r0
L_8d2b52:
	ld_s r0,[sp,0x48]
L_8d2b54:
	lsr r1,r15,0x1f
L_8d2b58:
	breq r0,0x3,L_8d2b60
	.global L_8d2b5c
L_8d2b5c:
	mov_s r0,0x0
L_8d2b5e:
	b_s L_8d2b68
	.global L_8d2b60
L_8d2b60:
	ld_s r0,[sp,0x14]
L_8d2b62:
	brlt r0,r19,L_8d2b5c
L_8d2b66:
	mov_s r0,0x1
	.global L_8d2b68
L_8d2b68:
	extb r21,r0
	.global L_8d2b6c
L_8d2b6c:
	brne r21,0x1,L_8d2ba6
	.global L_8d2b70
L_8d2b70:
	brne r21,0x0,L_8d2b7c
L_8d2b74:
	ld_s r0,[sp,0x28]
L_8d2b76:
	cmp_s r0,0x7
L_8d2b78:
	blt L_8d292a
	.global L_8d2b7c
L_8d2b7c:
	ld_s r0,[sp,0x8]
L_8d2b7e:
	cmp r0,0xff
L_8d2b82:
	bne_s L_8d2d16
L_8d2b84:
	ld_s r0,[sp,0x0]
L_8d2b86:
	cmp_s r0,0x1
L_8d2b88:
	mov.eq r0,0xffff
L_8d2b90:
	mov.eq r1,0xa
L_8d2b94:
	mov.eq r3,0x4d2
L_8d2b9c:
	bl.eq.d L_8d01e8
L_8d2ba0:
	mov.eq r2,r1
L_8d2ba4:
	b_s L_8d2d46
	.global L_8d2ba6
L_8d2ba6:
	brne r21,0x0,L_8d2bb0
L_8d2baa:
	ld_s r0,[sp,0x28]
L_8d2bac:
	breq r0,0x7,L_8d2bbc
	.global L_8d2bb0
L_8d2bb0:
	ld_s r0,[sp,0x8]
L_8d2bb2:
	cmp_s r0,0x3
L_8d2bb4:
	beq_s L_8d2c9c
L_8d2bb6:
	bgt_s L_8d2bd6
L_8d2bb8:
	breq_s r0,0,L_8d2be0
L_8d2bba:
	b_s L_8d2cfe
	.global L_8d2bbc
L_8d2bbc:
	ld r4,[sp, 0x30]
L_8d2bc0:
	mov_s r2,0x1017ebc
L_8d2bc6:
	mov_s r0,0x6
L_8d2bc8:
	mov_s r1,0x1
L_8d2bca:
	mov_s r3,r17
L_8d2bcc:
	bl.d L_8ee034
L_8d2bd0:
	ld r5,[sp, 0x28]
L_8d2bd4:
	b_s L_8d2b70
	.global L_8d2bd6
L_8d2bd6:
	breq r0,0x6,L_8d2be6
L_8d2bda:
	cmp r0,0xff
L_8d2bde:
	bne_s L_8d2cfe
	.global L_8d2be0
L_8d2be0:
	mov r21,0x1
L_8d2be4:
	b_s L_8d2b70
	.global L_8d2be6
L_8d2be6:
	brne r23,0x1,L_8d2c62
L_8d2bea:
	ld_s r0,[sp,0x24]
L_8d2bec:
	brlt r0,r19,L_8d2bf8
L_8d2bf0:
	ld_s r0,[sp,0x20]
L_8d2bf2:
	neg_s r0,r0
L_8d2bf4:
	brne r15,r0,L_8d2c62
	.global L_8d2bf8
L_8d2bf8:
	add1 r0,r20,r20
L_8d2bfc:
	add r17,r0,0x801774
L_8d2c04:
	mov_s r0,r16
L_8d2c06:
	mov r21,0x1
L_8d2c0a:
	mov_s r1,r21
L_8d2c0c:
	bl.d L_8cccf4
L_8d2c10:
	ldb r2,[r17]
L_8d2c14:
	mov_s r0,r16
L_8d2c16:
	mov_s r1,0x2
L_8d2c18:
	bl.d L_8cccf4
L_8d2c1c:
	ldb r2,[r17, 0x1]
L_8d2c20:
	mov_s r0,r16
L_8d2c22:
	mov_s r1,0x3
L_8d2c24:
	bl.d L_8cccf4
L_8d2c28:
	ldb r2,[r17, 0x2]
L_8d2c2c:
	mov_s r0,r22
L_8d2c2e:
	mov_s r1,r21
L_8d2c30:
	bl.d L_8cc0c8
L_8d2c34:
	ldb r2,[r17]
L_8d2c38:
	mov_s r0,r22
L_8d2c3a:
	mov_s r1,0x2
L_8d2c3c:
	bl.d L_8cc0c8
L_8d2c40:
	ldb r2,[r17, 0x1]
L_8d2c44:
	mov_s r0,r22
L_8d2c46:
	mov_s r1,0x3
L_8d2c48:
	bl.d L_8cc0c8
L_8d2c4c:
	ldb r2,[r17, 0x2]
L_8d2c50:
	bl.d L_8cb8d8
L_8d2c54:
	mov_s r0,0x0
L_8d2c56:
	bl.d L_8cb8d8
L_8d2c5a:
	mov_s r0,r21
L_8d2c5c:
	mov r18,r20
L_8d2c60:
	b_s L_8d2c90
	.global L_8d2c62
L_8d2c62:
	lsr r0,r23
L_8d2c66:
	max r0,r0,0x1
L_8d2c6a:
	extb r23,r0
L_8d2c6e:
	brne_s r1,0,L_8d2c7a
L_8d2c70:
	add r0,r23,r18
L_8d2c74:
	min r0,r0,0xf
L_8d2c78:
	b_s L_8d2c84
	.global L_8d2c7a
L_8d2c7a:
	sub r0,r18,r23
L_8d2c7e:
	sexb_s r0,r0
L_8d2c80:
	max r0,r0,0x1
	.global L_8d2c84
L_8d2c84:
	extb_s r0,r0
L_8d2c86:
	mov r20,r18
L_8d2c8a:
	mov r25,r17
L_8d2c8e:
	mov_s r18,r0
	.global L_8d2c90
L_8d2c90:
	st_s r15,[sp,0x20]
L_8d2c92:
	st r19,[sp, 0x24]
L_8d2c96:
	mov r17,r25
L_8d2c9a:
	b_s L_8d2b70
	.global L_8d2c9c
L_8d2c9c:
	mov_s r0,r15
L_8d2c9e:
	bl.d L_8d27e8
L_8d2ca2:
	mov_s r1,r14
L_8d2ca4:
	ldb_s r0,[r14,0x2]
L_8d2ca6:
	st_s r0,[sp,0xc]
L_8d2ca8:
	brhs.d r0,0x13,L_8d2cce
L_8d2cac:
	ldb r24,[r14, 0x4]
	.global L_8d2cb0
L_8d2cb0:
	brhs r24,0x12,L_8d2ce6
	.global L_8d2cb4
L_8d2cb4:
	ld_s r0,[sp,0xc]
L_8d2cb6:
	mov_s r1,0x80174c
L_8d2cbc:
	ldb_s r0,[r1,r0]
L_8d2cbe:
	st_s r0,[sp,0x18]
L_8d2cc0:
	mov_s r0,0x801760
L_8d2cc6:
	ldb r0,[r0,r24]
L_8d2cca:
	st_s r0,[sp,0x1c]
L_8d2ccc:
	b_s L_8d2b70
	.global L_8d2cce
L_8d2cce:
	mov_s r0,blink
L_8d2cd0:
	mov_s r2,0x1017e9c
L_8d2cd6:
	mov_s r1,0x147e
L_8d2cdc:
	bl.d L_8c82c0
L_8d2ce0:
	mov r3,0x236
L_8d2ce4:
	b_s L_8d2cb0
	.global L_8d2ce6
L_8d2ce6:
	mov_s r0,blink
L_8d2ce8:
	mov_s r2,0x1017e9c
L_8d2cee:
	mov_s r1,0x147f
L_8d2cf4:
	bl.d L_8c82c0
L_8d2cf8:
	mov r3,0x237
L_8d2cfc:
	b_s L_8d2cb4
	.global L_8d2cfe
L_8d2cfe:
	mov_s r0,blink
L_8d2d00:
	mov_s r2,0x1017e9c
L_8d2d06:
	mov_s r1,0x130b
L_8d2d0c:
	mov r3,0x246
	.global L_8d2d10
L_8d2d10:
	bl L_8c82c0
L_8d2d14:
	b_s L_8d2b70
	.global L_8d2d16
L_8d2d16:
	bl.d L_8cf4c8
L_8d2d1a:
	mov_s r0,0x0
L_8d2d1c:
	bl.d L_8d0388
L_8d2d20:
	mov_s r0,0x0
L_8d2d22:
	ld_s r0,[sp,0x0]
L_8d2d24:
	brne r0,0x1,L_8d2d40
L_8d2d28:
	ld_s r0,[sp,0x4]
L_8d2d2a:
	brne r0,0x1,L_8d2d40
L_8d2d2e:
	mov_s r0,0x2
L_8d2d30:
	mov_s r1,0xa
L_8d2d32:
	mov_s r2,r1
L_8d2d34:
	bl.d L_8d01e8
L_8d2d38:
	mov r3,0x4d2
L_8d2d3c:
	bl L_8d02ac
	.global L_8d2d40
L_8d2d40:
	bl.d L_8cf4fc
L_8d2d44:
	mov_s r0,0x0
	.global L_8d2d46
L_8d2d46:
	ld_s r0,[sp,0x30]
L_8d2d48:
	stb r17,[r14, 0x9]
L_8d2d4c:
	stb_s r0,[r14,0xa]
L_8d2d4e:
	ld_s r0,[sp,0x2c]
L_8d2d50:
	stb_s r13,[r14,0x8]
L_8d2d52:
	stw_s r0,[r14,0xc]
L_8d2d54:
	ld_s r0,[sp,0xc]
L_8d2d56:
	stb r24,[r14, 0x4]
L_8d2d5a:
	stb_s r0,[r14,0x2]
L_8d2d5c:
	ld_s r0,[sp,0x18]
L_8d2d5e:
	stb r18,[r14, 0x6]
L_8d2d62:
	stb_s r0,[r14,0x3]
L_8d2d64:
	ld_s r0,[sp,0x1c]
L_8d2d66:
	stb r23,[r14, 0x7]
L_8d2d6a:
	stb_s r0,[r14,0x5]
L_8d2d6c:
	ld_s r0,[sp,0x28]
L_8d2d6e:
	stb_s r0,[r14,0x10]
L_8d2d70:
	b.d L_8c02dc
L_8d2d74:
	add_s sp,sp,0x6c
L_8d2d76:
	nop_s
