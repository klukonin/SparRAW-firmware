/* mid__reset_sched_alloc_regs @ 0x8d0e48, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__init_sched_scheme
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__reset_sched_alloc_regs
mid__reset_sched_alloc_regs:
	.global L_8d0e48
L_8d0e48:
	mov_s r1,0x0
L_8d0e4a:
	mov_s r0,0x88c000
L_8d0e50:
	st_s r1,[r0,0x48]
L_8d0e52:
	st 0x80001f00,[r0, 0x4c]
L_8d0e5a:
	j_s [blink]
