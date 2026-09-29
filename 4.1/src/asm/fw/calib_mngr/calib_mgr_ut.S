/* calib_mgr_ut @ 0x8e5abc, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_mgr_ut handler (subtype = %d)
 *   calib_mngr.cpp
 * Зовут его: wmi_ut_handler_dispatch
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, __ld_r13_ret, calib_mngr__engine_start, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.calib_mgr_ut,"ax",@progbits
	.global calib_mgr_ut
calib_mgr_ut:
	.global L_8e5abc
L_8e5abc:
	push_s blink
L_8e5abe:
	push_s r13
L_8e5ac0:
	mov_s r13,r0
L_8e5ac2:
	mov_s r2,0x100871c
L_8e5ac8:
	mov_s r0,0x6
L_8e5aca:
	mov_s r1,0x2
L_8e5acc:
	bl.d L_8edfcc
L_8e5ad0:
	ldw_s r3,[r13,0x2]
L_8e5ad2:
	ldw_s r0,[r13,0x2]
L_8e5ad4:
	breq_s r0,0,L_8e5af0
L_8e5ad6:
	breq r0,0x1,L_8e5b02
L_8e5ada:
	mov_s r0,blink
L_8e5adc:
	mov_s r2,0x10085d4
L_8e5ae2:
	mov_s r1,0x8f
L_8e5ae4:
	bset_s r1,r1,0xc
L_8e5ae6:
	bl.d L_8c82c0
L_8e5aea:
	mov r3,0x202
L_8e5aee:
	b_s L_8e5b1e
	.global L_8e5af0
L_8e5af0:
	ld_s r1,[r13,0x8]
L_8e5af2:
	ld_s r0,[r13,0x4]
L_8e5af4:
	sub_s r2,r1,0x1
L_8e5af6:
	cmp_s r0,0x1
L_8e5af8:
	bl.d L_8e3614
L_8e5afc:
	mov.eq r1,r2
L_8e5b00:
	b_s L_8e5b1e
	.global L_8e5b02
L_8e5b02:
	mov r5,0x0
L_8e5b06:
	ldw r4,[r13, 0x14]
L_8e5b0a:
	mov r6,r5
L_8e5b0e:
	ld_s r0,[r13,0x4]
L_8e5b10:
	ld_s r1,[r13,0x8]
L_8e5b12:
	ld_s r2,[r13,0xc]
L_8e5b14:
	ld_s r3,[r13,0x10]
L_8e5b16:
	bl.d L_8c87e0
L_8e5b1a:
	mov r7,r5
	.global L_8e5b1e
L_8e5b1e:
	b L_8c033c
L_8e5b22:
	nop_s
