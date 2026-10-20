/* scan_mngr__clean_all_lists @ 0x8f1aa0, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::clean_all_lists() from scan list:  ADDR-%04X%08X system_states: %d
 *   scan_mngr::clean_all_lists() from pending list:  ADDR-%04X%08X system_states: %d
 *   scan_mngr::clean_all_lists() p_dband_info->conn_ptr: %d already free
 *   scan_mngr::clean_all_lists() FREE DBAND pending elements  0x%X
 *   scan_mngr::clean_all_lists() reset_active_probs
 * Зовут его: scan_mngr__dwelling_done, scan_mngr__scan_done, scan_mngr__sm_dwelling_ended
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn_mgr__link_down_evt, conn_tbl__slot_is_free, free_dband_info, fw_log_emit0, fw_log_emit1, fw_log_emit3, llist__pop_front, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__clean_all_lists
scan_mngr__clean_all_lists:
	.global L_8f1aa0
L_8f1aa0:
	push_s blink
L_8f1aa2:
	bl L_8c01e4
L_8f1aa6:
	mov_s r14,r0
L_8f1aa8:
	b_s L_8f1aca
	.global L_8f1aaa
L_8f1aaa:
	bl L_8e2674
L_8f1aae:
	mov_s r1,0x101544c
L_8f1ab4:
	ldb r4,[r0, 0x41]
L_8f1ab8:
	mov_s r13,r0
L_8f1aba:
	ldw_s r2,[r13,0xc]
L_8f1abc:
	mov_s r0,0x29
L_8f1abe:
	bl.d L_8dcd00
L_8f1ac2:
	ld_s r3,[r13,0x8]
L_8f1ac4:
	bl.d L_8f31a0
L_8f1ac8:
	mov_s r0,r13
	.global L_8f1aca
L_8f1aca:
	add r0,r14,0xc
L_8f1ace:
	ld_s r1,[r0]
L_8f1ad0:
	sub.f r1,r1,0x0
L_8f1ad4:
	mov.ne r1,0x1
L_8f1ad8:
	extb.f 0x0,r1
L_8f1adc:
	bne_s L_8f1aaa
L_8f1ade:
	b_s L_8f1b42
	.global L_8f1ae0
L_8f1ae0:
	bl.d L_8e2674
L_8f1ae4:
	mov_s r0,r14
L_8f1ae6:
	mov_s r13,r0
L_8f1ae8:
	ld_s r0,[r0,0x48]
L_8f1aea:
	breq_s r0,0,L_8f1af4
L_8f1aec:
	bl L_8c8de0
L_8f1af0:
	mov_s r0,0x0
L_8f1af2:
	st_s r0,[r13,0x48]
	.global L_8f1af4
L_8f1af4:
	ld_s r0,[r13,0x44]
L_8f1af6:
	breq_s r0,0,L_8f1b2e
L_8f1af8:
	ld_s r0,[r13,0x34]
L_8f1afa:
	brne_s r0,0,L_8f1b2e
L_8f1afc:
	ldb r4,[r13, 0x41]
L_8f1b00:
	mov_s r1,0x101549c
L_8f1b06:
	ldw_s r2,[r13,0xc]
L_8f1b08:
	mov_s r0,0x29
L_8f1b0a:
	bl.d L_8dcd00
L_8f1b0e:
	ld_s r3,[r13,0x8]
L_8f1b10:
	bl.d L_8da10c
L_8f1b14:
	ld_s r0,[r13,0x44]
L_8f1b16:
	ld_s r2,[r13,0x44]
L_8f1b18:
	brne_s r0,0,L_8f1b22
L_8f1b1a:
	bl.d L_8daae8
L_8f1b1e:
	mov_s r0,r2
L_8f1b20:
	b_s L_8f1b2e
	.global L_8f1b22
L_8f1b22:
	mov_s r1,0x10154f0
L_8f1b28:
	bl.d L_8dcc10
L_8f1b2c:
	mov_s r0,0x19
	.global L_8f1b2e
L_8f1b2e:
	mov_s r1,0x1015538
L_8f1b34:
	mov_s r0,0x29
L_8f1b36:
	bl.d L_8dcc10
L_8f1b3a:
	mov_s r2,r13
L_8f1b3c:
	bl.d L_8f31a0
L_8f1b40:
	mov_s r0,r13
	.global L_8f1b42
L_8f1b42:
	ld_s r0,[r14]
L_8f1b44:
	sub.f r0,r0,0x0
L_8f1b48:
	mov.ne r0,0x1
L_8f1b4c:
	extb.f 0x0,r0
L_8f1b50:
	bne_s L_8f1ae0
L_8f1b52:
	mov_s r1,0x1015578
L_8f1b58:
	bl.d L_8dcba8
L_8f1b5c:
	mov_s r0,0x29
L_8f1b5e:
	mov_s r0,0x0
L_8f1b60:
	add r14,r14,0x215
L_8f1b64:
	b.d L_8c0254
L_8f1b68:
	stb_s r0,[r14]
L_8f1b6a:
	nop_s
