/* scan_mngr__handle_abft_bf_result_in_scan @ 0x8f3a8c, 224 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, alloc_dband_info, find_main_sm__bcon_step, fw_log_emit0, fw_log_emit1, fw_log_emit2, list__find_entry_d, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__handle_abft_bf_result_in_scan
scan_mngr__handle_abft_bf_result_in_scan:
	.global L_8f3a8c
L_8f3a8c:
	push_s blink
L_8f3a8e:
	bl L_8c01e0
L_8f3a92:
	mov_s r15,r0
L_8f3a94:
	ld_s r0,[r1,0x34]
L_8f3a96:
	mov_s r13,r1
L_8f3a98:
	st.a r0,[sp,-0x8]
L_8f3a9c:
	ldw_s r0,[r1,0x38]
L_8f3a9e:
	mov_s r14,sp
L_8f3aa0:
	stw r0,[sp, 0x4]
L_8f3aa4:
	mov_s r1,0x1015aa8
L_8f3aaa:
	bl.d L_8dcba8
L_8f3aae:
	mov_s r0,0x29
L_8f3ab0:
	mov_s r0,r15
L_8f3ab2:
	bl.d L_8f8574
L_8f3ab6:
	mov_s r1,r14
L_8f3ab8:
	breq_s r0,0,L_8f3acc
L_8f3aba:
	ldb_s r1,[r13,0x6]
L_8f3abc:
	stb r1,[r0, 0x38]
L_8f3ac0:
	ld_s r1,[r13]
L_8f3ac2:
	st_s r1,[r0,0x3c]
L_8f3ac4:
	ld_s r1,[r13,0x30]
L_8f3ac6:
	stb r1,[r0, 0x40]
L_8f3aca:
	b_s L_8f3b66
	.global L_8f3acc
L_8f3acc:
	add r0,r15,0xc
L_8f3ad0:
	bl.d L_8f8574
L_8f3ad4:
	mov_s r1,r14
L_8f3ad6:
	brne r0,0x0,L_8f3b66
L_8f3ada:
	ld_s r0,[r15]
L_8f3adc:
	brlo r0,0x8,L_8f3aee
L_8f3ae0:
	mov_s r1,0x1015ad4
	.global L_8f3ae6
L_8f3ae6:
	bl.d L_8dcba8
L_8f3aea:
	mov_s r0,0x19
L_8f3aec:
	b_s L_8f3b66
	.global L_8f3aee
L_8f3aee:
	bl L_8f0cf8
L_8f3af2:
	mov.f r14,r0
L_8f3af6:
	bne_s L_8f3b00
L_8f3af8:
	mov_s r1,0x1015b44
L_8f3afe:
	b_s L_8f3ae6
	.global L_8f3b00
L_8f3b00:
	ld_s r0,[sp,0x0]
L_8f3b02:
	st_s r0,[r14,0x8]
L_8f3b04:
	ldw r0,[sp, 0x4]
L_8f3b08:
	stw_s r0,[r14,0xc]
L_8f3b0a:
	ldb_s r0,[r13,0x6]
L_8f3b0c:
	stb r0,[r14, 0x38]
L_8f3b10:
	ld_s r0,[r13]
L_8f3b12:
	st_s r0,[r14,0x3c]
L_8f3b14:
	ld_s r0,[r13,0x30]
L_8f3b16:
	stb r0,[r14, 0x40]
L_8f3b1a:
	mov_s r0,0x2
L_8f3b1c:
	stb r0,[r14, 0x41]
L_8f3b20:
	mov_s r0,0x0
L_8f3b22:
	st_s r0,[r14,0x44]
L_8f3b24:
	ldb r0,[r15,0x214]
L_8f3b2c:
	stb r0,[r14, 0x39]
L_8f3b30:
	mov_s r0,r15
L_8f3b32:
	bl.d L_8c25f4
L_8f3b36:
	mov_s r1,r14
L_8f3b38:
	ldw_s r2,[r14,0xc]
L_8f3b3a:
	mov_s r1,0x1015b8c
L_8f3b40:
	mov_s r0,0x29
L_8f3b42:
	bl.d L_8dcc80
L_8f3b46:
	ld_s r3,[r14,0x8]
L_8f3b48:
	mov_s r1,0x1015a1c
L_8f3b4e:
	mov_s r0,0x29
L_8f3b50:
	bl.d L_8dcc10
L_8f3b54:
	ld_s r2,[r14,0x4]
L_8f3b56:
	mov_s r0,0x395bc
L_8f3b5c:
	mov_s r1,r15
L_8f3b5e:
	mov_s r2,r14
L_8f3b60:
	bl.d L_8c3248
L_8f3b64:
	mov_s r3,0x1
	.global L_8f3b66
L_8f3b66:
	b.d L_8c024c
L_8f3b6a:
	add_s sp,sp,0x8
