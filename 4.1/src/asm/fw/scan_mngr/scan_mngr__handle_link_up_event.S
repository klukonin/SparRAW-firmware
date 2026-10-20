/* scan_mngr__handle_link_up_event @ 0x8ebee4, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::handle_link_up_event() SM STATE = %d, m_active_probs = %d
 *   scan_mngr::handle_link_up_event() Rx Link_UP from: ADDR-%04X%08X
 *   scan_mngr::handle_link_up_event() p_dband_info->status = %d
 *   scan_mngr::handle_link_up_event() p_dband_info->conn_ptr = 0x%X, p_conn = 0x%X
 *   scan_mngr::handle_link_up_event() Link up failure notification CID %d.
 *   scan_mngr.cpp
 *   scan_mngr::handle_link_up_event() Link up event from non desired connection
 * Зовут его: l2mgr__notify_link_up
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, scan_mngr__prob_done, scan_mngr__send_prob_req, search_scan_elem_in_list
 */
	.section .text.scan_mngr__handle_link_up_event,"ax",@progbits
	.global scan_mngr__handle_link_up_event
scan_mngr__handle_link_up_event:
	.global L_8ebee4
L_8ebee4:
	push_s blink
L_8ebee6:
	bl L_8c02b8
L_8ebeea:
	mov_s r17,r0
L_8ebeec:
	add3 r13,r0,0x10
L_8ebef0:
	ld_s r0,[r13,0x8]
L_8ebef2:
	mov_s r16,r1
L_8ebef4:
	mov_s r14,r2
L_8ebef6:
	brne r0,0x0,L_8ebfce
L_8ebefa:
	ld_s r3,[r13,0x4]
L_8ebefc:
	mov_s r2,0x10139a0
L_8ebf02:
	ldb r4,[r13, 0xc]
L_8ebf06:
	mov_s r0,0x9
L_8ebf08:
	mov_s r1,0x2
L_8ebf0a:
	bl.d L_8edff8
L_8ebf0e:
	ldb_s r3,[r3]
L_8ebf10:
	ld_s r0,[r13,0x4]
L_8ebf12:
	ldb_s r0,[r0]
L_8ebf14:
	brne r0,0x4,L_8ebfce
L_8ebf18:
	breq r16,0x0,L_8ebf9e
	.global L_8ebf1c
L_8ebf1c:
	add r13,r16,0x10
L_8ebf20:
	mov_s r2,0x10139e8
L_8ebf26:
	ld r4,[r13]
L_8ebf2a:
	mov_s r0,0x9
L_8ebf2c:
	mov_s r1,0x2
L_8ebf2e:
	bl.d L_8edff8
L_8ebf32:
	ldw_s r3,[r13,0x4]
L_8ebf34:
	mov_s r0,r17
L_8ebf36:
	bl.d L_8f020c
L_8ebf3a:
	mov_s r1,r13
L_8ebf3c:
	mov.f r13,r0
L_8ebf40:
	beq_s L_8ebfc0
L_8ebf42:
	mov_s r2,0x1013a2c
L_8ebf48:
	mov_s r0,0x9
L_8ebf4a:
	mov_s r1,0x2
L_8ebf4c:
	bl.d L_8edfcc
L_8ebf50:
	ldb r3,[r13, 0x39]
L_8ebf54:
	mov_s r2,0x1013a68
L_8ebf5a:
	ld_s r3,[r13,0x3c]
L_8ebf5c:
	mov_s r0,0x9
L_8ebf5e:
	mov_s r1,0x2
L_8ebf60:
	bl.d L_8edff8
L_8ebf64:
	mov r4,r16
L_8ebf68:
	ldb r0,[r13, 0x39]
L_8ebf6c:
	cmp_s r0,0x1
L_8ebf6e:
	cmp.ne r0,0x2
L_8ebf72:
	bne_s L_8ebfce
L_8ebf74:
	st r16,[r13, 0x3c]
L_8ebf78:
	brne r14,0x1,L_8ebfb6
L_8ebf7c:
	brne r0,0x1,L_8ebfce
L_8ebf80:
	mov_s r2,0x1013ab8
L_8ebf86:
	mov_s r0,0x9
L_8ebf88:
	mov_s r1,0x2
L_8ebf8a:
	bl.d L_8edfcc
L_8ebf8e:
	ldb r3,[r16, 0x8]
L_8ebf92:
	mov_s r0,r17
L_8ebf94:
	mov_s r1,0x2
L_8ebf96:
	bl.d L_8ef034
L_8ebf9a:
	mov_s r2,r13
L_8ebf9c:
	b_s L_8ebfce
	.global L_8ebf9e
L_8ebf9e:
	mov_s r0,blink
L_8ebfa0:
	mov_s r2,0x1012bb8
L_8ebfa6:
	mov_s r1,0x1249
L_8ebfac:
	bl.d L_8c82c0
L_8ebfb0:
	mov r3,0x100
L_8ebfb4:
	b_s L_8ebf1c
	.global L_8ebfb6
L_8ebfb6:
	mov_s r0,r17
L_8ebfb8:
	bl.d L_8f082c
L_8ebfbc:
	mov_s r1,r13
L_8ebfbe:
	b_s L_8ebfce
	.global L_8ebfc0
L_8ebfc0:
	mov_s r2,0x1013b00
L_8ebfc6:
	mov_s r0,0x9
L_8ebfc8:
	bl.d L_8edfb0
L_8ebfcc:
	mov_s r1,0x2
	.global L_8ebfce
L_8ebfce:
	.byte 0x51,0x03
