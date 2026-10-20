/* power_mgr_ut @ 0x8eae14, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   power_mgr_ut handler (subtype = %d)
 * Зовут его: wmi_ut_handler
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_sysassert_fatal, power_mgr_ut__dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mgr_ut
power_mgr_ut:
	.global L_8eae14
L_8eae14:
	push_s blink
L_8eae16:
	push_s r13
L_8eae18:
	mov_s r13,r0
L_8eae1a:
	mov_s r1,0x10020a8
L_8eae20:
	mov_s r0,0x20
L_8eae22:
	bl.d L_8dcc10
L_8eae26:
	ldw_s r2,[r13,0x2]
L_8eae28:
	ldw_s r0,[r13,0x2]
L_8eae2a:
	breq_s r0,0,L_8eae42
L_8eae2c:
	breq r0,0x1,L_8eae4a
L_8eae30:
	breq r0,0x2,L_8eae4e
L_8eae34:
	mov_s r0,blink
L_8eae36:
	mov_s r1,0x2101
L_8eae3c:
	bl L_8c9b28
L_8eae40:
	b_s L_8eae5a
	.global L_8eae42
L_8eae42:
	ld_s r0,[r13,0x4]
L_8eae44:
	ld_s r1,[r13,0x8]
L_8eae46:
	ld_s r2,[r13,0xc]
L_8eae48:
	b_s L_8eae54
	.global L_8eae4a
L_8eae4a:
	mov_s r0,0x11
L_8eae4c:
	b_s L_8eae50
	.global L_8eae4e
L_8eae4e:
	mov_s r0,0x12
	.global L_8eae50
L_8eae50:
	mov_s r1,0x1
L_8eae52:
	mov_s r2,0x0
	.global L_8eae54
L_8eae54:
	bl.d L_8e8774
L_8eae58:
	mov_s r3,0x0
	.global L_8eae5a
L_8eae5a:
	b L_8c025c
L_8eae5e:
	nop_s
