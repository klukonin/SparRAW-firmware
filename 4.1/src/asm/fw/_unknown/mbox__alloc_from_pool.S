/* mbox__alloc_from_pool @ 0x8c2d34, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_if__alloc_mbox_slot
 * Зовёт сам: mem_pool__allocate
 */
	.section .text.mbox__alloc_from_pool,"ax",@progbits
	.global mbox__alloc_from_pool
mbox__alloc_from_pool:
	.global L_8c2d34
L_8c2d34:
	push_s blink
L_8c2d36:
	ld_s r1,[r0,0x14]
L_8c2d38:
	brne r1,0x1,L_8c2d44
L_8c2d3c:
	bl.d L_8c2dc8
L_8c2d40:
	ld_s r0,[r0,0x10]
L_8c2d42:
	b_s L_8c2d48
	.global L_8c2d44
L_8c2d44:
	ld_s r0,[r0]
L_8c2d46:
	ld_s r0,[r0,0x4]
	.global L_8c2d48
L_8c2d48:
	pop_s blink
L_8c2d4a:
	j_s [blink]
