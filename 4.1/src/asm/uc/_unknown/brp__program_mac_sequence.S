/* brp__program_mac_sequence @ 0x9250e0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__program_and_measure
 */
	.section .text.brp__program_mac_sequence,"ax",@progbits
	.global brp__program_mac_sequence
brp__program_mac_sequence:
	.global L_9250e0
L_9250e0:
	push_s blink
L_9250e2:
	mov_s r0,0x3d020000
L_9250e8:
	mov_s r32,r0
L_9250ea:
	st.ab r0,[r25,0x4]
L_9250ee:
	bclr r25,r25,0xa
L_9250f2:
	mov_s r0,0x5
L_9250f4:
	asl_s r0,r0,0x18
L_9250f6:
	mov_s r32,r0
L_9250f8:
	st.ab r0,[r25,0x4]
L_9250fc:
	bclr r25,r25,0xa
L_925100:
	mov_s r0,0x20
L_925102:
	bset_s r0,r0,0x1a
L_925104:
	mov_s r32,r0
L_925106:
	st.ab r0,[r25,0x4]
L_92510a:
	bclr r25,r25,0xa
L_92510e:
	mov_s r0,0x58
L_925110:
	asl_s r0,r0,0x18
L_925112:
	mov_s r32,r0
L_925114:
	st.ab r0,[r25,0x4]
L_925118:
	bclr r25,r25,0xa
L_92511c:
	pop_s blink
L_92511e:
	j_s [blink]
