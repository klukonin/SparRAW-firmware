/* low_sme__termination_check @ 0x8e9110, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   low_sme::termination_check(termination_evt=%d)
 *   low_sme::termination_check[termination_evt=%d]=0
 * Зовут его: l2_mgr__pcp_stop, mac_bringup__set_886a80_ctl_bit0, mlme_sm__disconnect_ev_handle, pcie__l1_latency_wa
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global low_sme__termination_check
low_sme__termination_check:
	.global L_8e9110
L_8e9110:
	push_s blink
L_8e9112:
	push_s r13
L_8e9114:
	mov_s r13,r0
L_8e9116:
	mov_s r1,0x100b3e4
L_8e911c:
	mov_s r0,0x20
L_8e911e:
	bl.d L_8dcc10
L_8e9122:
	mov_s r2,r13
L_8e9124:
	mov_s r1,0x0
L_8e9126:
	ld_s r0,[gp,-0xc]
L_8e9128:
	bset r1,r1,r13
L_8e912c:
	tst_s r0,r1
L_8e912e:
	beq_s L_8e915a
L_8e9130:
	bic_s r0,r0,r1
L_8e9132:
	st.as r0,[gp,-0x3]
L_8e9136:
	mov_s r1,0x100b414
L_8e913c:
	mov_s r0,0x20
L_8e913e:
	bl.d L_8dcc10
L_8e9142:
	mov_s r2,r13
L_8e9144:
	ld_s r0,[gp,-0xc]
L_8e9146:
	brne_s r0,0,L_8e915a
L_8e9148:
	mov_s r0,0x804c34
L_8e914e:
	mov_s r1,0x2
L_8e9150:
	mov_s r2,0x0
L_8e9152:
	mov_s r3,r2
L_8e9154:
	bl.d L_8d9b6c
L_8e9158:
	mov_s r4,r2
	.global L_8e915a
L_8e915a:
	b L_8c025c
L_8e915e:
	nop_s
