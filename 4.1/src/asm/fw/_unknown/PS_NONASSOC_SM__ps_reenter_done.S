/* PS_NONASSOC_SM__ps_reenter_done @ 0x8dd364, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_NONASSOC_SM::ps_reenter_done state = %d
 * Зовёт сам: basic_sm__inject_event, fw_log__emit1
 */
	.section .text.PS_NONASSOC_SM__ps_reenter_done,"ax",@progbits
	.global PS_NONASSOC_SM__ps_reenter_done
PS_NONASSOC_SM__ps_reenter_done:
	.global L_8dd364
L_8dd364:
	j_s [blink]
	.global fwlog_PS_NONASSOC_SM_ps_reenter_done_state_d
fwlog_PS_NONASSOC_SM_ps_reenter_done_state_d:
L_8dd366:
	nop_s
L_8dd368:
	ld.as r1,[gp,-0x15]
L_8dd36c:
	/* breq_s r1,0,0x008dd394 */
	.byte 0x14,0xe9
L_8dd36e:
	mov_s r1,0x0
L_8dd370:
	ldb_s r3,[r0]
L_8dd372:
	st.as r1,[gp,-0x15]
L_8dd376:
	cmp_s r3,0x2
L_8dd378:
	mov.eq r2,r0
L_8dd37c:
	mov.eq r3,r1
L_8dd380:
	beq.d L_8d6a1c
L_8dd384:
	mov.eq r4,r1
L_8dd388:
	mov_s r2,0x10026ac
L_8dd38e:
	b.d L_8edfcc
L_8dd392:
	mov_s r0,0xe
