/* evt_queue__noop_lock_hook @ 0x926a38, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: evt_queue__take_locked
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global evt_queue__noop_lock_hook
evt_queue__noop_lock_hook:
	.global L_926a38
L_926a38:
	j_s [blink]
L_926a3a:
	nop_s
