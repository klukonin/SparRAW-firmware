/* ring__is_full @ 0x8da2d8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_ring__post_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ring__is_full
ring__is_full:
	.global L_8da2d8
L_8da2d8:
	ld_s r1,[r0,0xc]
L_8da2da:
	ld_s r2,[r0,0x4]
L_8da2dc:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8da2de:
	cmp_s r1,r2
L_8da2e0:
	ld_s r0,[r0,0x8]
L_8da2e2:
	mov.eq r1,0x0
L_8da2e6:
	cmp_s r1,r0
L_8da2e8:
	mov_s r0,0x1
L_8da2ea:
	j_s.d [blink]
L_8da2ec:
	sub_s.ne r0,r0,r0
L_8da2ee:
	nop_s
