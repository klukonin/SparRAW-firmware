/* lm_sm__action_8df614 @ 0x8df614, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lm__notify_linkup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8df614
lm_sm__action_8df614:
	.global L_8df614
L_8df614:
	ld_s r1,[r1,0x2c]
L_8df616:
	ld_s r0,[r0,0x8]
L_8df618:
	cmp_s r1,0x1
L_8df61a:
	mov_s r1,0x0
L_8df61c:
	mov.ne r1,0x1
L_8df620:
	b L_8dae74
