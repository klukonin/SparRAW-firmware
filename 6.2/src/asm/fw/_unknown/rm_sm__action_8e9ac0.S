/* rm_sm__action_8e9ac0 @ 0x8e9ac0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: rm__invalidate_tune_slot, switch_2_secondary
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_sm__action_8e9ac0
rm_sm__action_8e9ac0:
	.global L_8e9ac0
L_8e9ac0:
	push_s blink
L_8e9ac2:
	bl.d L_8ea8b0
L_8e9ac6:
	mov_s r2,r0
L_8e9ac8:
	bl.d L_8e83d4
L_8e9acc:
	mov_s r0,r2
L_8e9ace:
	pop_s blink
L_8e9ad0:
	j_s [blink]
L_8e9ad2:
	nop_s
