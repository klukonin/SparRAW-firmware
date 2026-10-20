/* bf_insert @ 0x8e8868, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_byte_set, bf_half_set, bf_unaligned16, bf_unaligned32, bf_word_set
 */
	.section .text.bf_insert,"ax",@progbits
	.global bf_insert
bf_insert:
	.global L_8e8868
L_8e8868:
	push_s r0
L_8e886a:
	push_s r1
L_8e886c:
	mov r0,-0x1
L_8e8870:
	bmsk r0,r0,r11
L_8e8874:
	and_s r1,r1,r0
L_8e8876:
	asl r0,r0,r10
L_8e887a:
	asl r1,r1,r10
L_8e887e:
	bic r12,r12,r0
L_8e8882:
	or_s r12,r12,r1
L_8e8884:
	pop_s r1
L_8e8886:
	j_s.d [blink]
L_8e8888:
	pop_s r0
L_8e888a:
	nop_s
