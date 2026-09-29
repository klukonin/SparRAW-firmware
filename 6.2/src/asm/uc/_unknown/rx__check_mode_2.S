/* rx__check_mode_2 @ 0x936e04, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow, tx_sta__run_txop
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, phy_stats__accumulate_to_shared, phy_stats__clear_counters_883960, rx_capture__match_filter
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__check_mode_2
rx__check_mode_2:
	.global L_936e04
L_936e04:
	push_s blink
L_936e06:
	bl L_920234
L_936e0a:
	mov_s r13,r0
L_936e0c:
	ld_s r0,[r0,0xc]
L_936e0e:
	mov_s r14,r1
L_936e10:
	brne r0,0x2,L_936e3c
L_936e14:
	ld_s r0,[r13]
L_936e16:
	breq_s r0,0,L_936e3c
L_936e18:
	brhs r0,0x7,L_936e3c
L_936e1c:
	bl.d L_93e56c
L_936e20:
	mov_s r0,r13
L_936e22:
	ld_s r1,[r13]
L_936e24:
	brne_s r0,0,L_936e2e
L_936e26:
	cmp_s r1,0x4
L_936e28:
	bl.eq L_929cec
L_936e2c:
	b_s L_936e3c
	.global L_936e2e
L_936e2e:
	cmp_s r1,0x4
L_936e30:
	mov.eq r0,r13
L_936e34:
	bl.eq.d L_92e544
L_936e38:
	mov.eq r1,r14
	.global L_936e3c
L_936e3c:
	b L_9202a4
