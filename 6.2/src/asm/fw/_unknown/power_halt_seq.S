/* power_halt_seq @ 0x8d78cc, 500 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt, UT_HW_MODES_cmd_handler, deep_sleep_exit, hwm_analog__prepare_buf
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, abif__mode_switch, abif__power_down_889300, abif__power_down_88af80, fw_divmod64_signed, fw_lshr64, fw_mul64, hw__has_cause_880b54, hw__pll_mode_switch, hw_modes__program_rf_clocks, hwd__args_to_regs_default
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_halt_seq
power_halt_seq:
	.global L_8d78cc
L_8d78cc:
	push_s blink
L_8d78ce:
	bl L_8c01d8
L_8d78d2:
	mov_s r13,r1
L_8d78d4:
	mov_s r15,r2
L_8d78d6:
	cmp_s r0,0x0
L_8d78d8:
	mov_s r16,r3
L_8d78da:
	mov r17,r4
L_8d78de:
	beq_s L_8d7a00
L_8d78e0:
	bl L_8d07b8
L_8d78e4:
	mov_s r14,0x800520
L_8d78ea:
	st_s r0,[r14]
L_8d78ec:
	ld_s r0,[r13]
L_8d78ee:
	bbit0 r0,0x0,L_8d7900
L_8d78f2:
	mov_s r0,0x8042c8
L_8d78f8:
	bl L_8ccb3c
L_8d78fc:
	bl L_8d3380
	.global L_8d7900
L_8d7900:
	ld_s r0,[r13]
L_8d7902:
	btst_s r0,0x1
L_8d7904:
	bl.ne L_8d3424
L_8d7908:
	ld_s r0,[r13]
L_8d790a:
	btst_s r0,0x2
L_8d790c:
	bl.ne.d L_8d6e88
L_8d7910:
	sub_s.ne r0,r0,r0
L_8d7912:
	ld_s r0,[r13]
L_8d7914:
	btst_s r0,0x3
L_8d7916:
	bl.ne.d L_8d7bd0
L_8d791a:
	mov.ne r0,0x1
L_8d791e:
	ld_s r0,[r13]
L_8d7920:
	btst_s r0,0x4
L_8d7922:
	bl.ne.d L_8d7c3c
L_8d7926:
	mov.ne r0,0x1
L_8d792a:
	ld_s r0,[r13]
L_8d792c:
	bbit0 r0,0x5,L_8d7938
L_8d7930:
	add_s r1,r13,0x4
L_8d7932:
	bl.d L_8d7864
L_8d7936:
	mov_s r0,0x1
	.global L_8d7938
L_8d7938:
	ld_s r1,[r13]
L_8d793a:
	btst_s r1,0x6
L_8d793c:
	lsr.ne r1,r1,0xa
L_8d7940:
	mov.ne r0,0x1
L_8d7944:
	bl.ne.d L_8d7c84
L_8d7948:
	bmsk.ne r1,r1,0x0
L_8d794c:
	ld_s r0,[r13]
L_8d794e:
	bbit0 r0,0x7,L_8d795a
L_8d7952:
	mov_s r0,0x1
L_8d7954:
	bl.d L_8d7c04
L_8d7958:
	ld_s r1,[r14]
	.global L_8d795a
L_8d795a:
	ld_s r0,[r13]
L_8d795c:
	btst_s r0,0x8
L_8d795e:
	cmp.ne r15,0x0
L_8d7962:
	beq_s L_8d79d0
L_8d7964:
	ld_s r0,[r14]
L_8d7966:
	brne_s r0,0,L_8d79d0
L_8d7968:
	mov_s r15,0x8067d4
L_8d796e:
	mov_s r0,0x0
L_8d7970:
	mov_s r1,r15
L_8d7972:
	bl.d L_8e9900
L_8d7976:
	mov_s r2,r0
L_8d7978:
	sub.f r0,r16,0x332c
L_8d7980:
	sbc r1,r17,0x0
L_8d7984:
	ld_s r2,[r15]
L_8d7986:
	add.f r2,r2,0x1ae
L_8d798a:
	ld_s r3,[r15,0x4]
L_8d798c:
	adc r3,r3,0x0
L_8d7990:
	sub.f r0,r0,r2
L_8d7994:
	sbc r1,r1,r3
L_8d7998:
	mov_s r2,0x1e
L_8d799a:
	bl.d L_8c047c
L_8d799e:
	mov_s r3,0x0
L_8d79a0:
	mov_s r2,0xfba9
L_8d79a6:
	bl.d L_8c045c
L_8d79aa:
	mov_s r3,0x0
L_8d79ac:
	bl.d L_8c0430
L_8d79b0:
	mov_s r2,0x10
L_8d79b2:
	bl L_8da8e4
L_8d79b6:
	bl L_8da774
L_8d79ba:
	bl L_8da800
L_8d79be:
	bl L_8d03f4
L_8d79c2:
	mov_s r1,0x41
L_8d79c4:
	mov_s r0,0x880280
L_8d79ca:
	st_s r1,[r0]
L_8d79cc:
	bl L_8d0048
	.global L_8d79d0
L_8d79d0:
	ld_s r0,[r13]
L_8d79d2:
	bbit0 r0,0x9,L_8d7abc
L_8d79d6:
	ld_s r0,[r14]
L_8d79d8:
	brne r0,0x0,L_8d7abc
L_8d79dc:
	bl L_8d13ec
L_8d79e0:
	brne r0,0x5,L_8d7abc
L_8d79e4:
	bl.d L_8d7cc4
L_8d79e8:
	mov_s r0,0x1
	.global L_8d79ea
L_8d79ea:
	bl L_8d13ec
L_8d79ee:
	brne r0,0x5,L_8d79f8
L_8d79f2:
	bl L_8d478c
L_8d79f6:
	breq_s r0,0,L_8d79ea
	.global L_8d79f8
L_8d79f8:
	bl.d L_8d7cc4
L_8d79fc:
	mov_s r0,0x0
L_8d79fe:
	b_s L_8d7abc
	.global L_8d7a00
L_8d7a00:
	ld_s r0,[r13]
L_8d7a02:
	btst_s r0,0x8
L_8d7a04:
	cmp.ne r15,0x0
L_8d7a08:
	beq_s L_8d7a60
L_8d7a0a:
	mov_s r0,0x800520
L_8d7a10:
	ld_s r0,[r0]
L_8d7a12:
	brne_s r0,0,L_8d7a60
L_8d7a14:
	bl L_8d0070
L_8d7a18:
	bl L_8d0010
L_8d7a1c:
	mov_s r1,0x40
L_8d7a1e:
	mov_s r0,0x880280
L_8d7a24:
	st_s r1,[r0]
L_8d7a26:
	bl L_8d0444
L_8d7a2a:
	bl L_8da7f0
L_8d7a2e:
	mov_s r1,0x0
L_8d7a30:
	mov_s r2,0x1e848a
L_8d7a36:
	bl.d L_8c045c
L_8d7a3a:
	mov_s r3,r1
L_8d7a3c:
	bl.d L_8c0430
L_8d7a40:
	mov_s r2,0x10
L_8d7a42:
	mov_s r3,0x8067d4
L_8d7a48:
	ld_s r2,[r3]
L_8d7a4a:
	add.f r0,r0,r2
L_8d7a4e:
	ld_s r3,[r3,0x4]
L_8d7a50:
	adc r1,r1,r3
L_8d7a54:
	add.f r0,r0,0x3b5
L_8d7a58:
	bl.d L_8e9a58
L_8d7a5c:
	adc r1,r1,0x0
	.global L_8d7a60
L_8d7a60:
	ld_s r0,[r13]
L_8d7a62:
	bbit0 r0,0x7,L_8d7a74
L_8d7a66:
	mov_s r1,0x800520
L_8d7a6c:
	mov_s r0,0x0
L_8d7a6e:
	bl.d L_8d7c04
L_8d7a72:
	ld_s r1,[r1]
	.global L_8d7a74
L_8d7a74:
	ld_s r0,[r13]
L_8d7a76:
	bbit0 r0,0x5,L_8d7a82
L_8d7a7a:
	add_s r1,r13,0x4
L_8d7a7c:
	bl.d L_8d7864
L_8d7a80:
	mov_s r0,0x0
	.global L_8d7a82
L_8d7a82:
	ld_s r1,[r13]
L_8d7a84:
	btst_s r1,0x6
L_8d7a86:
	lsr.ne r1,r1,0xa
L_8d7a8a:
	sub_s.ne r0,r0,r0
L_8d7a8c:
	bl.ne.d L_8d7c84
L_8d7a90:
	bmsk.ne r1,r1,0x0
L_8d7a94:
	ld_s r0,[r13]
L_8d7a96:
	btst_s r0,0x4
L_8d7a98:
	bl.ne.d L_8d7c3c
L_8d7a9c:
	sub_s.ne r0,r0,r0
L_8d7a9e:
	ld_s r0,[r13]
L_8d7aa0:
	btst_s r0,0x3
L_8d7aa2:
	bl.ne.d L_8d7bd0
L_8d7aa6:
	sub_s.ne r0,r0,r0
L_8d7aa8:
	ld_s r0,[r13]
L_8d7aaa:
	btst_s r0,0x2
L_8d7aac:
	bl.ne.d L_8d6e88
L_8d7ab0:
	mov.ne r0,0x1
L_8d7ab4:
	ld_s r0,[r13]
L_8d7ab6:
	btst_s r0,0x1
L_8d7ab8:
	bl.ne L_8d34c0
	.global L_8d7abc
L_8d7abc:
	b L_8c023c
