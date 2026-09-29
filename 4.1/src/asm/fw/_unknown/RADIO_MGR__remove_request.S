/* RADIO_MGR__remove_request @ 0x8de444, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::remove_request. Handle:0x%x
 * Зовут его: calib_engine__on_abort, maintain_sm__release_radio_after_bf_evt, mlme_sm__assoc_reject_ev_handle, mlme_sm__association_timeout_ev_handle, mlme_sm__data_port_open_ev_handle, mlme_sm__disconnect_ev_handle
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 */
	.section .text.RADIO_MGR__remove_request,"ax",@progbits
	.global RADIO_MGR__remove_request
RADIO_MGR__remove_request:
	.global L_8de444
L_8de444:
	push_s blink
L_8de446:
	push_s r13
L_8de448:
	mov_s r13,r0
L_8de44a:
	mov_s r2,0x1015c58
L_8de450:
	mov_s r0,0x8
L_8de452:
	mov_s r1,0x2
L_8de454:
	bl.d L_8edfcc
L_8de458:
	mov_s r3,r13
L_8de45a:
	ld_s r0,[gp,-0x30]
L_8de45c:
	ld_s r1,[r0]
L_8de45e:
	ld_s r2,[r1,0x18]
L_8de460:
	jl_s.d [r2]
L_8de462:
	mov_s r1,r13
L_8de464:
	b L_8c033c
