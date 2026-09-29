/* link_stats_sm__started @ 0x8e24f8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_stats_sm --> started
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_read_timer, get_p8003b4_48, get_p8003b4_50, led_scheme__apply, link_stats_sm__arm_latency_timer, link_stats_sm__arm_report_timer, memset0_words, tail_get_g_8003b0, tail_get_g_8003b4
 */
	.section .text.link_stats_sm__started,"ax",@progbits
	.global link_stats_sm__started
link_stats_sm__started:
L_8e24f8:
	push_s blink
L_8e24fa:
	bl L_8c02c4
L_8e24fe:
	bl.d L_8e4694
L_8e2502:
	mov_s r13,r0
L_8e2504:
	st_s r0,[r13,0x5c]
L_8e2506:
	bl.d L_8cacbc
L_8e250a:
	mov_s r0,r13
L_8e250c:
	st_s r0,[r13,0x38]
L_8e250e:
	st_s r1,[r13,0x3c]
L_8e2510:
	bl.d L_8ca824
L_8e2514:
	mov_s r0,r13
L_8e2516:
	st_s r0,[r13,0x44]
L_8e2518:
	bl.d L_8d9ac8
L_8e251c:
	st_s r1,[r13,0x48]
L_8e251e:
	bl.d L_8d9ad0
L_8e2522:
	st_s r0,[r13,0x50]
L_8e2524:
	st_s r0,[r13,0x54]
L_8e2526:
	mov_s r0,0x854d80
L_8e252c:
	ld_s r0,[r0,0x4]
L_8e252e:
	mov_s r2,0x1011d50
L_8e2534:
	st_s r0,[r13,0x58]
L_8e2536:
	mov_s r14,0x0
L_8e2538:
	mov_s r0,r14
L_8e253a:
	bl.d L_8edfb0
L_8e253e:
	mov_s r1,0x2
L_8e2540:
	st_s r14,[r13,0x28]
L_8e2542:
	bl.d L_8dfa40
L_8e2546:
	mov_s r0,r13
L_8e2548:
	bl.d L_8dfc54
L_8e254c:
	mov_s r0,r13
L_8e254e:
	bl.d L_8d775c
L_8e2552:
	mov_s r0,0x1
L_8e2554:
	mov_s r0,0x805c84
L_8e255a:
	bl.d L_8c1a78
L_8e255e:
	mov_s r1,0x84
L_8e2560:
	add_s r0,gp,-0x70
L_8e2562:
	bl.d L_8c1a78
L_8e2566:
	mov_s r1,0x4
L_8e2568:
	b.d L_8c0334
L_8e256c:
	stb r14,[r13, 0x60]
