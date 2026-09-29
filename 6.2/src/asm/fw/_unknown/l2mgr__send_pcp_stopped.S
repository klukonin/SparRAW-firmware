/* l2mgr__send_pcp_stopped @ 0x8f8ac0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_PCP_STOPPED_EVENTID for midid %d.
 * Зовут его: pcp_stop__flow
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, host_if__send_pair, l2mgr__pending_op_clear, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__send_pcp_stopped
l2mgr__send_pcp_stopped:
	.global L_8f8ac0
L_8f8ac0:
	push_s blink
L_8f8ac2:
	push_s r13
L_8f8ac4:
	mov_s r13,r0
L_8f8ac6:
	mov_s r1,0x100ed64
L_8f8acc:
	mov_s r0,0x2b
L_8f8ace:
	bl.d L_8dcc10
L_8f8ad2:
	mov_s r2,r13
L_8f8ad4:
	bl L_8c32d8
L_8f8ad8:
	mov_s r1,0x1919
L_8f8ade:
	mov_s r2,0x0
L_8f8ae0:
	mov_s r3,r13
L_8f8ae2:
	mov_s r4,r2
L_8f8ae4:
	mov_s r5,r2
L_8f8ae6:
	bl.d L_8e5474
L_8f8aea:
	mov_s r6,r2
L_8f8aec:
	bl.d L_8c6a30
L_8f8af0:
	mov_s r0,0x4
L_8f8af2:
	b L_8c025c
L_8f8af6:
	nop_s
