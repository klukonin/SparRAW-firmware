/* link_stats_sm__arm_latency_timer @ 0x8dfa40, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_stats_sm.cpp
 * Зовут его: link_stats_sm__on_latency_timer, link_stats_sm__started
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x8003a0
 */
	.section .text.link_stats_sm__arm_latency_timer,"ax",@progbits
	.global link_stats_sm__arm_latency_timer
link_stats_sm__arm_latency_timer:
	.global L_8dfa40
L_8dfa40:
	push_s blink
L_8dfa42:
	push_s r13
L_8dfa44:
	mov_s r13,r0
L_8dfa46:
	ld_s r0,[r0,0x2c]
L_8dfa48:
	brne_s r0,0,L_8dfa68
	.global L_8dfa4a
L_8dfa4a:
	mov_s r0,0x16abc
L_8dfa50:
	ld.as r4,[gp,0x8c]
L_8dfa54:
	mov_s r1,r13
L_8dfa56:
	mov_s r2,0x0
L_8dfa58:
	mov_s r3,r2
L_8dfa5a:
	mov_s r5,r2
L_8dfa5c:
	bl.d L_8dc92c
L_8dfa60:
	mov_s r6,r2
L_8dfa62:
	b.d L_8c033c
L_8dfa66:
	st_s r0,[r13,0x2c]
	.global L_8dfa68
L_8dfa68:
	mov_s r0,blink
L_8dfa6a:
	mov_s r2,0x1011b18
L_8dfa70:
	mov_s r1,0x1257
L_8dfa76:
	bl.d L_8c82c0
L_8dfa7a:
	mov r3,0x1bb
L_8dfa7e:
	b_s L_8dfa4a
