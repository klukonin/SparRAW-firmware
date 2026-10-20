/* rm__invalidate_tune_slot @ 0x8ea8b0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_sm__action_8e9ac0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm__invalidate_tune_slot
rm__invalidate_tune_slot:
	.global L_8ea8b0
L_8ea8b0:
	st 0xffff,[r0, 0x2c]
L_8ea8b8:
	mov_s r1,0x0
L_8ea8ba:
	j_s.d [blink]
L_8ea8bc:
	st_s r1,[r0,0x30]
L_8ea8be:
	nop_s
