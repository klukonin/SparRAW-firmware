/* macq_desc__read_t1_w2_n1 @ 0x8e443c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__wait_drain
 * Зовёт сам: macq_desc__read
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_desc__read_t1_w2_n1
macq_desc__read_t1_w2_n1:
	.global L_8e443c
L_8e443c:
	mov_s r2,0x1
L_8e443e:
	mov_s r3,0x2
L_8e4440:
	b.d L_8c50f8
L_8e4444:
	mov_s r4,r2
L_8e4446:
	nop_s
