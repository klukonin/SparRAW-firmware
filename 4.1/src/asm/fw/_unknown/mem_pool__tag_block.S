/* mem_pool__tag_block @ 0x8e2344, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__create
 */
	.section .text.mem_pool__tag_block,"ax",@progbits
	.global mem_pool__tag_block
mem_pool__tag_block:
	.global L_8e2344
L_8e2344:
	breq_s r0,0,L_8e236a
L_8e2346:
	add_s r1,r1,r0
L_8e2348:
	brne r0,0x4,L_8e235a
L_8e234c:
	stw 0xabcd,[r1, -0x2]
L_8e2354:
	stw r2,[r1, -0x4]
L_8e2358:
	b_s L_8e236a
	.global L_8e235a
L_8e235a:
	stw 0xabce,[r1, -0x2]
L_8e2362:
	stw r0,[r1, -0x4]
L_8e2366:
	st r2,[r1, -0x8]
	.global L_8e236a
L_8e236a:
	j_s.d [blink]
L_8e236c:
	mov_s r0,r1
L_8e236e:
	nop_s
