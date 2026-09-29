/* uc_get_half_0x10 @ 0x926164, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_window_timing_update
 */
	.section .text.uc_get_half_0x10,"ax",@progbits
	.global uc_get_half_0x10
uc_get_half_0x10:
	.global L_926164
L_926164:
	j.d [blink]
L_926168:
	ldw_s r0,[r0,0x10]
L_92616a:
	nop_s
