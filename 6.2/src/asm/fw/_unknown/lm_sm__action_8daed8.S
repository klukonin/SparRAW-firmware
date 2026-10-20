/* lm_sm__action_8daed8 @ 0x8daed8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn__get_cid, lm_main_sm__config_lmac_bf_sm, lmac_if_config_txss, lmac_if_trigger_bf, maintain_sm__set_rs_params_of_conn, sm__defer_call
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8daed8
lm_sm__action_8daed8:
	.global L_8daed8
L_8daed8:
	push_s blink
L_8daeda:
	bl L_8c01e0
L_8daede:
	mov_s r14,r0
L_8daee0:
	mov_s r15,r1
L_8daee2:
	mov_s r13,0x0
L_8daee4:
	stb r13,[r0, 0x94]
L_8daee8:
	mov_s r1,r13
L_8daeea:
	bl.d L_8c6cb4
L_8daeee:
	mov_s r2,r13
L_8daef0:
	mov_s r0,r14
L_8daef2:
	bl.d L_8c6fbc
L_8daef6:
	ld.as r1,[gp,-0x3b]
L_8daefa:
	bl.d L_8cbed0
L_8daefe:
	ld_s r0,[r14,0x8]
L_8daf00:
	bl.d L_8db60c
L_8daf04:
	extb_s r0,r0
L_8daf06:
	breq_s r15,0,L_8daf18
L_8daf08:
	mov_s r0,r14
L_8daf0a:
	mov_s r1,0x2
L_8daf0c:
	mov_s r2,r13
L_8daf0e:
	mov_s r3,r13
L_8daf10:
	bl.d L_8e7044
L_8daf14:
	mov_s r4,r13
L_8daf16:
	b_s L_8daf26
	.global L_8daf18
L_8daf18:
	bl.d L_8cbed0
L_8daf1c:
	ld_s r0,[r14,0x8]
L_8daf1e:
	extb_s r0,r0
L_8daf20:
	bl.d L_8dc228
L_8daf24:
	mov_s r1,r13
	.global L_8daf26
L_8daf26:
	b L_8c024c
L_8daf2a:
	nop_s
