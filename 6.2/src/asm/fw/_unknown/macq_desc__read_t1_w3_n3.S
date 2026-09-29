/* macq_desc__read_t1_w3_n3 @ 0x8e4424, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__wait_drain
 * Зовёт сам: macq_desc__read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__read_t1_w3_n3
macq_desc__read_t1_w3_n3:
	.global L_8e4424
L_8e4424:
	mov_s r2,0x1
L_8e4426:
	mov_s r3,0x3
L_8e4428:
	b.d L_8c50f8
L_8e442c:
	mov_s r4,r3
L_8e442e:
	nop_s
