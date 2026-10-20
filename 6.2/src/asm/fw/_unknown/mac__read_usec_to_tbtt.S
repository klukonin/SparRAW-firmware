/* mac__read_usec_to_tbtt @ 0x8e98e4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brd_if_multi_array__get_block_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__read_usec_to_tbtt
mac__read_usec_to_tbtt:
	.global L_8e98e4
L_8e98e4:
	breq_s r0,0,L_8e98f2
	.global L_8e98e6
L_8e98e6:
	mov_s r0,0x886e80
L_8e98ec:
	ld_s r0,[r0,0x34]
L_8e98ee:
	bbit0 r0,0x1f,L_8e98e6
	.global L_8e98f2
L_8e98f2:
	mov_s r0,0x886e80
L_8e98f8:
	ld_s r0,[r0,0x40]
L_8e98fa:
	j_s.d [blink]
L_8e98fc:
	bmsk_s r0,r0,0x19
L_8e98fe:
	nop_s
