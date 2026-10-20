/* power_mngr__stats_mark_base @ 0x92e704, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_handle_watchdog, power_manager__tick_if_elapsed
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global power_mngr__stats_mark_base
power_mngr__stats_mark_base:
	.global L_92e704
L_92e704:
	mov_s r1,0x8022c8
L_92e70a:
	ld_s r2,[r1,0x40]
L_92e70c:
	mov_s r1,0x8007b8
L_92e712:
	st_s r2,[r1,0x4]
L_92e714:
	j_s.d [blink]
L_92e716:
	st_s r0,[r1]
