/* rm_sm__action_8e9ad4 @ 0x8e9ad4, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, rm_sm__action_at_2c, switch_2_secondary
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_sm__action_8e9ad4
rm_sm__action_8e9ad4:
	.global L_8e9ad4
L_8e9ad4:
	push_s blink
L_8e9ad6:
	push_s r13
L_8e9ad8:
	bl.d L_8e6d34
L_8e9adc:
	mov_s r13,r0
L_8e9ade:
	bl.d L_8e83d4
L_8e9ae2:
	mov_s r0,r13
L_8e9ae4:
	b L_8c025c
