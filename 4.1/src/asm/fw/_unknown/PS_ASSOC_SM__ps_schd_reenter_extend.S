/* PS_ASSOC_SM__ps_schd_reenter_extend @ 0x8dd3dc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_ASSOC_SM::ps_schd_reenter_extend handle: 0x%x
 * Зовёт сам: PS_ASSOC_SM__ps_cancel_schd_reenter, __ld_r13_ret, fw_log__emit1, u_schd__schedule
 */
	.section .text.PS_ASSOC_SM__ps_schd_reenter_extend,"ax",@progbits
	.global PS_ASSOC_SM__ps_schd_reenter_extend
PS_ASSOC_SM__ps_schd_reenter_extend:
L_8dd3dc:
	j_s [blink]
	.global fwlog_PS_ASSOC_SM_ps_schd_reenter_extend_handl
fwlog_PS_ASSOC_SM_ps_schd_reenter_extend_handl:
L_8dd3de:
	nop_s
L_8dd3e0:
	push_s blink
L_8dd3e2:
	push_s r13
L_8dd3e4:
	mov_s r13,r0
L_8dd3e6:
	ldb_s r0,[r0]
L_8dd3e8:
	brne r0,0x3,L_8dd41e
L_8dd3ec:
	bl.d L_8dd178
L_8dd3f0:
	mov_s r0,r13
L_8dd3f2:
	mov_s r0,0x1d330
L_8dd3f8:
	ld.as r4,[gp,-0x12]
L_8dd3fc:
	mov_s r1,r13
L_8dd3fe:
	mov_s r2,0x0
L_8dd400:
	mov_s r3,0x1
L_8dd402:
	mov_s r5,r2
L_8dd404:
	bl.d L_8dc92c
L_8dd408:
	mov_s r6,r2
L_8dd40a:
	mov_s r3,r0
L_8dd40c:
	st.as r0,[gp,-0x14]
L_8dd410:
	mov_s r2,0x1002738
L_8dd416:
	mov_s r0,0xe
L_8dd418:
	bl.d L_8edfcc
L_8dd41c:
	mov_s r1,0x2
	.global L_8dd41e
L_8dd41e:
	.byte 0x21,0x07
