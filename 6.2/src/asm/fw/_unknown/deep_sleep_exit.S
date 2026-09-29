/* deep_sleep_exit @ 0x8c8aa0, 328 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   deep_sleep_exit: Common RF load time measure start:%d, end:%d, total:%d
 * Зовут его: POWER_MNGR__deep_sleep_exit
 * Зовёт сам: SDP__sdp_drive_value, __ld_r16_to_r13_ret, __st_r16_to_r13, bit_iter__has_more, bitmap__alloc_bit, calib_obj4__reset_d4, evt_ring__push_1c, field_set_0x00__8e5dfc, fw2uc__signal_wake_and_wait_ack, fw_log_emit3, hw_cfg__get_8004fc_bit0, hwd_abif__caf_pwdn_mode
 * Глобалы (через gp): 0x800334
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global deep_sleep_exit
deep_sleep_exit:
	.global L_8c8aa0
L_8c8aa0:
	push_s blink
L_8c8aa2:
	bl L_8c01dc
L_8c8aa6:
	mov_s r16,r0
L_8c8aa8:
	ld_s r0,[gp,-0xbc]
L_8c8aaa:
	sub_s sp,sp,0x14
L_8c8aac:
	cmp_s r0,0x1
L_8c8aae:
	sub_s.ne r0,r0,r0
L_8c8ab0:
	bne_s L_8c8bd2
L_8c8ab2:
	bl L_8cc1fc
L_8c8ab6:
	mov_s r13,r0
L_8c8ab8:
	lr r15,[0xa]
L_8c8abc:
	bic r0,r15,0x6
L_8c8ac0:
	flag r0
L_8c8ac4:
	mov_s r1,sp
L_8c8ac6:
	mov_s r14,0x0
L_8c8ac8:
	mov_s r0,r14
L_8c8aca:
	bl.d L_8e9900
L_8c8ace:
	mov_s r2,r14
L_8c8ad0:
	mov_s r0,r14
L_8c8ad2:
	mov_s r1,r13
L_8c8ad4:
	ld.as r2,[gp,-0x2b]
L_8c8ad8:
	mov_s r3,r14
L_8c8ada:
	bl.d L_8d78cc
L_8c8ade:
	mov_s r4,r14
L_8c8ae0:
	bl L_8ce1a8
L_8c8ae4:
	cmp_s r0,0x0
L_8c8ae6:
	mov.ne r0,r14
L_8c8aea:
	bl.ne.d L_8e4abc
L_8c8aee:
	mov.ne r1,0x7
L_8c8af2:
	st.as r14,[gp,-0x2f]
L_8c8af6:
	ld_s r0,[r13]
L_8c8af8:
	btst_s r0,0x2
L_8c8afa:
	beq_s L_8c8b8e
L_8c8afc:
	mov_s r0,0x5dc0
L_8c8b02:
	mov lp_count,r0
L_8c8b06:
	nop_s
L_8c8b08:
	lp L_8c8b10
L_8c8b0c:
	nop_s
L_8c8b0e:
	nop_s
	.global L_8c8b10
L_8c8b10:
	bl.d L_8ce690
L_8c8b14:
	mov_s r0,0x0
L_8c8b16:
	mov_s r0,0x27100
L_8c8b1c:
	mov lp_count,r0
L_8c8b20:
	nop_s
L_8c8b22:
	lp L_8c8b2a
L_8c8b26:
	nop_s
L_8c8b28:
	nop_s
	.global L_8c8b2a
L_8c8b2a:
	mov_s r13,0x8042c8
L_8c8b30:
	bl.d L_8ccb38
L_8c8b34:
	mov_s r0,r13
L_8c8b36:
	bl.d L_8d7500
L_8c8b3a:
	add_s r14,sp,0x10
L_8c8b3c:
	mov_s r0,0x0
L_8c8b3e:
	bl.d L_8d705c
L_8c8b42:
	mov_s r1,r0
L_8c8b44:
	bl.d L_8ccb3c
L_8c8b48:
	mov_s r0,r13
L_8c8b4a:
	bl L_8d7500
L_8c8b4e:
	bl.d L_8e2e88
L_8c8b52:
	mov_s r0,r13
L_8c8b54:
	ld.as r1,[gp,0x6c]
L_8c8b58:
	mov_s r0,r13
L_8c8b5a:
	bl.d L_8c6d00
L_8c8b5e:
	mov_s r2,0x1
L_8c8b60:
	bl.d L_8ccb3c
L_8c8b64:
	mov_s r0,r13
L_8c8b66:
	mov_s r1,r0
L_8c8b68:
	bl.d L_8e5dfc
L_8c8b6c:
	mov_s r0,r14
L_8c8b6e:
	b_s L_8c8b7c
	.global L_8c8b70
L_8c8b70:
	bl.d L_8df444
L_8c8b74:
	mov_s r0,r14
L_8c8b76:
	brlo.d r0,0x8,L_8c8bd8
L_8c8b7a:
	mov_s r13,r0
	.global L_8c8b7c
L_8c8b7c:
	bl.d L_8cdcc4
L_8c8b80:
	mov_s r0,r14
L_8c8b82:
	brne_s r0,0,L_8c8b70
L_8c8b84:
	bl L_8dc654
L_8c8b88:
	bl.d L_8ce690
L_8c8b8c:
	mov_s r0,0x1
	.global L_8c8b8e
L_8c8b8e:
	add_s r1,sp,0x8
L_8c8b90:
	mov_s r0,0x0
L_8c8b92:
	bl.d L_8e9900
L_8c8b96:
	mov_s r2,r0
L_8c8b98:
	ld_s r2,[sp,0x0]
L_8c8b9a:
	ld_s r3,[sp,0x8]
L_8c8b9c:
	mov_s r1,0x1001e78
L_8c8ba2:
	sub r4,r3,r2
L_8c8ba6:
	bl.d L_8dcd00
L_8c8baa:
	mov_s r0,0x2e
L_8c8bac:
	cmp r16,0x0
L_8c8bb0:
	bl.ne L_8db0d0
L_8c8bb4:
	mov_s r0,0xb
L_8c8bb6:
	mov_s r1,0x1
L_8c8bb8:
	bl.d L_8e0b2c
L_8c8bbc:
	ld_s r2,[sp,0x8]
L_8c8bbe:
	lr r0,[0xa]
L_8c8bc2:
	bic r15,r15,-0x7
L_8c8bc6:
	or_s r15,r15,r0
L_8c8bc8:
	flag r15
L_8c8bcc:
	bl L_8e9530
L_8c8bd0:
	mov_s r0,0x1
	.global L_8c8bd2
L_8c8bd2:
	b.d L_8c0244
L_8c8bd6:
	add_s sp,sp,0x14
	.global L_8c8bd8
L_8c8bd8:
	bl L_8cbb90
L_8c8bdc:
	extb_s r1,r13
L_8c8bde:
	bl.d L_8e2fc0
L_8c8be2:
	mov_s r2,0x1
L_8c8be4:
	b_s L_8c8b7c
L_8c8be6:
	nop_s
