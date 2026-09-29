/* mlme_sm__data_port_open_ev_handle @ 0x8ea9d4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DATA PORT OPEN event.
 *   mlme_sm::data_port_open_ev_handle()  remove_request 0x%x ,locked: 0x%x
 *   MLME_UNLOCK_RADIO - unlocking radio 0x%x
 *   MLME_UNLOCK_RADIO - remove request 0x%x
 * Зовёт сам: RADIO_MGR__remove_request, RADIO_MGR__unlock, __ld_r14_to_r13_ret, fw_log__emit0, fw_log__emit1, fw_log__emit2, u_schd__cancel
 */
	.section .text.mlme_sm__data_port_open_ev_handle,"ax",@progbits
	.global mlme_sm__data_port_open_ev_handle
mlme_sm__data_port_open_ev_handle:
L_8ea9d4:
	mov_s r13,r0
	.global fwlog_mlme_sm_data_port_open_ev_handle_remove_
fwlog_mlme_sm_data_port_open_ev_handle_remove_:
L_8ea9d6:
	mov_s r2,0x100f690
L_8ea9dc:
	bl.d L_8edfb0
L_8ea9e0:
	mov_s r0,0xa
L_8ea9e2:
	ld_s r0,[r13,0x38]
L_8ea9e4:
	mov_s r14,0x0
L_8ea9e6:
	breq_s r0,0,L_8ea9ee
L_8ea9e8:
	bl L_8c7794
L_8ea9ec:
	st_s r14,[r13,0x38]
	.global L_8ea9ee
L_8ea9ee:
	mov_s r2,0x100f6a8
L_8ea9f4:
	ld r4,[r13, 0x2c]
L_8ea9f8:
	mov_s r0,0x0
L_8ea9fa:
	mov_s r1,0x2
L_8ea9fc:
	bl.d L_8edff8
L_8eaa00:
	ld_s r3,[r13,0x34]
L_8eaa02:
	ld_s r3,[r13,0x34]
L_8eaa04:
	breq_s r3,0,L_8eaa34
L_8eaa06:
	ld_s r0,[r13,0x2c]
L_8eaa08:
	breq_s r0,0,L_8eaa20
L_8eaa0a:
	mov_s r2,0x100f448
L_8eaa10:
	mov_s r0,0xc
L_8eaa12:
	bl.d L_8edfcc
L_8eaa16:
	mov_s r1,0x2
L_8eaa18:
	bl.d L_8e54d8
L_8eaa1c:
	ld_s r0,[r13,0x34]
L_8eaa1e:
	b_s L_8eaa34
	.global L_8eaa20
L_8eaa20:
	mov_s r2,0x100f474
L_8eaa26:
	mov_s r0,0xc
L_8eaa28:
	bl.d L_8edfcc
L_8eaa2c:
	mov_s r1,0x2
L_8eaa2e:
	bl.d L_8de444
L_8eaa32:
	ld_s r0,[r13,0x34]
	.global L_8eaa34
L_8eaa34:
	st_s r14,[r13,0x34]
L_8eaa36:
	b.d L_8c0334
L_8eaa3a:
	st_s r14,[r13,0x2c]
