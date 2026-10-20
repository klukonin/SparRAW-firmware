/* ps_cfg__noop_apply_hook @ 0x8e74d4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_cfg__apply_profile_0, ps_cfg__apply_profile_1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__noop_apply_hook
ps_cfg__noop_apply_hook:
	.global L_8e74d4
L_8e74d4:
	j_s [blink]
L_8e74d6:
	nop_s
