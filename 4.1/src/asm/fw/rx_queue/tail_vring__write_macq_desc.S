/* tail_vring__write_macq_desc @ 0x8df88c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__wait_drain
 * Зовёт сам: vring__write_macq_desc
 */
	.section .text.tail_vring__write_macq_desc,"ax",@progbits
	.global tail_vring__write_macq_desc
tail_vring__write_macq_desc:
	.global L_8df88c
L_8df88c:
	mov_s r2,0x1
L_8df88e:
	mov_s r3,0x3
L_8df890:
	b.d L_8c4768
L_8df894:
	mov_s r4,r3
L_8df896:
	nop_s
