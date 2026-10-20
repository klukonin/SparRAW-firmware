/* maintain_sm__on_bf_results @ 0x8e9f6c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, basic_sm__store_pending_event, lm__get_cid, lmac_if_trigger_bf, maintain_sm__release_radio_after_bf_evt
 * Глобалы (через gp): 0x80023a
 */
	.section .text.maintain_sm__on_bf_results,"ax",@progbits
	.global maintain_sm__on_bf_results
maintain_sm__on_bf_results:
L_8e9f6c:
	push_s blink
L_8e9f6e:
	push_s r13
L_8e9f70:
	mov_s r13,r0
L_8e9f72:
	ld_s r0,[r1,0xc]
L_8e9f74:
	brne r0,0x1,L_8e9f8e
L_8e9f78:
	bl.d L_8de158
L_8e9f7c:
	mov_s r0,r13
L_8e9f7e:
	mov_s r0,r13
L_8e9f80:
	mov_s r1,0x6
	.global L_8e9f82
L_8e9f82:
	mov_s r2,0x0
L_8e9f84:
	mov_s r3,r2
L_8e9f86:
	bl.d L_8e20c0
L_8e9f8a:
	mov_s r4,r2
L_8e9f8c:
	b_s L_8e9fc0
	.global L_8e9f8e
L_8e9f8e:
	ld_s r0,[r13,0x30]
L_8e9f90:
	breq r0,0x1,L_8e9fc0
L_8e9f94:
	add r0,r13,0x20
L_8e9f98:
	ldb_s r1,[r0,0x1c]
L_8e9f9a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8e9f9c:
	extb_s r1,r1
L_8e9f9e:
	stb_s r1,[r0,0x1c]
L_8e9fa0:
	ldb_s r0,[gp,0xca]
L_8e9fa2:
	brne r1,r0,L_8e9fb2
L_8e9fa6:
	bl.d L_8de158
L_8e9faa:
	mov_s r0,r13
L_8e9fac:
	mov_s r0,r13
L_8e9fae:
	mov_s r1,0x5
L_8e9fb0:
	b_s L_8e9f82
	.global L_8e9fb2
L_8e9fb2:
	bl.d L_8c9d74
L_8e9fb6:
	ld_s r0,[r13,0x2c]
L_8e9fb8:
	extb_s r0,r0
L_8e9fba:
	bl.d L_8d8cb0
L_8e9fbe:
	mov_s r1,0x0
	.global L_8e9fc0
L_8e9fc0:
	b L_8c033c
