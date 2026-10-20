/* lm_sm__action_8e7f94 @ 0x8e7f94, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8e7f94
lm_sm__action_8e7f94:
	.global L_8e7f94
L_8e7f94:
	mov_s r1,0x1
L_8e7f96:
	j_s.d [blink]
L_8e7f98:
	st_s r1,[r0,0xc]
L_8e7f9a:
	nop_s
