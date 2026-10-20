/* uc_vector_01 @ 0x9208f8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc__init_globals
 * Зовёт сам: boot_uc__init_g800610, boot_uc__init_more, memset0_words_uc, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_vector_01
uc_vector_01:
	.global L_9208f8
L_9208f8:
	mov_s r0,blink
L_9208fa:
	b.d L_926618
L_9208fe:
	mov_s r1,0x22
L_920900:
	push_s blink
L_920902:
	ld.as r3,[gp,-0x37]
L_920906:
	breq_s r3,0,L_920930
L_920908:
	mov_s r0,0x801be8
L_92090e:
	mov_s r1,0x803234
L_920914:
	bl.d L_920a84
L_920918:
	sub r1,r1,r0
L_92091c:
	/* mov_s r0,0x0 */
	.byte 0xcf,0x70,0x00,0x00,0x00,0x00
L_920922:
	/* mov_s r1,0x0 */
	.byte 0xcf,0x71,0x00,0x00,0x00,0x00
L_920928:
	bl.d L_920a84
L_92092c:
	sub r1,r1,r0
	.global L_920930
L_920930:
	mov r2,0x0
L_920934:
	stb r2,[gp, -0x100]
L_920938:
	/* jl 0x114 */
	.byte 0x22,0x20,0x80,0x0f,0x00,0x00,0x14,0x01
L_920940:
	bl L_920a10
L_920944:
	pop_s blink
L_920946:
	j_s [blink]
	.global L_920948
L_920948:
	b L_92aedc
