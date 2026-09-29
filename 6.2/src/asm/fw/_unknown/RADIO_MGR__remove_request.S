/* RADIO_MGR__remove_request @ 0x8e2798, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::remove_request. Handle:0x%x
 * Зовут его: calib_engine__on_abort, maintain_sm__release_radio_after_bf_evt, mlme_sm__assoc_reject_ev_handle, mlme_sm__association_timeout_ev_handle, mlme_sm__data_port_open_ev_handle_8f21c0, mlme_sm__disconnect_ev_handle_8f26a8
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global RADIO_MGR__remove_request
RADIO_MGR__remove_request:
	.global L_8e2798
L_8e2798:
	push_s blink
L_8e279a:
	push_s r13
L_8e279c:
	mov_s r13,r0
L_8e279e:
	mov_s r1,0x1019068
L_8e27a4:
	mov_s r0,0x28
L_8e27a6:
	bl.d L_8dcc10
L_8e27aa:
	mov_s r2,r13
L_8e27ac:
	ld_s r0,[gp,-0x40]
L_8e27ae:
	ld_s r1,[r0]
L_8e27b0:
	ld_s r2,[r1,0x18]
L_8e27b2:
	jl_s.d [r2]
L_8e27b4:
	mov_s r1,r13
L_8e27b6:
	b L_8c025c
L_8e27ba:
	nop_s
