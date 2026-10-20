/* scan_mngr__handle_abft_bf_result_in_scan @ 0x8ebda8, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::handle_abft_bf_result_in_scan()
 *   scan_mngr::handle_abft_bf_result_in_scan() exit. maximum allocation for pending list is WMI_MAX_ASSOC_STA(8)
 *   scan_mngr::handle_abft_bf_result_in_scan() exit. p_dband_info == NULL
 *   scan_mngr::handle_abft_bf_result_in_scan() Added entry to m_scan_pend_list after ABFT BF flow during scan. from BSSID: ADDR-%04X%08X
 *   [NNL] container:%d
 * Зовут его: l2_mgr__lmac_new_link_evt_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, alloc_dband_info, fw_log__emit0, fw_log__emit1, fw_log__emit2, llist__insert, search_scan_elem_in_list, u_schd__add
 */
	.section .text.scan_mngr__handle_abft_bf_result_in_scan,"ax",@progbits
	.global scan_mngr__handle_abft_bf_result_in_scan
scan_mngr__handle_abft_bf_result_in_scan:
	.global L_8ebda8
L_8ebda8:
	push_s blink
L_8ebdaa:
	bl L_8c02bc
L_8ebdae:
	mov_s r15,r0
L_8ebdb0:
	ld_s r0,[r1,0x14]
L_8ebdb2:
	mov_s r13,r1
L_8ebdb4:
	st.a r0,[sp,-0x8]
L_8ebdb8:
	ldw_s r0,[r1,0x18]
L_8ebdba:
	mov_s r14,sp
L_8ebdbc:
	stw r0,[sp, 0x4]
L_8ebdc0:
	mov_s r2,0x1013388
L_8ebdc6:
	mov_s r0,0x9
L_8ebdc8:
	mov_s r1,0x2
L_8ebdca:
	bl.d L_8edfb0
L_8ebdce:
	mov_s r16,r1
L_8ebdd0:
	mov_s r0,r15
L_8ebdd2:
	bl.d L_8f020c
L_8ebdd6:
	mov_s r1,r14
L_8ebdd8:
	breq_s r0,0,L_8ebdec
L_8ebdda:
	ldb_s r1,[r13,0x6]
L_8ebddc:
	stb r1,[r0, 0x31]
L_8ebde0:
	ld_s r1,[r13]
L_8ebde2:
	st_s r1,[r0,0x34]
L_8ebde4:
	ld_s r1,[r13,0x10]
L_8ebde6:
	stb r1,[r0, 0x38]
L_8ebdea:
	b_s L_8ebe80
	.global L_8ebdec
L_8ebdec:
	add r0,r15,0xc
L_8ebdf0:
	bl.d L_8f020c
L_8ebdf4:
	mov_s r1,r14
L_8ebdf6:
	brne r0,0x0,L_8ebe80
L_8ebdfa:
	ld_s r0,[r15]
L_8ebdfc:
	brlo r0,0x8,L_8ebe10
L_8ebe00:
	mov_s r2,0x10133b4
	.global L_8ebe06
L_8ebe06:
	mov_s r0,0x9
L_8ebe08:
	bl.d L_8edfb0
L_8ebe0c:
	mov_s r1,0x1
L_8ebe0e:
	b_s L_8ebe80
	.global L_8ebe10
L_8ebe10:
	bl L_8e94a4
L_8ebe14:
	mov.f r14,r0
L_8ebe18:
	bne_s L_8ebe22
L_8ebe1a:
	mov_s r2,0x1013424
L_8ebe20:
	b_s L_8ebe06
	.global L_8ebe22
L_8ebe22:
	ld_s r0,[sp,0x0]
L_8ebe24:
	add r1,r14,0x20
L_8ebe28:
	st_s r0,[r14,0x8]
L_8ebe2a:
	ldw r0,[sp, 0x4]
L_8ebe2e:
	stw_s r0,[r14,0xc]
L_8ebe30:
	ldb_s r0,[r13,0x6]
L_8ebe32:
	stb_s r0,[r1,0x11]
L_8ebe34:
	ld_s r0,[r13]
L_8ebe36:
	st_s r0,[r14,0x34]
L_8ebe38:
	ld_s r0,[r13,0x10]
L_8ebe3a:
	stb r16,[r1, 0x19]
L_8ebe3e:
	stb_s r0,[r1,0x18]
L_8ebe40:
	mov_s r0,0x0
L_8ebe42:
	st_s r0,[r14,0x3c]
L_8ebe44:
	mov_s r0,r15
L_8ebe46:
	bl.d L_8c1fc4
L_8ebe4a:
	mov_s r1,r14
L_8ebe4c:
	mov_s r2,0x101346c
L_8ebe52:
	ld r4,[r14, 0x8]
L_8ebe56:
	mov_s r0,0x9
L_8ebe58:
	mov_s r1,r16
L_8ebe5a:
	bl.d L_8edff8
L_8ebe5e:
	ldw_s r3,[r14,0xc]
L_8ebe60:
	mov_s r2,0x10132fc
L_8ebe66:
	mov_s r0,0x9
L_8ebe68:
	mov_s r1,r16
L_8ebe6a:
	bl.d L_8edfcc
L_8ebe6e:
	ld_s r3,[r14,0x4]
L_8ebe70:
	mov_s r0,0x31280
L_8ebe76:
	mov_s r1,r15
L_8ebe78:
	mov_s r2,r14
L_8ebe7a:
	bl.d L_8c2ac8
L_8ebe7e:
	mov_s r3,0x1
	.global L_8ebe80
L_8ebe80:
	b.d L_8c0324
L_8ebe84:
	add_s sp,sp,0x8
L_8ebe86:
	nop_s
