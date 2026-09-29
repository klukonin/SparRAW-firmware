/* tail_vring__write_macq_desc_8df8a4 @ 0x8df8a4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__wait_drain
 * Зовёт сам: vring__write_macq_desc
 */
	.section .text.tail_vring__write_macq_desc_8df8a4,"ax",@progbits
	.global tail_vring__write_macq_desc_8df8a4
tail_vring__write_macq_desc_8df8a4:
	.global L_8df8a4
L_8df8a4:
	mov_s r2,0x1
L_8df8a6:
	mov_s r3,0x2
L_8df8a8:
	b.d L_8c4768
L_8df8ac:
	mov_s r4,r2
L_8df8ae:
	nop_s
