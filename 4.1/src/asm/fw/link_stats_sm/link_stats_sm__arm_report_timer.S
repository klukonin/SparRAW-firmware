/* link_stats_sm__arm_report_timer @ 0x8dfc54, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   link_stats_sm.cpp
 * Зовут его: link_stats__report, link_stats_sm__started
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, u_schd__schedule
 */
	.section .text.link_stats_sm__arm_report_timer,"ax",@progbits
	.global link_stats_sm__arm_report_timer
link_stats_sm__arm_report_timer:
	.global L_8dfc54
L_8dfc54:
	push_s blink
L_8dfc56:
	push_s r13
L_8dfc58:
	mov_s r13,r0
L_8dfc5a:
	ld_s r0,[r0,0x30]
L_8dfc5c:
	brne_s r0,0,L_8dfc80
	.global L_8dfc5e
L_8dfc5e:
	mov_s r0,0x16adc
L_8dfc64:
	mov_s r1,r13
L_8dfc66:
	mov_s r2,0x0
L_8dfc68:
	mov_s r3,r2
L_8dfc6a:
	mov r4,0x186a0
L_8dfc72:
	mov_s r5,r2
L_8dfc74:
	bl.d L_8dc92c
L_8dfc78:
	mov_s r6,r2
L_8dfc7a:
	b.d L_8c033c
L_8dfc7e:
	st_s r0,[r13,0x30]
	.global L_8dfc80
L_8dfc80:
	mov_s r0,blink
L_8dfc82:
	mov_s r2,0x1011b18
L_8dfc88:
	mov_s r1,0x1258
L_8dfc8e:
	bl.d L_8c82c0
L_8dfc92:
	mov r3,0x1c3
L_8dfc96:
	b_s L_8dfc5e
