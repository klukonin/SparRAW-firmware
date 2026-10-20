/* ps_cfg__apply_profile_1 @ 0x8e6da4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile
 * Зовёт сам: __ld_r13_to_r13_ret, memcpy_fw, memset0_words, power_mgr_ut__dispatch, ps_cfg__noop_apply_hook
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__apply_profile_1
ps_cfg__apply_profile_1:
	.global L_8e6da4
L_8e6da4:
	push_s blink
L_8e6da6:
	push_s r13
L_8e6da8:
	mov_s r0,0x17
L_8e6daa:
	mov_s r1,0x0
L_8e6dac:
	mov_s r2,r1
L_8e6dae:
	bl.d L_8e8774
L_8e6db2:
	mov_s r3,r1
L_8e6db4:
	mov_s r13,0x803d5c
L_8e6dba:
	ld_s r0,[r13,0x24]
L_8e6dbc:
	breq r0,0x1,L_8e6de8
L_8e6dc0:
	add r0,r13,0x34
L_8e6dc4:
	bl.d L_8c1cd8
L_8e6dc8:
	mov_s r1,0x10
L_8e6dca:
	add2 r0,r13,0x11
L_8e6dce:
	bl.d L_8c1cd8
L_8e6dd2:
	mov_s r1,0x10
L_8e6dd4:
	add r0,r13,0x28
L_8e6dd8:
	mov_s r1,0x800a83
L_8e6dde:
	bl.d L_8c0380
L_8e6de2:
	mov_s r2,0xa
L_8e6de4:
	mov_s r0,0x1
L_8e6de6:
	st_s r0,[r13,0x24]
	.global L_8e6de8
L_8e6de8:
	mov_s r0,0x1
L_8e6dea:
	st_s r0,[r13,0x4]
L_8e6dec:
	add r0,r13,0x8
L_8e6df0:
	mov_s r1,0x800a8d
L_8e6df6:
	bl.d L_8c0380
L_8e6dfa:
	mov_s r2,0x19
L_8e6dfc:
	bl.d L_8e74d4
L_8e6e00:
	mov_s r0,0x0
L_8e6e02:
	b L_8c025c
L_8e6e06:
	nop_s
