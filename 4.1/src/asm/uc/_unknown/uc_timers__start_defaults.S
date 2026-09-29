/* uc_timers__start_defaults @ 0x936d88, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__switch_sequence, uc_main_init
 * Зовёт сам: uc_timer__start
 */
	.section .text.uc_timers__start_defaults,"ax",@progbits
	.global uc_timers__start_defaults
uc_timers__start_defaults:
	.global L_936d88
L_936d88:
	push_s blink
L_936d8a:
	mov_s r0,0x1
L_936d8c:
	mov_s r1,0x0
L_936d8e:
	mov_s r2,0x1f78a40
L_936d94:
	bl.d L_9323e0
L_936d98:
	mov_s r3,0x2
L_936d9a:
	mov_s r0,0x0
L_936d9c:
	mov_s r1,0x0
L_936d9e:
	mov r2,0x672
L_936da2:
	bl.d L_9323e0
L_936da6:
	mov_s r3,0x1
L_936da8:
	pop_s blink
L_936daa:
	j_s [blink]
