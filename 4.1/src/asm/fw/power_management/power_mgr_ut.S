/* power_mgr_ut @ 0x8e5b24, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   power_mgr_ut handler (subtype = %d)
 *   power_management.cpp
 * Зовут его: wmi_ut_handler_dispatch
 * Зовёт сам: POWER_MNGR__system_state_evt_handler, __ld_r13_ret, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.power_mgr_ut,"ax",@progbits
	.global power_mgr_ut
power_mgr_ut:
	.global L_8e5b24
L_8e5b24:
	push_s blink
L_8e5b26:
	push_s r13
L_8e5b28:
	mov_s r13,r0
L_8e5b2a:
	mov_s r2,0x10022c0
L_8e5b30:
	mov_s r0,0x0
L_8e5b32:
	mov_s r1,0x2
L_8e5b34:
	bl.d L_8edfcc
L_8e5b38:
	ldw_s r3,[r13,0x2]
L_8e5b3a:
	ldw_s r0,[r13,0x2]
L_8e5b3c:
	breq_s r0,0,L_8e5b5e
L_8e5b3e:
	breq r0,0x1,L_8e5b66
L_8e5b42:
	breq r0,0x2,L_8e5b6a
L_8e5b46:
	mov_s r0,blink
L_8e5b48:
	mov_s r2,0x10021f4
L_8e5b4e:
	mov_s r1,0x2101
L_8e5b54:
	bl.d L_8c82c0
L_8e5b58:
	mov r3,0x283
L_8e5b5c:
	b_s L_8e5b76
	.global L_8e5b5e
L_8e5b5e:
	ld_s r0,[r13,0x4]
L_8e5b60:
	ld_s r1,[r13,0x8]
L_8e5b62:
	ld_s r2,[r13,0xc]
L_8e5b64:
	b_s L_8e5b70
	.global L_8e5b66
L_8e5b66:
	mov_s r0,0x11
L_8e5b68:
	b_s L_8e5b6c
	.global L_8e5b6a
L_8e5b6a:
	mov_s r0,0x12
	.global L_8e5b6c
L_8e5b6c:
	mov_s r1,0x1
L_8e5b6e:
	mov_s r2,0x0
	.global L_8e5b70
L_8e5b70:
	bl.d L_8e3714
L_8e5b74:
	mov_s r3,0x0
	.global L_8e5b76
L_8e5b76:
	b L_8c033c
L_8e5b7a:
	nop_s
