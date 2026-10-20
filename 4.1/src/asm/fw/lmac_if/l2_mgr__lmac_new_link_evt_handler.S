/* l2_mgr__lmac_new_link_evt_handler @ 0x8edd08, 340 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::lmac_new_link_evt_handler() L2MGR New link event handler from %04X %04X %04X.
 *   l2_mgr::lmac_new_link_evt_handler() BF status: OK
 *   l2_mgr::lmac_new_link_evt_handler() while find search mode, do link acquisition in
 *   l2_mgr::lmac_new_link_evt_handler() Entered in PCP/DOCK MODE
 *   l2_mgr::lmac_new_link_evt_handler() Entered in STATION MODE
 *   l2_mgr::lmac_new_link_evt_handler() found in list, do link acquisition
 *   l2_mgr::lmac_new_link_evt_handler() link_acquisition FAILED
 *   l2_mgr::lmac_new_link_evt_handler() didn't found in the list, NO link acquisition
 * Зовут его: lmac_if__bf_done_and_new_link
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit3, mid__acquire_link, mid__state_is_2_or_3, mid_list__by_mid, scan_mngr__handle_abft_bf_result_in_scan, scan_mngr__stop_dwelling, search_scan_elem_in_list
 */
	.section .text.l2_mgr__lmac_new_link_evt_handler,"ax",@progbits
	.global l2_mgr__lmac_new_link_evt_handler
l2_mgr__lmac_new_link_evt_handler:
	.global L_8edd08
L_8edd08:
	push_s blink
L_8edd0a:
	bl L_8c02bc
L_8edd0e:
	mov_s r13,r0
L_8edd10:
	mov_s r16,r1
L_8edd12:
	ldw r4,[r0, 0x16]
L_8edd16:
	mov_s r2,0x100de14
L_8edd1c:
	ldw r5,[r0, 0x18]
L_8edd20:
	mov_s r0,0xb
L_8edd22:
	mov_s r1,0x2
L_8edd24:
	bl.d L_8ee034
L_8edd28:
	ldw_s r3,[r13,0x14]
L_8edd2a:
	bl.d L_8ca1b0
L_8edd2e:
	mov_s r0,r16
L_8edd30:
	mov_s r14,r0
L_8edd32:
	mov_s r15,r0
L_8edd34:
	ld_s r0,[r13,0xc]
L_8edd36:
	add r15,r15,0x234
L_8edd3a:
	cmp_s r0,0x1
L_8edd3c:
	ld r16,[r15, 0x8]
L_8edd40:
	bne_s L_8ede24
L_8edd42:
	mov_s r2,0x100de6c
L_8edd48:
	mov_s r0,0xb
L_8edd4a:
	bl.d L_8edfb0
L_8edd4e:
	mov_s r1,0x2
L_8edd50:
	ldb r0,[r15, 0x28]
L_8edd54:
	cmp_s r0,0x4
L_8edd56:
	mov_s r0,0x1
L_8edd58:
	sub_s.ne r0,r0,r0
L_8edd5a:
	extb.f 0x0,r0
L_8edd5e:
	beq_s L_8edd7e
L_8edd60:
	mov_s r2,0x100dea0
L_8edd66:
	mov_s r0,0xb
L_8edd68:
	bl.d L_8edfb0
L_8edd6c:
	mov_s r1,0x2
L_8edd6e:
	add r1,r13,0x14
L_8edd72:
	mov_s r0,r14
L_8edd74:
	mov_s r2,r13
L_8edd76:
	bl.d L_8d7814
L_8edd7a:
	mov_s r3,0x0
L_8edd7c:
	b_s L_8ede56
	.global L_8edd7e
L_8edd7e:
	ld_s r0,[r15,0x8]
L_8edd80:
	ld_s r0,[r0,0x78]
L_8edd82:
	breq_s r0,0,L_8edd94
L_8edd84:
	ld_s r0,[r13,0x10]
L_8edd86:
	brne r0,0x2,L_8edd94
L_8edd8a:
	mov_s r0,r16
L_8edd8c:
	bl.d L_8ebda8
L_8edd90:
	mov_s r1,r13
L_8edd92:
	b_s L_8ede56
	.global L_8edd94
L_8edd94:
	bl.d L_8d73c4
L_8edd98:
	ldb_s r0,[r14,0x10]
L_8edd9a:
	breq_s r0,0,L_8eddbe
L_8edd9c:
	mov_s r2,0x100def4
L_8edda2:
	mov_s r0,0xb
L_8edda4:
	bl.d L_8edfb0
L_8edda8:
	mov_s r1,0x2
L_8eddaa:
	add r1,r13,0x14
L_8eddae:
	mov_s r0,r14
L_8eddb0:
	mov_s r2,r13
L_8eddb2:
	bl.d L_8d7814
L_8eddb6:
	mov_s r3,0x0
L_8eddb8:
	brne r0,0x0,L_8ede56
L_8eddbc:
	b_s L_8ede04
	.global L_8eddbe
L_8eddbe:
	ld r0,[r16, 0x78]
L_8eddc2:
	breq_s r0,0,L_8ede1c
L_8eddc4:
	mov_s r2,0x100df34
L_8eddca:
	mov_s r0,0xb
L_8eddcc:
	bl.d L_8edfb0
L_8eddd0:
	mov_s r1,0x2
L_8eddd2:
	add r0,r16,0xc
L_8eddd6:
	add r16,r13,0x14
L_8eddda:
	bl.d L_8f020c
L_8eddde:
	mov_s r1,r16
L_8edde0:
	mov.f r15,r0
L_8edde4:
	beq_s L_8ede0c
L_8edde6:
	mov_s r2,0x100df70
L_8eddec:
	mov_s r0,0xb
L_8eddee:
	bl.d L_8edfb0
L_8eddf2:
	mov_s r1,0x2
L_8eddf4:
	mov_s r0,r14
L_8eddf6:
	mov_s r1,r16
L_8eddf8:
	mov_s r2,r13
L_8eddfa:
	bl.d L_8d7814
L_8eddfe:
	mov_s r3,0x0
L_8ede00:
	st_s r0,[r15,0x3c]
L_8ede02:
	brne_s r0,0,L_8ede56
	.global L_8ede04
L_8ede04:
	mov_s r2,0x100dfb8
L_8ede0a:
	b_s L_8ede12
	.global L_8ede0c
L_8ede0c:
	mov_s r2,0x100dff4
	.global L_8ede12
L_8ede12:
	mov_s r0,0xb
L_8ede14:
	bl.d L_8edfb0
L_8ede18:
	mov_s r1,0x2
L_8ede1a:
	b_s L_8ede56
	.global L_8ede1c
L_8ede1c:
	mov_s r2,0x100e048
L_8ede22:
	b_s L_8ede12
	.global L_8ede24
L_8ede24:
	mov_s r2,0x100e090
L_8ede2a:
	mov_s r0,0xb
L_8ede2c:
	bl.d L_8edfb0
L_8ede30:
	mov_s r1,0x2
L_8ede32:
	ld_s r2,[r15,0x8]
L_8ede34:
	ld_s r0,[r2,0x78]
L_8ede36:
	breq_s r0,0,L_8ede56
L_8ede38:
	ld_s r1,[r2,0x6c]
L_8ede3a:
	mov_s r0,0x0
L_8ede3c:
	brne r1,0x3,L_8ede4a
L_8ede40:
	ldb r1,[r2, 0x8d]
L_8ede44:
	cmp_s r1,0x1
L_8ede46:
	mov.eq r0,0x1
	.global L_8ede4a
L_8ede4a:
	extb.f 0x0,r0
L_8ede4e:
	bl.ne.d L_8f1790
L_8ede52:
	mov.ne r0,r16
	.global L_8ede56
L_8ede56:
	b L_8c0324
L_8ede5a:
	nop_s
