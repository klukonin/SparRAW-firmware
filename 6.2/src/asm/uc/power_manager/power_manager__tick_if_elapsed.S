/* power_manager__tick_if_elapsed @ 0x92e718, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: __ld_r13_to_r13_ret, power_mngr__stats_calc_delta, power_mngr__stats_mark_base, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global power_manager__tick_if_elapsed
power_manager__tick_if_elapsed:
	.global L_92e718
L_92e718:
	push_s blink
L_92e71a:
	bl.d L_9364c8
L_92e71e:
	push_s r13
L_92e720:
	mov_s r13,r0
L_92e722:
	mov_s r0,0x8007b8
L_92e728:
	ld_s r1,[r0]
L_92e72a:
	sub r0,r13,r1
L_92e72e:
	brlo r0,0x17ed0,L_92e742
L_92e736:
	bl.d L_92e6e8
L_92e73a:
	mov_s r0,r13
L_92e73c:
	bl.d L_92e704
L_92e740:
	mov_s r0,r13
	.global L_92e742
L_92e742:
	b L_9202ac
L_92e746:
	nop_s
