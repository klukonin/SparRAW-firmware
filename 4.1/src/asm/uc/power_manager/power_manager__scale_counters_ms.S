/* power_manager__scale_counters_ms @ 0x92b1c8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_task__run
 * Зовёт сам: __ld_r13_ret_uc, uc_divmod_signed
 */
	.section .text.power_manager__scale_counters_ms,"ax",@progbits
	.global power_manager__scale_counters_ms
power_manager__scale_counters_ms:
	.global L_92b1c8
L_92b1c8:
	push_s blink
L_92b1ca:
	push_s r13
L_92b1cc:
	mov_s r13,0x800724
L_92b1d2:
	ld_s r0,[r13,0x8]
L_92b1d4:
	bl.d L_9203c0
L_92b1d8:
	mov r1,0x3e8
L_92b1dc:
	mov.f r1,r0
L_92b1e0:
	beq_s L_92b1ea
L_92b1e2:
	bl.d L_9203c0
L_92b1e6:
	ld_s r0,[r13,0xc]
L_92b1e8:
	b_s L_92b1ec
	.global L_92b1ea
L_92b1ea:
	mov_s r0,0x0
	.global L_92b1ec
L_92b1ec:
	b L_92028c
