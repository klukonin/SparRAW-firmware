/* txss_resp__wait_iss_end @ 0x93bf1c, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss_resp__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, gp_timer__arm, mac__program_4f_52, mac_mode__switch_core_and_rf, rx_flow__run, txss__program_tx_frame, txss__rank_best_sector, uc_wait_event1_or_event4
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss_resp__wait_iss_end
txss_resp__wait_iss_end:
	.global L_93bf1c
L_93bf1c:
	push_s blink
L_93bf1e:
	bl L_920234
L_93bf22:
	mov_s r13,r0
L_93bf24:
	bl.d L_93512c
L_93bf28:
	mov_s r0,0x1
	.global L_93bf2a
L_93bf2a:
	mov_s r2,r54
L_93bf2c:
	mov_s r0,0x8021e0
L_93bf32:
	ld_s r1,[r0]
L_93bf34:
	btst_s r2,0x0
L_93bf36:
	btst.eq r1,0x1
L_93bf3a:
	bne_s L_93bf56
L_93bf3c:
	mov_s r0,r54
L_93bf3e:
	bbit1 r0,0x7,L_93bfe8
L_93bf42:
	mov_s r14,0x8021e0
L_93bf48:
	ld_s r0,[r14]
L_93bf4a:
	bbit0 r0,0x0,L_93bfbc
L_93bf4e:
	bclr_s r0,r0,0x0
L_93bf50:
	st_s r0,[r14]
L_93bf52:
	mov_s r0,0x1
L_93bf54:
	b_s L_93bfbe
	.global L_93bf56
L_93bf56:
	st.as 0x80000,[gp,0x34]
L_93bf5e:
	lsr_s r0,r1
L_93bf60:
	bmsk_s r0,r0,0x0
L_93bf62:
	st.as r0,[gp,-0x21]
L_93bf66:
	bbit1 r1,0x1,L_93bf78
L_93bf6a:
	mov_s r0,0x802aec
L_93bf70:
	bl.d L_92e0e4
L_93bf74:
	ld.as r0,[r0,r13]
	.global L_93bf78
L_93bf78:
	mov_s r0,0x80212c
L_93bf7e:
	ldb_s r2,[r0,0x1]
L_93bf80:
	mov_s r1,0x802a6c
L_93bf86:
	ldb_s r0,[r0]
L_93bf88:
	stw_s r2,[r1,0x20]
L_93bf8a:
	stw_s r0,[r1,0x22]
L_93bf8c:
	mov_s r0,0x8020c4
L_93bf92:
	ld_s r0,[r0,0x28]
L_93bf94:
	bl.d L_924d8c
L_93bf98:
	mov_s r1,0x4
L_93bf9a:
	mov_s r0,r13
L_93bf9c:
	mov_s r1,0x1
L_93bf9e:
	mov_s r2,r1
L_93bfa0:
	mov_s r3,0x0
L_93bfa2:
	bl.d L_93c2f8
L_93bfa6:
	mov_s r4,r3
L_93bfa8:
	mov_s r0,0x49000040
L_93bfae:
	mov_s r32,r0
L_93bfb0:
	st.ab r0,[r25,0x4]
L_93bfb4:
	bclr r25,r25,0xa
L_93bfb8:
	mov_s r0,0x1
L_93bfba:
	b_s L_93bfea
	.global L_93bfbc
L_93bfbc:
	mov_s r0,0x0
	.global L_93bfbe
L_93bfbe:
	cmp_s r0,0x1
L_93bfc0:
	bl.eq L_935938
L_93bfc4:
	mov_s r0,0x0
L_93bfc6:
	bset_s r0,r0,0x13
L_93bfc8:
	mov_s r1,0x81
L_93bfca:
	bl.d L_9367e4
L_93bfce:
	mov_s r2,0x0
L_93bfd0:
	mov_s r0,r54
L_93bfd2:
	bbit1 r0,0x0,L_93bf2a
L_93bfd6:
	mov_s r0,r54
L_93bfd8:
	bbit1 r0,0x7,L_93bf2a
L_93bfdc:
	bl L_930dd4
L_93bfe0:
	ld_s r0,[r14]
L_93bfe2:
	bic.f r0,r0,-0xd
L_93bfe6:
	beq_s L_93bf2a
	.global L_93bfe8
L_93bfe8:
	mov_s r0,0x0
	.global L_93bfea
L_93bfea:
	b L_9202a4
L_93bfee:
	nop_s
