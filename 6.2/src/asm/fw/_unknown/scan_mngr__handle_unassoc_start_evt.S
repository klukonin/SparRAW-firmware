/* scan_mngr__handle_unassoc_start_evt @ 0x8cdc80, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::handle_unassoc_start_evt() - Resetting connected scan time.
 * Зовут его: scan_mngr__system_state_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, conn_mgr__by_cid, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__handle_unassoc_start_evt
scan_mngr__handle_unassoc_start_evt:
	.global L_8cdc80
L_8cdc80:
	push_s blink
L_8cdc82:
	bl.d L_8cbffc
L_8cdc86:
	push_s r13
L_8cdc88:
	mov.f r13,r0
L_8cdc8c:
	beq_s L_8cdcaa
	.global L_8cdc8e
L_8cdc8e:
	ld_s r0,[r13,0x18]
L_8cdc90:
	mov_s r1,0x10163b4
L_8cdc96:
	ld.as r13,[r0,0x8f]
L_8cdc9a:
	bl.d L_8dcba8
L_8cdc9e:
	mov_s r0,0x29
L_8cdca0:
	mov_s r0,0x0
L_8cdca2:
	b.d L_8c025c
L_8cdca6:
	st.as r0,[r13,0x86]
	.global L_8cdcaa
L_8cdcaa:
	mov_s r0,blink
L_8cdcac:
	mov_s r1,0x1246
L_8cdcb2:
	bl L_8c9b28
L_8cdcb6:
	b_s L_8cdc8e
