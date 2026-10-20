/* vring__stop_hw @ 0x8e0eec, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, obj__has_pending_1c_10, sm_pring__timeout, vring__reg_write_locked_28, vring_schd__stop_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__stop_hw
vring__stop_hw:
	.global L_8e0eec
L_8e0eec:
	push_s blink
L_8e0eee:
	bl.d L_8c01e0
L_8e0ef2:
	mul64 r0,0x3c
L_8e0ef6:
	mov_s r14,0x804dbc
L_8e0efc:
	add r13,r14,0x28
L_8e0f00:
	ldw.a r1,[r13,mlo]
L_8e0f04:
	mov_s r0,0x0
L_8e0f06:
	bset r0,r0,r1
L_8e0f0a:
	bl.d L_8d0538
L_8e0f0e:
	mov_s r1,0x0
L_8e0f10:
	ld_s r15,[r13,0x14]
L_8e0f12:
	breq_s r15,0,L_8e0f2e
	.global L_8e0f14
L_8e0f14:
	bl.d L_8c3800
L_8e0f18:
	mov_s r0,r14
L_8e0f1a:
	brne r0,0x1,L_8e0f2a
L_8e0f1e:
	mov_s r0,0x4
L_8e0f20:
	st_s r0,[r15,0x24]
L_8e0f22:
	mov_s r0,r14
L_8e0f24:
	bl.d L_8e80cc
L_8e0f28:
	mov_s r1,r13
	.global L_8e0f2a
L_8e0f2a:
	b L_8c024c
	.global L_8e0f2e
L_8e0f2e:
	mov_s r0,blink
L_8e0f30:
	mov_s r1,0x12bd
L_8e0f36:
	bl L_8c9b28
L_8e0f3a:
	b_s L_8e0f14
L_8e0f3c:
	mul64 r0,0x3c
L_8e0f40:
	add r0,mlo,0x804de4
L_8e0f48:
	b L_8e9268
