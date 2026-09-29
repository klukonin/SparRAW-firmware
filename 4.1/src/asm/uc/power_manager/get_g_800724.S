/* get_g_800724 @ 0x92b1ac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_task__run
 */
	.section .text.get_g_800724,"ax",@progbits
	.global get_g_800724
get_g_800724:
	.global L_92b1ac
L_92b1ac:
	mov_s r2,0x800724
L_92b1b2:
	ld_s r1,[r2,0xc]
L_92b1b4:
	mul64 r1,0x3e8
L_92b1b8:
	ld_s r2,[r2,0x8]
L_92b1ba:
	mov_s r1,mlo
L_92b1bc:
	mul64_s r2,r0
L_92b1be:
	mov_s r0,0x1
L_92b1c0:
	cmp_s r1,mlo
L_92b1c2:
	j_s.d [blink]
L_92b1c4:
	sub.ls r0,r0,r0
