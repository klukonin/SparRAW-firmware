/* pcp_psc_sm__send_psc_resp_flow @ 0x8e0ff4, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::send_psc_resp_flow.
 *   pcp_psc_sm.cpp
 * Зовут его: pcp_psc_sm__psc_start_flow, pcp_psc_sm__send_usol_psc_resp_sm
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_sysassert_fatal, pcp_psc_sm__build_psc_resp, u_schd__schedule
 * Глобалы (через gp): 0x80041c
 */
	.section .text.pcp_psc_sm__send_psc_resp_flow,"ax",@progbits
	.global pcp_psc_sm__send_psc_resp_flow
pcp_psc_sm__send_psc_resp_flow:
	.global L_8e0ff4
L_8e0ff4:
	push_s blink
L_8e0ff6:
	push_s r13
L_8e0ff8:
	mov_s r13,r0
L_8e0ffa:
	mov_s r2,0x1003120
L_8e1000:
	mov_s r0,0xe
L_8e1002:
	bl.d L_8edfb0
L_8e1006:
	mov_s r1,0x2
L_8e1008:
	bl.d L_8e0f5c
L_8e100c:
	mov_s r0,r13
L_8e100e:
	ld_s r0,[r13,0x2c]
L_8e1010:
	brne_s r0,0,L_8e1030
	.global L_8e1012
L_8e1012:
	mov_s r0,0x1da70
L_8e1018:
	ld.as r4,[gp,0xab]
L_8e101c:
	mov_s r1,r13
L_8e101e:
	mov_s r2,0x0
L_8e1020:
	mov_s r3,r2
L_8e1022:
	mov_s r5,r2
L_8e1024:
	bl.d L_8dc92c
L_8e1028:
	mov_s r6,r2
L_8e102a:
	b.d L_8c033c
L_8e102e:
	st_s r0,[r13,0x2c]
	.global L_8e1030
L_8e1030:
	mov_s r0,blink
L_8e1032:
	mov_s r2,0x1003140
L_8e1038:
	mov_s r1,0x1426
L_8e103e:
	bl.d L_8c82c0
L_8e1042:
	mov_s r3,0x82
L_8e1044:
	b_s L_8e1012
L_8e1046:
	nop_s
