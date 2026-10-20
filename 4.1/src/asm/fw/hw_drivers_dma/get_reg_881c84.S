/* get_reg_881c84 @ 0x8cd9e0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring, stats_timer_exp
 */
	.section .text.get_reg_881c84,"ax",@progbits
	.global get_reg_881c84
get_reg_881c84:
	.global L_8cd9e0
L_8cd9e0:
	mov_s r0,0x881c80
L_8cd9e6:
	ld_s r0,[r0,0x4]
L_8cd9e8:
	j_s [blink]
L_8cd9ea:
	nop_s
