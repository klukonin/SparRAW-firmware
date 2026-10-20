/* pcp_psc_sm__send_usol_psc_resp_sm_8e5d90 @ 0x8e5d90, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::send_usol_psc_resp_sm
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, pcp_psc_sm__send_psc_resp_flow
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__send_usol_psc_resp_sm_8e5d90
pcp_psc_sm__send_usol_psc_resp_sm_8e5d90:
	.global L_8e5d90
L_8e5d90:
	push_s blink
L_8e5d92:
	push_s r13
L_8e5d94:
	mov_s r13,r0
L_8e5d96:
	mov_s r1,0x1002b58
L_8e5d9c:
	bl.d L_8dcba8
L_8e5da0:
	mov_s r0,0x2e
L_8e5da2:
	bl.d L_8e5c98
L_8e5da6:
	mov_s r0,r13
L_8e5da8:
	b L_8c025c
