/* sm_801d64__action_8e1744 @ 0x8e1744, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: psc_if__start_psc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_801d64__action_8e1744
sm_801d64__action_8e1744:
	.global L_8e1744
L_8e1744:
	mov_s r3,0x801f64
L_8e174a:
	ld_s r0,[r0,0x8]
L_8e174c:
	mov_s r1,0x0
L_8e174e:
	ld r2,[r3, -0xfc]
L_8e1752:
	b.d L_8d9cc8
L_8e1756:
	ld r3,[r3, -0xf8]
L_8e175a:
	nop_s
