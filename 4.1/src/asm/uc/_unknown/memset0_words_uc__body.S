/* memset0_words_uc__body @ 0x9216d0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: memset0_words_uc
 * Зовёт сам: __ld_r13_ret_uc
 */
	.section .text.memset0_words_uc__body,"ax",@progbits
	.global memset0_words_uc__body
memset0_words_uc__body:
	.byte 0xd0
	.byte 0x00
	.global sub_9216d2
sub_9216d2:
	.global L_9216d2
L_9216d2:
	st.ab r3,[r2,0x4]
	.global L_9216d6
L_9216d6:
	st.ab r3,[r2,0x4]
	.global L_9216da
L_9216da:
	st.ab r3,[r2,0x4]
	.global L_9216de
L_9216de:
	st.ab r3,[r2,0x4]
	.global L_9216e2
L_9216e2:
	st.ab r3,[r2,0x4]
	.global L_9216e6
L_9216e6:
	st.ab r3,[r2,0x4]
	.global L_9216ea
L_9216ea:
	cmp_s r1,0x0
L_9216ec:
	st.ab r3,[r2,0x4]
L_9216f0:
	sub.gt r1,r1,0x1
L_9216f4:
	/* bgt_s 0x009216ce */
	.byte 0x2d,0xf6
	.global L_9216f6
L_9216f6:
	b L_92028c
L_9216fa:
	nop_s
