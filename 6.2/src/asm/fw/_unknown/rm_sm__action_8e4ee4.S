/* rm_sm__action_8e4ee4 @ 0x8e4ee4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, rm__load_request_params, rm_main_sm__kick_channel_switch_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_sm__action_8e4ee4
rm_sm__action_8e4ee4:
	.global L_8e4ee4
L_8e4ee4:
	push_s blink
L_8e4ee6:
	bl L_8c01e4
L_8e4eea:
	mov_s r13,r0
L_8e4eec:
	ld r0,[r0, 0x80]
L_8e4ef0:
	mov_s r14,r1
L_8e4ef2:
	brne r1,r0,L_8e4f08
	.global L_8e4ef6
L_8e4ef6:
	mov_s r0,r13
L_8e4ef8:
	bl.d L_8eaccc
L_8e4efc:
	mov_s r1,r14
L_8e4efe:
	bl.d L_8da6e4
L_8e4f02:
	mov_s r0,r13
L_8e4f04:
	b L_8c0254
	.global L_8e4f08
L_8e4f08:
	mov_s r0,blink
L_8e4f0a:
	mov_s r1,0x1177
L_8e4f10:
	bl L_8c9b28
L_8e4f14:
	b_s L_8e4ef6
L_8e4f16:
	nop_s
