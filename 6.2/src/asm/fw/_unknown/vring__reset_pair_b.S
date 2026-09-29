/* vring__reset_pair_b @ 0x8c9830, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__set_pair_mode
 * Зовёт сам: vring__reg_write_locked_3c, vring_hw__unmask_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reset_pair_b
vring__reset_pair_b:
	.global L_8c9830
L_8c9830:
	push_s blink
L_8c9832:
	mov r0,-0x1
L_8c9836:
	bl.d L_8d05f0
L_8c983a:
	mov_s r1,0x1
L_8c983c:
	mov r0,-0x1
L_8c9840:
	bl.d L_8d0568
L_8c9844:
	mov_s r1,0x1
L_8c9846:
	pop_s blink
L_8c9848:
	j_s [blink]
L_8c984a:
	nop_s
