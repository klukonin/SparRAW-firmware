/* ps_cfg__apply_profile_0 @ 0x8e6d4c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, g__set_defaults_803d90_803d94__8e64e0, memcpy_fw, power_mgr_ut__dispatch, ps_cfg__noop_apply_hook
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__apply_profile_0
ps_cfg__apply_profile_0:
	.global L_8e6d4c
L_8e6d4c:
	push_s blink
L_8e6d4e:
	bl.d L_8c01e0
L_8e6d52:
	mov_s r2,0x19
L_8e6d54:
	mov_s r14,0x0
L_8e6d56:
	mov_s r13,0x803d5c
L_8e6d5c:
	mov_s r15,0x800a60
L_8e6d62:
	add r0,r13,0x8
L_8e6d66:
	bl.d L_8c0380
L_8e6d6a:
	add r1,r15,0xa
L_8e6d6e:
	st_s r14,[r13,0x4]
L_8e6d70:
	add r0,r13,0x28
L_8e6d74:
	mov_s r1,r15
L_8e6d76:
	bl.d L_8c0380
L_8e6d7a:
	mov_s r2,0xa
L_8e6d7c:
	ld_s r0,[r13,0x24]
L_8e6d7e:
	breq_s r0,0,L_8e6d9e
L_8e6d80:
	brne r0,0x1,L_8e6d9a
L_8e6d84:
	bl L_8e64e0
L_8e6d88:
	mov_s r0,0x18
L_8e6d8a:
	mov_s r1,r14
L_8e6d8c:
	mov_s r2,r14
L_8e6d8e:
	bl.d L_8e8774
L_8e6d92:
	mov_s r3,r14
L_8e6d94:
	bl.d L_8e74d4
L_8e6d98:
	mov_s r0,0x1
	.global L_8e6d9a
L_8e6d9a:
	mov_s r0,0x0
L_8e6d9c:
	st_s r0,[r13,0x24]
	.global L_8e6d9e
L_8e6d9e:
	b L_8c024c
L_8e6da2:
	nop_s
