/* rx_nav__arm_flag_if_enabled @ 0x92dc28, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_step_a, bti_worker__bti_transmitter_beacon_sweep_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_nav__arm_flag_if_enabled
rx_nav__arm_flag_if_enabled:
	.global L_92dc28
L_92dc28:
	mov_s r1,0x80146c
L_92dc2e:
	ldw_s r0,[r1,0x16]
L_92dc30:
	breq_s r0,0,L_92dc3c
L_92dc32:
	ld_s r0,[r1]
L_92dc34:
	bbit1 r0,0x1,L_92dc40
L_92dc38:
	mov_s r0,0x2
L_92dc3a:
	b_s L_92dc3e
	.global L_92dc3c
L_92dc3c:
	mov_s r0,0x0
	.global L_92dc3e
L_92dc3e:
	st_s r0,[r1]
	.global L_92dc40
L_92dc40:
	j_s [blink]
L_92dc42:
	nop_s
