/* sysassert__wmi_lock_notice @ 0x8c9c58, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   To enable WMI commands change g_sysassert_wmi_lock to FALSE
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, cpu__aux28_clear_bits12, debug_mbox__get_or_init, fw_log_emit0, lmac_if__evt_fields, mbox__drain_debug, mbox__drain_operational, tx_api__ctx_8041f0
 * Глобалы (через gp): 0x800249, 0x80024a, 0x800298, 0x800330, 0x800404
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sysassert__wmi_lock_notice
sysassert__wmi_lock_notice:
	.global L_8c9c58
L_8c9c58:
	push_s blink
L_8c9c5a:
	bl.d L_8c01e4
L_8c9c5e:
	mov_s r0,0x20
L_8c9c60:
	mov_s r1,0x10014bc
L_8c9c66:
	bl L_8dcba8
L_8c9c6a:
	bl L_8c034c
	.global L_8c9c6e
L_8c9c6e:
	ldb_s r0,[gp,0xc5]
L_8c9c70:
	brne_s r0,0,L_8c9c6e
L_8c9c72:
	mov_s r13,0x0
L_8c9c74:
	ld.as r1,[gp,0xa0]
L_8c9c78:
	mov_s r0,0x1
L_8c9c7a:
	st.as r13,[gp,-0x5a]
L_8c9c7e:
	stb r0,[gp, 0xc5]
L_8c9c82:
	brne_s r1,0,L_8c9c88
L_8c9c84:
	ld_s r0,[gp,0x1ac]
L_8c9c86:
	breq_s r0,0,L_8c9cb4
	.global L_8c9c88
L_8c9c88:
	breq_s r1,0,L_8c9c90
L_8c9c8a:
	bl L_8d9f7c
L_8c9c8e:
	b_s L_8c9c94
	.global L_8c9c90
L_8c9c90:
	bl L_8d9f9c
	.global L_8c9c94
L_8c9c94:
	add r14,r0,0x24
L_8c9c98:
	ld_s r0,[r14]
L_8c9c9a:
	st_s r13,[r0]
L_8c9c9c:
	bl.d L_8d86c0
L_8c9ca0:
	mov_s r0,r14
L_8c9ca2:
	ld_s r1,[r14,0xc]
L_8c9ca4:
	ld_s r0,[r14]
L_8c9ca6:
	st_s r0,[r1,0x8]
L_8c9ca8:
	b_s L_8c9cb4
	.global L_8c9caa
L_8c9caa:
	mov_s r0,0x880b00
L_8c9cb0:
	ld_s r13,[r0,0x50]
L_8c9cb2:
	brne_s r13,0,L_8c9cbc
	.global L_8c9cb4
L_8c9cb4:
	ldb_s r0,[gp,0xc6]
L_8c9cb6:
	brne_s r0,0,L_8c9caa
L_8c9cb8:
	b L_8c0254
	.global L_8c9cbc
L_8c9cbc:
	st_s r13,[r0,0x50]
L_8c9cbe:
	ldw_s r0,[gp,0x114]
L_8c9cc0:
	btst_s r13,0x12
L_8c9cc2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c9cc4:
	stw.as r0,[gp,0x8a]
L_8c9cc8:
	sub_s.ne r0,r0,r0
L_8c9cca:
	bl.ne.d L_8e378c
L_8c9cce:
	mov.ne r1,r0
L_8c9cd2:
	btst_s r13,0x13
L_8c9cd4:
	sub_s.ne r0,r0,r0
L_8c9cd6:
	bl.ne.d L_8e37c8
L_8c9cda:
	mov.ne r1,r0
L_8c9cde:
	b_s L_8c9cb4
