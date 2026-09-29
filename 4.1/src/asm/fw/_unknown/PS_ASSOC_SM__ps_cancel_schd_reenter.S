/* PS_ASSOC_SM__ps_cancel_schd_reenter @ 0x8dd178, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_ASSOC_SM::ps_cancel_schd_reenter PS_DISABLE handle: 0x%x
 * Зовут его: PS_ASSOC_SM__ps_schd_reenter_extend
 * Зовёт сам: fw_log__emit1, u_schd__cancel
 */
	.section .text.PS_ASSOC_SM__ps_cancel_schd_reenter,"ax",@progbits
	.global PS_ASSOC_SM__ps_cancel_schd_reenter
PS_ASSOC_SM__ps_cancel_schd_reenter:
	.global L_8dd178
L_8dd178:
	push_s blink
L_8dd17a:
	mov_s r2,0x10026fc
L_8dd180:
	mov_s r0,0xe
L_8dd182:
	mov_s r1,0x2
L_8dd184:
	bl.d L_8edfcc
L_8dd188:
	ld.as r3,[gp,-0x14]
L_8dd18c:
	ld_s r0,[gp,-0x50]
L_8dd18e:
	breq_s r0,0,L_8dd19a
L_8dd190:
	bl L_8c7794
L_8dd194:
	mov_s r0,0x0
L_8dd196:
	st.as r0,[gp,-0x14]
	.global L_8dd19a
L_8dd19a:
	pop_s blink
L_8dd19c:
	j_s [blink]
L_8dd19e:
	nop_s
