/* ppdu__unpack_desc_word @ 0x9297ac, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta_slot
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ppdu__unpack_desc_word
ppdu__unpack_desc_word:
	.global L_9297ac
L_9297ac:
	bmsk r10,r0,0x4
L_9297b0:
	st r10,[r1]
L_9297b4:
	lsr r9,r0,0x5
L_9297b8:
	bmsk r9,r9,0x11
L_9297bc:
	st r9,[r2]
L_9297c0:
	lsr r7,r0,0x17
L_9297c4:
	bmsk r7,r7,0x4
L_9297c8:
	st r7,[r3]
L_9297cc:
	lsr r3,r0,0x1c
L_9297d0:
	bmsk_s r3,r3,0x0
L_9297d2:
	st r3,[r4]
L_9297d6:
	lsr r2,r0,0x1d
L_9297da:
	bmsk_s r2,r2,0x0
L_9297dc:
	st r2,[r5]
L_9297e0:
	lsr r8,r0,0x1e
L_9297e4:
	bmsk r8,r8,0x0
L_9297e8:
	j.d [blink]
L_9297ec:
	st r8,[r6]
