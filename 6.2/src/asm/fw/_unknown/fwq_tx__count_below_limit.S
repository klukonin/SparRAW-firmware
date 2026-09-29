/* fwq_tx__count_below_limit @ 0x8e3c48, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__count_below_limit
fwq_tx__count_below_limit:
	.global L_8e3c48
L_8e3c48:
	mov_s r0,0x805fe4
L_8e3c4e:
	ld_s r1,[r0,0x28]
L_8e3c50:
	ld_s r0,[r0,0x2c]
L_8e3c52:
	cmp_s r1,r0
L_8e3c54:
	mov_s r0,0x1
L_8e3c56:
	sub.cs r0,r0,r0
L_8e3c5a:
	cmp_s r0,0x0
L_8e3c5c:
	mov_s r0,0x1
L_8e3c5e:
	j_s.d [blink]
L_8e3c60:
	sub_s.ne r0,r0,r0
L_8e3c62:
	nop_s
