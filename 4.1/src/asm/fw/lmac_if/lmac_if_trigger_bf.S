/* lmac_if_trigger_bf @ 0x8d8cb0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_trigger_bf: cid=%d, bf_cmd_type = %d
 * Зовут его: lm_main_sm__linkup_failed, lm_main_sm__on_linkup_req__lm_state_configured, lm_main_sm__on_linkup_req__lm_state_idle, maintain__trigger_bf, maintain_sm__on_bf_results
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_trigger_bf,"ax",@progbits
	.global lmac_if_trigger_bf
lmac_if_trigger_bf:
	.global L_8d8cb0
L_8d8cb0:
	push_s blink
L_8d8cb2:
	bl L_8c02c4
L_8d8cb6:
	mov_s r13,r0
L_8d8cb8:
	bl.d L_8c2b0c
L_8d8cbc:
	mov_s r14,r1
L_8d8cbe:
	mov_s r1,0x1
L_8d8cc0:
	st_s r1,[r0]
L_8d8cc2:
	mov_s r1,0x80345c
L_8d8cc8:
	ld_s r1,[r1,0xc]
L_8d8cca:
	breq_s r1,0,L_8d8cd0
L_8d8ccc:
	st_s r14,[r0,0x4]
L_8d8cce:
	b_s L_8d8cd4
	.global L_8d8cd0
L_8d8cd0:
	mov_s r1,0x0
L_8d8cd2:
	st_s r1,[r0,0x4]
	.global L_8d8cd4
L_8d8cd4:
	st_s r13,[r0,0x8]
L_8d8cd6:
	mov_s r1,0x9
L_8d8cd8:
	mov_s r2,0xc
L_8d8cda:
	bl.d L_8e0694
L_8d8cde:
	mov_s r3,0x0
L_8d8ce0:
	mov_s r2,0x1004c60
L_8d8ce6:
	mov_s r0,0x0
L_8d8ce8:
	mov_s r1,0x2
L_8d8cea:
	mov_s r3,r13
L_8d8cec:
	bl.d L_8edff8
L_8d8cf0:
	mov_s r4,r14
L_8d8cf2:
	b L_8c0334
L_8d8cf6:
	nop_s
