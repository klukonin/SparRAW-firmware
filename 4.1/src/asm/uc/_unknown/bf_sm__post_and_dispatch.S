/* bf_sm__post_and_dispatch @ 0x922964, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bf_sm__post_slot_result
 */
	.section .text.bf_sm__post_and_dispatch,"ax",@progbits
	.global bf_sm__post_and_dispatch
bf_sm__post_and_dispatch:
L_922964:
	mov_s r0,r13
	.global sub_922966
sub_922966:
L_922966:
	bl.d L_9233b0
L_92296a:
	mov_s r0,r14
L_92296c:
	/* b_s 0x00922922 */
	.byte 0xdb,0xf1
L_92296e:
	nop_s
