/* pcp_psc_sm__send_usol_psc_resp_sm @ 0x8e10b4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::send_usol_psc_resp_sm
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, pcp_psc_sm__send_psc_resp_flow
 */
	.section .text.pcp_psc_sm__send_usol_psc_resp_sm,"ax",@progbits
	.global pcp_psc_sm__send_usol_psc_resp_sm
pcp_psc_sm__send_usol_psc_resp_sm:
	.byte 0x8f
	.byte 0xef
	.global fwlog_pcp_psc_sm_send_usol_psc_resp_sm
fwlog_pcp_psc_sm_send_usol_psc_resp_sm:
L_8e10b6:
	nop_s
L_8e10b8:
	push_s blink
L_8e10ba:
	push_s r13
L_8e10bc:
	mov_s r13,r0
L_8e10be:
	mov_s r2,0x10031b8
L_8e10c4:
	mov_s r0,0xe
L_8e10c6:
	bl.d L_8edfb0
L_8e10ca:
	mov_s r1,0x2
L_8e10cc:
	bl.d L_8e0ff4
L_8e10d0:
	mov_s r0,r13
L_8e10d2:
	b L_8c033c
L_8e10d6:
	nop_s
