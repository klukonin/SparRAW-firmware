/* ba_setup_sm__close_ba_setup_global_timeout @ 0x8ea4b0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::close_ba_setup_global_timeout() delete global flow TO.
 *   ba_setup_sm.cpp
 * Зовут его: ba__retry_flow, ba_setup_sm__addba_resp, ba_setup_sm__close_all_timers
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_sysassert_fatal, u_schd__cancel
 */
	.section .text.ba_setup_sm__close_ba_setup_global_timeout,"ax",@progbits
	.global ba_setup_sm__close_ba_setup_global_timeout
ba_setup_sm__close_ba_setup_global_timeout:
	.global L_8ea4b0
L_8ea4b0:
	push_s blink
L_8ea4b2:
	push_s r13
L_8ea4b4:
	mov_s r13,r0
L_8ea4b6:
	mov_s r2,0x1010280
L_8ea4bc:
	mov_s r0,0x7
L_8ea4be:
	bl.d L_8edfb0
L_8ea4c2:
	mov_s r1,0x2
L_8ea4c4:
	ld_s r0,[r13,0x38]
L_8ea4c6:
	breq_s r0,0,L_8ea4d6
	.global L_8ea4c8
L_8ea4c8:
	bl.d L_8c7794
L_8ea4cc:
	ld_s r0,[r13,0x38]
L_8ea4ce:
	mov_s r0,0x0
L_8ea4d0:
	b.d L_8c033c
L_8ea4d4:
	st_s r0,[r13,0x38]
	.global L_8ea4d6
L_8ea4d6:
	mov_s r0,blink
L_8ea4d8:
	mov_s r2,0x10102c4
L_8ea4de:
	mov_s r1,0x12c6
L_8ea4e4:
	bl.d L_8c82c0
L_8ea4e8:
	mov r3,0x168
L_8ea4ec:
	b_s L_8ea4c8
L_8ea4ee:
	nop_s
