/* internal_tx__check_idle @ 0x92bd30, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__start_window, bf__enter_mode3, bf_sm__txss_init_result, keep_alive__arm_slot, ps__hold_awake_for_sta, ucode_cmd_2d__set_bit
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, internal_tx__set_pending_flag
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__check_idle
internal_tx__check_idle:
	.global L_92bd30
L_92bd30:
	push_s blink
L_92bd32:
	bl L_920234
L_92bd36:
	mov_s r14,r0
L_92bd38:
	lr r3,[0xa]
L_92bd3c:
	bclr r0,r3,0x1
L_92bd40:
	flag r0
L_92bd44:
	mov_s r13,0x8006cc
L_92bd4a:
	ld_s r0,[r13]
L_92bd4c:
	brne_s r0,0,L_92bd56
L_92bd4e:
	ld_s r0,[r13,0x4]
L_92bd50:
	cmp_s r0,0x0
L_92bd52:
	bl.eq L_92bbd8
	.global L_92bd56
L_92bd56:
	ld_s r0,[r13]
L_92bd58:
	bic r3,r3,-0x3
L_92bd5c:
	bset r0,r0,r14
L_92bd60:
	st_s r0,[r13]
L_92bd62:
	lr r0,[0xa]
L_92bd66:
	or_s r3,r3,r0
L_92bd68:
	flag r3
L_92bd6c:
	b L_9202a4
