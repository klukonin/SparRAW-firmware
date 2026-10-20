/* maintain_sm__fbf_failed @ 0x8f2dc8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm::fbf_failed() - unlocking radio 0x%x
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit1, maintain_sm__reset_rate_params, radio_mgr__call_method_10, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__fbf_failed
maintain_sm__fbf_failed:
	.global L_8f2dc8
L_8f2dc8:
	push_s blink
L_8f2dca:
	bl L_8c01e4
L_8f2dce:
	mov_s r13,r0
L_8f2dd0:
	ld_s r0,[r0,0x1c]
L_8f2dd2:
	mov_s r14,0x0
L_8f2dd4:
	breq_s r0,0,L_8f2ddc
L_8f2dd6:
	bl L_8c8de0
L_8f2dda:
	st_s r14,[r13,0x1c]
	.global L_8f2ddc
L_8f2ddc:
	bl.d L_8f234c
L_8f2de0:
	mov_s r0,r13
L_8f2de2:
	ld_s r2,[r13,0x24]
L_8f2de4:
	breq_s r2,0,L_8f2dfa
L_8f2de6:
	mov_s r1,0x10146b4
L_8f2dec:
	bl.d L_8dcc10
L_8f2df0:
	mov_s r0,0x2c
L_8f2df2:
	bl.d L_8ea800
L_8f2df6:
	ld_s r0,[r13,0x24]
L_8f2df8:
	st_s r14,[r13,0x24]
	.global L_8f2dfa
L_8f2dfa:
	ld_s r0,[r13,0x8]
L_8f2dfc:
	mov_s r1,0x6
L_8f2dfe:
	mov_s r2,0x0
L_8f2e00:
	mov_s r3,r2
L_8f2e02:
	bl.d L_8d9b6c
L_8f2e06:
	mov_s r4,r2
L_8f2e08:
	b L_8c0254
