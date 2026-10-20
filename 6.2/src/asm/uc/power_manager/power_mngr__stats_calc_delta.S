/* power_mngr__stats_calc_delta @ 0x92e6e8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_handle_watchdog, power_manager__tick_if_elapsed
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global power_mngr__stats_calc_delta
power_mngr__stats_calc_delta:
	.global L_92e6e8
L_92e6e8:
	mov_s r2,0x8007b8
L_92e6ee:
	ld_s r1,[r2]
L_92e6f0:
	sub_s r0,r0,r1
L_92e6f2:
	st_s r0,[r2,0x8]
L_92e6f4:
	mov_s r0,0x8022c8
L_92e6fa:
	ld_s r0,[r0,0x40]
L_92e6fc:
	ld_s r1,[r2,0x4]
L_92e6fe:
	sub_s r0,r0,r1
L_92e700:
	j_s.d [blink]
L_92e702:
	st_s r0,[r2,0xc]
