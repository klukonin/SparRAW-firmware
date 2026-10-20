/* mac__prepare_txrx_window @ 0x920b58, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__handle_status_flags, rx_nav_update, tx_sta__flow_loop
 * Зовёт сам: mac__select_rf_module_cmd31, mac_q__tx_ppdu, rx__mac_prepare, uc_wait_event_busy
 * Глобалы (через gp): 0x8005f4, 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__prepare_txrx_window
mac__prepare_txrx_window:
	.global L_920b58
L_920b58:
	st.a r13,[sp,-0xc]
L_920b5c:
	st blink,[sp, 0x4]
L_920b60:
	st_s r14,[sp,0x8]
L_920b62:
	mov_s r13,r0
L_920b64:
	mov_s r14,r1
L_920b66:
	ld.as r5,[gp,0x34]
L_920b6a:
	mov r7,0x0
L_920b6e:
	ld.as r10,[gp,0x33]
L_920b72:
	bic r5,r5,0x1f
L_920b76:
	and r6,r10,0x2
L_920b7a:
	bset r5,r5,0x7
L_920b7e:
	st.as r5,[gp,0x34]
L_920b82:
	or.f 0x0,r6,r7
L_920b86:
	mov_s r0,r7
L_920b88:
	beq.d L_920c88
L_920b8c:
	mov r1,r0
L_920b90:
	bl L_93cfdc
L_920b94:
	ld.as r8,[gp,-0x11]
L_920b98:
	and r8,r8,0xffff0fff
L_920ba0:
	or r7,r8,0x3000
L_920ba8:
	or r8,r8,0x1d003000
L_920bb0:
	st.as r7,[gp,-0x11]
L_920bb4:
	mov r32,r8
L_920bb8:
	st.ab r8,[r25,0x4]
L_920bbc:
	bclr r25,r25,0xa
L_920bc0:
	nop_s
L_920bc2:
	nop_s
L_920bc4:
	mov 0x0,0x0
L_920bc8:
	brne.d r14,0x2,L_920bf0
L_920bcc:
	extw r7,r40
L_920bd0:
	ldb r6,[0x80296b]
L_920bd8:
	asl r0,r6
L_920bdc:
	brhs r0,r7,L_920bf0
L_920be0:
	sub1 r7,r7,r6
L_920be4:
	brlo r7,0xc,L_920bf0
L_920be8:
	mov r1,r42
L_920bec:
	bbit0 r1,0x7,L_920c04
	.global L_920bf0
L_920bf0:
	ld.as r6,[gp,0x34]
L_920bf4:
	bset r6,r6,0xa
L_920bf8:
	bl.d L_92f2bc
L_920bfc:
	st.as r6,[gp,0x34]
L_920c00:
	b L_920c18
	.global L_920c04
L_920c04:
	mov r7,0x14000002
L_920c0c:
	mov r32,r7
L_920c10:
	st.ab r7,[r25,0x4]
L_920c14:
	bclr r25,r25,0xa
	.global L_920c18
L_920c18:
	ld_s r2,[r13,0xc]
L_920c1a:
	btst_s r2,0x1
L_920c1c:
	mov.ne r0,r13
L_920c20:
	bl.ne.d L_939888
L_920c24:
	mov.ne r1,0x2
L_920c28:
	ld.as r5,[gp,-0x12]
L_920c2c:
	or r5,r5,0x27000e00
L_920c34:
	mov r32,r5
L_920c38:
	st.ab r5,[r25,0x4]
L_920c3c:
	bclr r25,r25,0xa
L_920c40:
	mov r8,0x2004000
L_920c48:
	mov r32,r8
L_920c4c:
	st.ab r8,[r25,0x4]
L_920c50:
	bclr r25,r25,0xa
L_920c54:
	nop_s
L_920c56:
	nop_s
L_920c58:
	nop_s
L_920c5a:
	mov_s r0,0x2
L_920c5c:
	bset r0,r0,0xe
L_920c60:
	bl.d L_9366e8
L_920c64:
	mov r1,0x0
L_920c68:
	mov_s r3,r42
L_920c6a:
	bbit0 r3,0xe,L_920cac
L_920c6e:
	ld.as r4,[gp,0x34]
L_920c72:
	ld blink,[sp, 0x4]
L_920c76:
	bclr r4,r4,0x8
L_920c7a:
	st.as r4,[gp,0x34]
L_920c7e:
	ld_s r14,[sp,0x8]
L_920c80:
	j.d [blink]
L_920c84:
	ld.ab r13,[sp,0xc]
	.global L_920c88
L_920c88:
	bl L_93cfdc
L_920c8c:
	ld r9,[r13, 0xc]
L_920c90:
	bbit0 r9,0x1,L_920cac
L_920c94:
	mov r0,r13
L_920c98:
	bl.d L_939888
L_920c9c:
	mov r1,0x2
L_920ca0:
	ld blink,[sp, 0x4]
L_920ca4:
	ld_s r14,[sp,0x8]
L_920ca6:
	j_s.d [blink]
L_920ca8:
	ld.ab r13,[sp,0xc]
	.global L_920cac
L_920cac:
	ld blink,[sp, 0x4]
L_920cb0:
	ld_s r14,[sp,0x8]
L_920cb2:
	j_s.d [blink]
L_920cb4:
	ld.ab r13,[sp,0xc]
