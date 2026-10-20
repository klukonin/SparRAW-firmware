/* brp__program_mac_sequence_uc @ 0x9259d0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__program_mac_sequence_uc
brp__program_mac_sequence_uc:
	.global L_9259d0
L_9259d0:
	push_s blink
L_9259d2:
	mov_s r0,0x3d020000
L_9259d8:
	mov_s r32,r0
L_9259da:
	st.ab r0,[r25,0x4]
L_9259de:
	bclr r25,r25,0xa
L_9259e2:
	mov_s r0,0x5
L_9259e4:
	asl_s r0,r0,0x18
L_9259e6:
	mov_s r32,r0
L_9259e8:
	st.ab r0,[r25,0x4]
L_9259ec:
	bclr r25,r25,0xa
L_9259f0:
	mov_s r0,0x20
L_9259f2:
	bset_s r0,r0,0x1a
L_9259f4:
	mov_s r32,r0
L_9259f6:
	st.ab r0,[r25,0x4]
L_9259fa:
	bclr r25,r25,0xa
L_9259fe:
	mov_s r0,0x58
L_925a00:
	asl_s r0,r0,0x18
L_925a02:
	mov_s r32,r0
L_925a04:
	st.ab r0,[r25,0x4]
L_925a08:
	bclr r25,r25,0xa
L_925a0c:
	pop_s blink
L_925a0e:
	j_s [blink]
