/* ucode_cmd_0x01_handler @ 0x93a9ec, 520 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, grant_detect_step, mac__rf_switch_cmd1f, mac__set_mode_0000, mac__set_rf_chain_state, rfca__select_rf_uc, rx_listen__set_flag_and_stamp_tsf, rx_mode__configure, txrx_api_cmd_step, uc__set_evt_id_5c, uc_read_tsf_lo
 * Глобалы (через gp): 0x800540, 0x8005bc, 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x01_handler
ucode_cmd_0x01_handler:
	.global L_93a9ec
L_93a9ec:
	push_s blink
L_93a9ee:
	bl L_920230
L_93a9f2:
	mov_s r14,r0
L_93a9f4:
	ld_s r0,[gp,-0x44]
L_93a9f6:
	and r0,r0,0xffff0fff
L_93a9fe:
	bset r1,r0,0xd
L_93aa02:
	bset_s r1,r1,0xf
L_93aa04:
	or r0,r0,0x1d00a000
L_93aa0c:
	st.as r1,[gp,-0x11]
L_93aa10:
	mov_s r32,r0
L_93aa12:
	st.ab r0,[r25,0x4]
L_93aa16:
	bclr r25,r25,0xa
L_93aa1a:
	nop_s
L_93aa1c:
	nop_s
L_93aa1e:
	nop_s
L_93aa20:
	lsr r15,r40,0x8
L_93aa24:
	bmsk_s r15,r15,0x5
L_93aa26:
	lsr r13,r40,0x10
L_93aa2a:
	bmsk_s r13,r13,0x5
L_93aa2c:
	mov_s r32,r13
L_93aa2e:
	st.ab r13,[r25,0x4]
L_93aa32:
	bclr r25,r25,0xa
L_93aa36:
	mov_s r32,r15
L_93aa38:
	st.ab r15,[r25,0x4]
L_93aa3c:
	bclr r25,r25,0xa
L_93aa40:
	brne r15,r13,L_93aaa2
	.global L_93aa44
L_93aa44:
	add r2,r14,0x20
L_93aa48:
	ldb_s r0,[r2,0x4]
L_93aa4a:
	mov_s r1,0x8006b4
L_93aa50:
	stb_s r0,[r1,0x2]
L_93aa52:
	mov_s r15,0x0
L_93aa54:
	mov_s r13,r0
L_93aa56:
	b_s L_93aa60
	.global L_93aa58
L_93aa58:
	sub_s r3,r13,0x1
L_93aa5a:
	and_s r13,r13,r3
L_93aa5c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_93aa5e:
	extw_s r15,r15
	.global L_93aa60
L_93aa60:
	brne_s r13,0,L_93aa58
L_93aa62:
	stw_s r15,[r1]
L_93aa64:
	ldb_s r3,[r2,0x6]
L_93aa66:
	stb_s r3,[r1,0x4]
L_93aa68:
	ldb_s r3,[r2,0x6]
L_93aa6a:
	breq_s r3,0,L_93aa70
L_93aa6c:
	ldb_s r2,[r2,0x5]
L_93aa6e:
	stb_s r2,[r1,0x5]
	.global L_93aa70
L_93aa70:
	bl.d L_928b8c
L_93aa74:
	mov_s r1,0x0
L_93aa76:
	ldw_s r0,[gp,0x94]
L_93aa78:
	brne_s r0,0,L_93aa90
L_93aa7a:
	bl L_9364c8
L_93aa7e:
	ld.as r1,[gp,0x6]
L_93aa82:
	mov_s r2,0x8010b0
L_93aa88:
	sub_s r0,r0,r1
L_93aa8a:
	ld_s r1,[r2,0x40]
L_93aa8c:
	add_s r0,r0,r1
L_93aa8e:
	st_s r0,[r2,0x40]
	.global L_93aa90
L_93aa90:
	ld_s r0,[r14,0x20]
L_93aa92:
	breq_s r0,0,L_93aaac
L_93aa94:
	breq r0,0x1,L_93aad8
L_93aa98:
	mov_s r0,blink
L_93aa9a:
	bl.d L_926618
L_93aa9e:
	mov_s r1,0x7e
L_93aaa0:
	b_s L_93ab84
	.global L_93aaa2
L_93aaa2:
	mov_s r0,blink
L_93aaa4:
	bl.d L_926618
L_93aaa8:
	mov_s r1,0x7d
L_93aaaa:
	b_s L_93aa44
	.global L_93aaac
L_93aaac:
	mov_s r0,0x3
L_93aaae:
	bl.d L_92f4bc
L_93aab2:
	mov_s r1,0xff
L_93aab4:
	ld_s r0,[gp,-0xd4]
L_93aab6:
	and r0,r0,0xfffff0ff
L_93aabe:
	bset_s r0,r0,0x1b
L_93aac0:
	mov_s r32,r0
L_93aac2:
	st.ab r0,[r25,0x4]
L_93aac6:
	bclr r25,r25,0xa
L_93aaca:
	mov_s r13,0x1
L_93aacc:
	bl.d L_92c5e4
L_93aad0:
	mov_s r0,r13
L_93aad2:
	stw.as r13,[gp,0x4a]
L_93aad6:
	b_s L_93ab84
	.global L_93aad8
L_93aad8:
	mov_s r0,0x3
L_93aada:
	bl.d L_92f4bc
L_93aade:
	mov_s r1,0xff
L_93aae0:
	bl.d L_92c5e4
L_93aae4:
	mov_s r0,0x1
L_93aae6:
	mov_s r0,0x80141c
L_93aaec:
	ld_s r0,[r0,0x8]
L_93aaee:
	bbit0 r0,0x0,L_93aafc
L_93aaf2:
	mov_s r0,0x801024
L_93aaf8:
	ld_s r1,[r0]
L_93aafa:
	b_s L_93ab06
	.global L_93aafc
L_93aafc:
	mov_s r0,0x802978
L_93ab02:
	ld_s r0,[r0,0x78]
L_93ab04:
	ld_s r1,[r0,0x2c]
	.global L_93ab06
L_93ab06:
	bl.d L_92f42c
L_93ab0a:
	mov_s r0,0x1
L_93ab0c:
	lr r13,[0xa]
L_93ab10:
	bclr r0,r13,0x1
L_93ab14:
	flag r0
L_93ab18:
	mov_s r0,0x80146c
L_93ab1e:
	ld_s r0,[r0,0x8]
L_93ab20:
	ld.as r1,[gp,-0x35]
L_93ab24:
	and_s r0,r0,r1
L_93ab26:
	bset_s r0,r0,0x1b
L_93ab28:
	mov_s r32,r0
L_93ab2a:
	st.ab r0,[r25,0x4]
L_93ab2e:
	bclr r25,r25,0xa
L_93ab32:
	mov_s r0,0x81
L_93ab34:
	asl_s r0,r0,0x12
L_93ab36:
	mov_s r32,r0
L_93ab38:
	st.ab r0,[r25,0x4]
L_93ab3c:
	bclr r25,r25,0xa
L_93ab40:
	bl.d L_92c5e4
L_93ab44:
	mov_s r0,0x1
L_93ab46:
	lr r0,[0xa]
L_93ab4a:
	bic r13,r13,-0x3
L_93ab4e:
	or_s r0,r0,r13
L_93ab50:
	flag r0
L_93ab54:
	mov_s r0,0x802940
L_93ab5a:
	ld.as r1,[gp,0x5e]
L_93ab5e:
	ld_s r0,[r0,0x4]
L_93ab60:
	bclr_s r1,r1,0x18
L_93ab62:
	bclr_s r1,r1,0x19
L_93ab64:
	asl_s r0,r0,0x18
L_93ab66:
	or_s r0,r0,r1
L_93ab68:
	st.as r0,[gp,0x5e]
L_93ab6c:
	mov_s r1,0x889480
L_93ab72:
	st_s r0,[r1,0x8]
L_93ab74:
	mov_s r0,0x0
L_93ab76:
	mov_s r1,r0
L_93ab78:
	bl.d L_92db88
L_93ab7c:
	mov_s r2,r0
L_93ab7e:
	mov_s r0,0x2
L_93ab80:
	stw.as r0,[gp,0x4a]
	.global L_93ab84
L_93ab84:
	bl.d L_936be4
L_93ab88:
	mov_s r0,r14
L_93ab8a:
	mov_s r0,0x8014a4
L_93ab90:
	ld_s r0,[r0,0x1c]
L_93ab92:
	brne_s r0,0,L_93abaa
L_93ab94:
	mov_s r0,0x80212c
L_93ab9a:
	ldb r0,[r0, 0x68]
L_93ab9e:
	cmp_s r0,0x0
L_93aba0:
	mov.eq r0,0x20c0011
L_93aba8:
	beq_s L_93abb0
	.global L_93abaa
L_93abaa:
	mov_s r0,0x20c0001
	.global L_93abb0
L_93abb0:
	mov_s r32,r0
L_93abb2:
	st.ab r0,[r25,0x4]
L_93abb6:
	bclr r25,r25,0xa
L_93abba:
	mov_s r0,0x886d00
L_93abc0:
	st 0xc0010,[r0, 0x38]
L_93abc8:
	mov_s r0,0x1ffffff
L_93abce:
	mov_s r32,r0
L_93abd0:
	st.ab r0,[r25,0x4]
L_93abd4:
	bclr r25,r25,0xa
L_93abd8:
	bl L_93c864
L_93abdc:
	mov_s r0,0x1
L_93abde:
	bl.d L_927928
L_93abe2:
	mov_s r1,0x0
L_93abe4:
	bl.d L_921724
L_93abe8:
	mov_s r0,0x0
L_93abea:
	bl L_93e0dc
L_93abee:
	b L_92029c
L_93abf2:
	nop_s
