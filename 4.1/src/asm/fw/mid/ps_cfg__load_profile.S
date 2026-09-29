/* ps_cfg__load_profile @ 0x8e1f3c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile
 * Зовёт сам: POWER_MNGR__system_state_evt_handler, __ld_r15_to_r13_ret, __st_r15_to_r13, g_8035c8__set_defaults, memcpy_fw
 */
	.section .text.ps_cfg__load_profile,"ax",@progbits
	.global ps_cfg__load_profile
ps_cfg__load_profile:
	.global L_8e1f3c
L_8e1f3c:
	push_s blink
L_8e1f3e:
	bl.d L_8c02c0
L_8e1f42:
	mov_s r2,0x19
L_8e1f44:
	mov_s r14,0x0
L_8e1f46:
	mov_s r13,0x8035c8
L_8e1f4c:
	mov_s r15,0x8009c4
L_8e1f52:
	add r0,r13,0x8
L_8e1f56:
	bl.d L_8c0460
L_8e1f5a:
	add r1,r15,0xa
L_8e1f5e:
	st_s r14,[r13,0x4]
L_8e1f60:
	add r0,r13,0x28
L_8e1f64:
	mov_s r1,r15
L_8e1f66:
	bl.d L_8c0460
L_8e1f6a:
	mov_s r2,0xa
L_8e1f6c:
	ld_s r0,[r13,0x24]
L_8e1f6e:
	breq_s r0,0,L_8e1f88
L_8e1f70:
	brne r0,0x1,L_8e1f84
L_8e1f74:
	bl L_8e173c
L_8e1f78:
	mov_s r0,0x18
L_8e1f7a:
	mov_s r1,r14
L_8e1f7c:
	mov_s r2,r14
L_8e1f7e:
	bl.d L_8e3714
L_8e1f82:
	mov_s r3,r14
	.global L_8e1f84
L_8e1f84:
	mov_s r0,0x0
L_8e1f86:
	st_s r0,[r13,0x24]
	.global L_8e1f88
L_8e1f88:
	b L_8c032c
