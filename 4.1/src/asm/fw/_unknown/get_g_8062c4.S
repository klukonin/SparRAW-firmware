/* get_g_8062c4 @ 0x8df0f4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion
 */
	.section .text.get_g_8062c4,"ax",@progbits
	.global get_g_8062c4
get_g_8062c4:
	.global L_8df0f4
L_8df0f4:
	mov_s r0,0x8062c4
L_8df0fa:
	ld_s r1,[r0,0x28]
L_8df0fc:
	ld_s r0,[r0,0x2c]
L_8df0fe:
	cmp_s r1,r0
L_8df100:
	mov_s r0,0x1
L_8df102:
	sub.cs r0,r0,r0
L_8df106:
	cmp_s r0,0x0
L_8df108:
	mov_s r0,0x1
L_8df10a:
	j_s.d [blink]
L_8df10c:
	sub_s.ne r0,r0,r0
L_8df10e:
	nop_s
