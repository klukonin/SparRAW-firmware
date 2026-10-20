/* mem_pool__alloc_cell @ 0x8c34b8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__alloc_locked
 * Зовёт сам: mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__alloc_cell
mem_pool__alloc_cell:
	.global L_8c34b8
L_8c34b8:
	push_s blink
L_8c34ba:
	ld_s r1,[r0,0x14]
L_8c34bc:
	brne r1,0x1,L_8c34c8
L_8c34c0:
	bl.d L_8c354c
L_8c34c4:
	ld_s r0,[r0,0x10]
L_8c34c6:
	b_s L_8c34cc
	.global L_8c34c8
L_8c34c8:
	ld_s r0,[r0]
L_8c34ca:
	ld_s r0,[r0,0x4]
	.global L_8c34cc
L_8c34cc:
	pop_s blink
L_8c34ce:
	j_s [blink]
