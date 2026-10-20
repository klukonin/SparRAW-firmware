/* l2mgr__send_p2p_cfg_done @ 0x8f8684, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_P2P_CFG_DONE_EVENTID for midid %d.
 * Зовут его: find_mngr__cfg_offload, l2_mgr__wmi_cmd_handler_p2p_cfg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_p2p_cfg_done
l2mgr__send_p2p_cfg_done:
	.global L_8f8684
L_8f8684:
	push_s blink
L_8f8686:
	bl L_8c01e0
L_8f868a:
	mov_s r14,r0
L_8f868c:
	bl.d L_8c32d8
L_8f8690:
	mov_s r15,r1
L_8f8692:
	mov_s r13,r0
L_8f8694:
	bl.d L_8c1cd8
L_8f8698:
	mov_s r1,0x4
L_8f869a:
	stb_s r14,[r13]
L_8f869c:
	mov_s r1,0x100df94
L_8f86a2:
	mov_s r0,0x2b
L_8f86a4:
	bl.d L_8dcc10
L_8f86a8:
	mov_s r2,r15
L_8f86aa:
	mov_s r0,r13
L_8f86ac:
	mov_s r1,0x1910
L_8f86b2:
	mov_s r2,0x4
L_8f86b4:
	mov_s r3,r15
L_8f86b6:
	mov r4,0x0
L_8f86ba:
	mov r5,r4
L_8f86be:
	bl.d L_8e5474
L_8f86c2:
	mov r6,r4
L_8f86c6:
	b L_8c024c
L_8f86ca:
	nop_s
