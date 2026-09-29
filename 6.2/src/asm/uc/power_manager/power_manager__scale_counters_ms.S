/* power_manager__scale_counters_ms @ 0x92e6c0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_handle_watchdog
 * Зовёт сам: __ld_r13_to_r13_ret, uc_divmod_unsigned
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global power_manager__scale_counters_ms
power_manager__scale_counters_ms:
	.global L_92e6c0
L_92e6c0:
	push_s blink
L_92e6c2:
	push_s r13
L_92e6c4:
	mov_s r13,0x8007b8
L_92e6ca:
	ld_s r0,[r13,0x8]
L_92e6cc:
	bl.d L_9203e0
L_92e6d0:
	mov r1,0x3e8
L_92e6d4:
	mov.f r1,r0
L_92e6d8:
	beq_s L_92e6e2
L_92e6da:
	bl.d L_9203e0
L_92e6de:
	ld_s r0,[r13,0xc]
L_92e6e0:
	b_s L_92e6e4
	.global L_92e6e2
L_92e6e2:
	mov_s r0,0x0
	.global L_92e6e4
L_92e6e4:
	b L_9202ac
