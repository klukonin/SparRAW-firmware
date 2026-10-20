/* macq_desc__read_t1_w0_n2 @ 0x8e4430, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__program_ba_win, vring__wait_drain
 * Зовёт сам: macq_desc__read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__read_t1_w0_n2
macq_desc__read_t1_w0_n2:
	.global L_8e4430
L_8e4430:
	mov_s r2,0x1
L_8e4432:
	mov_s r3,0x0
L_8e4434:
	b.d L_8c50f8
L_8e4438:
	mov r4,0x2
