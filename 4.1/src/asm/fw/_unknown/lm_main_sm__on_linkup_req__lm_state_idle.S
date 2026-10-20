/* lm_main_sm__on_linkup_req__lm_state_idle @ 0x8d7d78, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__store_pending_event, lm_if__get_cid, lm_main_sm__config_lmac_bf_sm, lmac_if_send_cmd_0x0c, lmac_if_trigger_bf, maintain_sm__set_rs_params_at34
 */
	.section .text.lm_main_sm__on_linkup_req__lm_state_idle,"ax",@progbits
	.global lm_main_sm__on_linkup_req__lm_state_idle
lm_main_sm__on_linkup_req__lm_state_idle:
L_8d7d78:
	push_s blink
L_8d7d7a:
	bl L_8c02c0
L_8d7d7e:
	mov_s r13,r0
L_8d7d80:
	mov_s r15,r1
L_8d7d82:
	mov_s r14,0x0
L_8d7d84:
	add3 r12,r0,0x20
L_8d7d88:
	stb_s r14,[r12]
L_8d7d8a:
	mov_s r1,r14
L_8d7d8c:
	bl.d L_8c5f10
L_8d7d90:
	mov_s r2,r14
L_8d7d92:
	mov_s r0,r13
L_8d7d94:
	bl.d L_8c625c
L_8d7d98:
	ld.as r1,[gp,-0x38]
L_8d7d9c:
	bl.d L_8c9d8c
L_8d7da0:
	ld_s r0,[r13,0x2c]
L_8d7da2:
	extb_s r1,r0
L_8d7da4:
	mov_s r0,r14
L_8d7da6:
	bl.d L_8d83ec
L_8d7daa:
	mov_s r2,0x4
L_8d7dac:
	breq_s r15,0,L_8d7dbe
L_8d7dae:
	mov_s r0,r13
L_8d7db0:
	mov_s r1,0x2
L_8d7db2:
	mov_s r2,r14
L_8d7db4:
	mov_s r3,r14
L_8d7db6:
	bl.d L_8e20c0
L_8d7dba:
	mov_s r4,r14
L_8d7dbc:
	b_s L_8d7dcc
	.global L_8d7dbe
L_8d7dbe:
	bl.d L_8c9d8c
L_8d7dc2:
	ld_s r0,[r13,0x2c]
L_8d7dc4:
	extb_s r0,r0
L_8d7dc6:
	bl.d L_8d8cb0
L_8d7dca:
	mov_s r1,r14
	.global L_8d7dcc
L_8d7dcc:
	b L_8c032c
