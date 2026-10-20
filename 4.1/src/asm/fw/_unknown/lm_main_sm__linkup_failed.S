/* lm_main_sm__linkup_failed @ 0x8d7c30, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   linkup_failed: m_stop_req %d
 *   lm_main_sm::linkup_failed() m_failed_bf_cnt=%d
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, lm__notify_linkup, lm_if__get_cid, lm_main_sm__inject_conn_evt3, lmac_if_trigger_bf
 * Глобалы (через gp): 0x8003ec
 */
	.section .text.lm_main_sm__linkup_failed,"ax",@progbits
	.global lm_main_sm__linkup_failed
lm_main_sm__linkup_failed:
L_8d7c30:
	j_s [blink]
	.global fwlog_lm_main_sm_linkup_failed_m_failed_bf_cnt
fwlog_lm_main_sm_linkup_failed_m_failed_bf_cnt:
L_8d7c32:
	nop_s
L_8d7c34:
	push_s blink
L_8d7c36:
	bl.d L_8c02c0
L_8d7c3a:
	mov_s r1,0x2
L_8d7c3c:
	mov_s r13,r0
L_8d7c3e:
	mov_s r2,0x1011ac8
L_8d7c44:
	mov_s r14,0x0
L_8d7c46:
	mov_s r0,r14
L_8d7c48:
	bl.d L_8edfcc
L_8d7c4c:
	ld_s r3,[r13,0x30]
L_8d7c4e:
	ld_s r0,[r13,0x30]
L_8d7c50:
	breq_s r0,0,L_8d7c5c
L_8d7c52:
	st_s r14,[r13,0x30]
L_8d7c54:
	bl.d L_8e30c4
L_8d7c58:
	ld_s r0,[r13,0x2c]
L_8d7c5a:
	b_s L_8d7c9c
	.global L_8d7c5c
L_8d7c5c:
	add3 r15,r13,0x20
L_8d7c60:
	ldb_s r3,[r15]
L_8d7c62:
	mov_s r2,0x1011ae8
L_8d7c68:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8d7c6a:
	extb_s r3,r3
L_8d7c6c:
	stb_s r3,[r15]
L_8d7c6e:
	mov_s r0,r14
L_8d7c70:
	bl.d L_8edfcc
L_8d7c74:
	mov_s r1,0x2
L_8d7c76:
	ldb_s r2,[r15]
L_8d7c78:
	ld_s r0,[gp,0x27c]
L_8d7c7a:
	ld_s r1,[r13,0x2c]
L_8d7c7c:
	brne r2,r0,L_8d7c8e
L_8d7c80:
	stb_s r14,[r15]
L_8d7c82:
	mov_s r0,r1
L_8d7c84:
	bl.d L_8d7d0c
L_8d7c88:
	mov_s r1,0x1
L_8d7c8a:
	stb_s r14,[r13]
L_8d7c8c:
	b_s L_8d7c9c
	.global L_8d7c8e
L_8d7c8e:
	bl.d L_8c9d8c
L_8d7c92:
	mov_s r0,r1
L_8d7c94:
	extb_s r0,r0
L_8d7c96:
	bl.d L_8d8cb0
L_8d7c9a:
	mov_s r1,r14
	.global L_8d7c9c
L_8d7c9c:
	b L_8c032c
