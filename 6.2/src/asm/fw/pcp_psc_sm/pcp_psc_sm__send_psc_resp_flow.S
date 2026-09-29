/* pcp_psc_sm__send_psc_resp_flow @ 0x8e5c98, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::send_psc_resp_flow.
 * Зовут его: pcp_psc_sm__psc_start_flow_8e1c14, pcp_psc_sm__send_usol_psc_resp_sm_8e5d90
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_sysassert_fatal, pcp_psc_sm__build_psc_resp, u_schd__schedule
 * Глобалы (через gp): 0x800434
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__send_psc_resp_flow
pcp_psc_sm__send_psc_resp_flow:
	.global L_8e5c98
L_8e5c98:
	push_s blink
L_8e5c9a:
	push_s r13
L_8e5c9c:
	mov_s r13,r0
L_8e5c9e:
	mov_s r1,0x1002ba8
L_8e5ca4:
	bl.d L_8dcba8
L_8e5ca8:
	mov_s r0,0x2e
L_8e5caa:
	bl.d L_8e5c0c
L_8e5cae:
	mov_s r0,r13
L_8e5cb0:
	ld_s r0,[r13,0x8]
L_8e5cb2:
	brne_s r0,0,L_8e5cd2
	.global L_8e5cb4
L_8e5cb4:
	mov_s r0,0x21bb8
L_8e5cba:
	ld.as r4,[gp,0xac]
L_8e5cbe:
	mov_s r1,r13
L_8e5cc0:
	mov_s r2,0x0
L_8e5cc2:
	mov_s r3,r2
L_8e5cc4:
	mov_s r5,r2
L_8e5cc6:
	bl.d L_8e0c0c
L_8e5cca:
	mov_s r6,r2
L_8e5ccc:
	b.d L_8c025c
L_8e5cd0:
	st_s r0,[r13,0x8]
	.global L_8e5cd2
L_8e5cd2:
	mov_s r0,blink
L_8e5cd4:
	mov_s r1,0x1426
L_8e5cda:
	bl L_8c9b28
L_8e5cde:
	b_s L_8e5cb4
