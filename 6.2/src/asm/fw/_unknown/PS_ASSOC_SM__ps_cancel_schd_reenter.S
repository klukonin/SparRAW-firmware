/* PS_ASSOC_SM__ps_cancel_schd_reenter @ 0x8e12e4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_ASSOC_SM::ps_cancel_schd_reenter PS_DISABLE handle: 0x%x
 * Зовут его: PS_ASSOC_SM__ps_schd_reenter_extend
 * Зовёт сам: fw_log_emit1, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global PS_ASSOC_SM__ps_cancel_schd_reenter
PS_ASSOC_SM__ps_cancel_schd_reenter:
	.global L_8e12e4
L_8e12e4:
	push_s blink
L_8e12e6:
	mov_s r1,0x10023f0
L_8e12ec:
	mov_s r0,0x2e
L_8e12ee:
	bl.d L_8dcc10
L_8e12f2:
	ld.as r2,[gp,-0x17]
L_8e12f6:
	ld_s r0,[gp,-0x5c]
L_8e12f8:
	breq_s r0,0,L_8e1304
L_8e12fa:
	bl L_8c8de0
L_8e12fe:
	mov_s r0,0x0
L_8e1300:
	st.as r0,[gp,-0x17]
	.global L_8e1304
L_8e1304:
	pop_s blink
L_8e1306:
	j_s [blink]
