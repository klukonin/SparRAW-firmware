/* mbox_ring__advance @ 0x8d739c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_if__mailbox_send
 */
	.section .text.mbox_ring__advance,"ax",@progbits
	.global mbox_ring__advance
mbox_ring__advance:
	.global L_8d739c
L_8d739c:
	ld_s r1,[r0]
L_8d739e:
	ld_s r2,[r0,0x8]
L_8d73a0:
	add_s r1,r1,0x8
L_8d73a2:
	brne r1,r2,L_8d73a8
L_8d73a6:
	ld_s r1,[r0,0x4]
	.global L_8d73a8
L_8d73a8:
	ld_s r0,[r0,0xc]
L_8d73aa:
	ld_s r0,[r0,0x8]
L_8d73ac:
	rsub.f r0,r0,r1
L_8d73b0:
	j_s.d [blink]
L_8d73b2:
	mov.ne r0,0x1
L_8d73b6:
	nop_s
