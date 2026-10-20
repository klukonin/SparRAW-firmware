/* ps_cfg__apply_profile @ 0x8e1f8c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CFG_SCHEME__switch_active_ps_profile
 * Зовёт сам: POWER_MNGR__system_state_evt_handler, __ld_r13_ret, memcpy_fw, memset0_words
 */
	.section .text.ps_cfg__apply_profile,"ax",@progbits
	.global ps_cfg__apply_profile
ps_cfg__apply_profile:
	.global L_8e1f8c
L_8e1f8c:
	push_s blink
L_8e1f8e:
	push_s r13
L_8e1f90:
	mov_s r0,0x17
L_8e1f92:
	mov_s r1,0x0
L_8e1f94:
	mov_s r2,r1
L_8e1f96:
	bl.d L_8e3714
L_8e1f9a:
	mov_s r3,r1
L_8e1f9c:
	mov_s r13,0x8035c8
L_8e1fa2:
	ld_s r0,[r13,0x24]
L_8e1fa4:
	breq r0,0x1,L_8e1fd0
L_8e1fa8:
	add r0,r13,0x34
L_8e1fac:
	bl.d L_8c1a78
L_8e1fb0:
	mov_s r1,0x10
L_8e1fb2:
	add2 r0,r13,0x11
L_8e1fb6:
	bl.d L_8c1a78
L_8e1fba:
	mov_s r1,0x10
L_8e1fbc:
	add r0,r13,0x28
L_8e1fc0:
	mov_s r1,0x8009e7
L_8e1fc6:
	bl.d L_8c0460
L_8e1fca:
	mov_s r2,0xa
L_8e1fcc:
	mov_s r0,0x1
L_8e1fce:
	st_s r0,[r13,0x24]
	.global L_8e1fd0
L_8e1fd0:
	mov_s r0,0x1
L_8e1fd2:
	st_s r0,[r13,0x4]
L_8e1fd4:
	add r0,r13,0x8
L_8e1fd8:
	mov_s r1,0x8009f1
L_8e1fde:
	bl.d L_8c0460
L_8e1fe2:
	mov_s r2,0x19
L_8e1fe4:
	b L_8c033c
