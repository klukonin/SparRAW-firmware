/* uc_ring__init_desc @ 0x928098, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_mailbox__init_rings
 */
	.section .text.uc_ring__init_desc,"ax",@progbits
	.global uc_ring__init_desc
uc_ring__init_desc:
	.global L_928098
L_928098:
	st_s r1,[r0]
L_92809a:
	st_s r1,[r0,0x4]
L_92809c:
	add_s r1,r1,r2
L_92809e:
	st_s r1,[r0,0x8]
L_9280a0:
	st_s r3,[r0,0xc]
L_9280a2:
	st r4,[r0, 0x10]
L_9280a6:
	mov_s r2,0x0
L_9280a8:
	st_s r2,[r0,0x18]
L_9280aa:
	st_s r2,[r0,0x1c]
L_9280ac:
	j.d [blink]
L_9280b0:
	st r6,[r0, 0x14]
