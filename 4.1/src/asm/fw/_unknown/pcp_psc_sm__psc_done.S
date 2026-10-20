/* pcp_psc_sm__psc_done @ 0x8dd788, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::psc_done. dpm: %d, success: %d
 * Зовёт сам: PS_CONNECTION__psc_complete, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, pcp_psc_sm__m_psc_resp_tx_wb_timeout_event_8c5c4c
 */
	.section .text.pcp_psc_sm__psc_done,"ax",@progbits
	.global pcp_psc_sm__psc_done
pcp_psc_sm__psc_done:
L_8dd788:
	push_s blink
L_8dd78a:
	bl L_8c02c4
L_8dd78e:
	mov_s r13,r0
L_8dd790:
	mov_s r14,r1
L_8dd792:
	ldb r3,[r13, 0x40]
L_8dd796:
	mov_s r2,0x10031dc
L_8dd79c:
	mov_s r0,0xe
L_8dd79e:
	mov_s r1,0x2
L_8dd7a0:
	bl.d L_8edff8
L_8dd7a4:
	mov_s r4,r14
L_8dd7a6:
	bl.d L_8c5c4c
L_8dd7aa:
	mov_s r0,r13
L_8dd7ac:
	ldb r0,[r13, 0x40]
L_8dd7b0:
	add r3,r13,0x38
L_8dd7b4:
	sub.f r2,r0,0x0
L_8dd7b8:
	ld_s r0,[r13,0x34]
L_8dd7ba:
	mov.ne r2,0x1
L_8dd7be:
	bl.d L_8dd554
L_8dd7c2:
	mov_s r1,r14
L_8dd7c4:
	b L_8c0334
