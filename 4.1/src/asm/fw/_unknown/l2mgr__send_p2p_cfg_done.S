/* l2mgr__send_p2p_cfg_done @ 0x8f033c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_P2P_CFG_DONE_EVENTID for midid %d.
 * Зовут его: find_mngr__cfg_offload, l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_p2p_cfg_done,"ax",@progbits
	.global l2mgr__send_p2p_cfg_done
l2mgr__send_p2p_cfg_done:
	.global L_8f033c
L_8f033c:
	push_s blink
L_8f033e:
	bl L_8c02c0
L_8f0342:
	mov_s r14,r0
L_8f0344:
	bl.d L_8c2b68
L_8f0348:
	mov_s r15,r1
L_8f034a:
	mov_s r13,r0
L_8f034c:
	bl.d L_8c1a78
L_8f0350:
	mov_s r1,0x4
L_8f0352:
	stb_s r14,[r13]
L_8f0354:
	mov_s r2,0x100cef8
L_8f035a:
	mov_s r0,0xb
L_8f035c:
	mov_s r1,0x2
L_8f035e:
	bl.d L_8edfcc
L_8f0362:
	mov_s r3,r15
L_8f0364:
	mov_s r0,r13
L_8f0366:
	mov_s r1,0x1910
L_8f036c:
	mov_s r2,0x4
L_8f036e:
	mov_s r3,r15
L_8f0370:
	mov r4,0x0
L_8f0374:
	bl.d L_8e0874
L_8f0378:
	mov r5,r4
L_8f037c:
	b L_8c032c
