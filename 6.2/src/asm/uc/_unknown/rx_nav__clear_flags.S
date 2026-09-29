/* rx_nav__clear_flags @ 0x92dc1c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1__enter_fixed_sched
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_nav__clear_flags
rx_nav__clear_flags:
	.global L_92dc1c
L_92dc1c:
	mov_s r1,0x0
L_92dc1e:
	mov_s r0,0x80146c
L_92dc24:
	j_s.d [blink]
L_92dc26:
	st_s r1,[r0]
