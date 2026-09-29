/* lmac_if_send_cmd_0x0f @ 0x8dbd74, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_disc_sm__disassoc_sent_cb, maintain_sm__action_8f96c4, tof_mgr, tof_mgr__aoa_session_start
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x0f
lmac_if_send_cmd_0x0f:
	.global L_8dbd74
L_8dbd74:
	push_s blink
L_8dbd76:
	bl L_8c01e4
L_8dbd7a:
	mov_s r14,r0
L_8dbd7c:
	bl.d L_8c3284
L_8dbd80:
	mov_s r13,r1
L_8dbd82:
	st_s r14,[r0]
L_8dbd84:
	stw_s r13,[r0,0x4]
L_8dbd86:
	mov_s r1,0xf
L_8dbd88:
	mov_s r2,0x8
L_8dbd8a:
	bl.d L_8e5204
L_8dbd8e:
	mov_s r3,0x0
L_8dbd90:
	b L_8c0254
