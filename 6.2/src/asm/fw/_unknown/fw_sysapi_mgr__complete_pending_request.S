/* fw_sysapi_mgr__complete_pending_request @ 0x8f1c50, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::complete_pending_request(): m_completion_cb=0x%x
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__complete_pending_request
fw_sysapi_mgr__complete_pending_request:
	.global L_8f1c50
L_8f1c50:
	push_s blink
L_8f1c52:
	bl L_8c01e0
L_8f1c56:
	mov_s r13,r0
L_8f1c58:
	mov_s r15,r1
L_8f1c5a:
	mov_s r14,r2
L_8f1c5c:
	mov_s r1,0x1012354
L_8f1c62:
	mov_s r0,0x25
L_8f1c64:
	bl.d L_8dcc10
L_8f1c68:
	ld_s r2,[r13,0x34]
L_8f1c6a:
	ld_s r3,[r13,0x34]
L_8f1c6c:
	cmp_s r3,0x0
L_8f1c6e:
	mov.ne r0,r13
L_8f1c72:
	mov.ne r1,r15
L_8f1c76:
	jlne.d [r3]
L_8f1c7a:
	mov.ne r2,r14
L_8f1c7e:
	b L_8c024c
L_8f1c82:
	nop_s
