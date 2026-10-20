/* mem_pool__tag_block @ 0x8e7474, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: cxx__vec_new
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__tag_block
mem_pool__tag_block:
	.global L_8e7474
L_8e7474:
	breq_s r0,0,L_8e749a
L_8e7476:
	add_s r1,r1,r0
L_8e7478:
	brne r0,0x4,L_8e748a
L_8e747c:
	stw 0xabcd,[r1, -0x2]
L_8e7484:
	stw r2,[r1, -0x4]
L_8e7488:
	b_s L_8e749a
	.global L_8e748a
L_8e748a:
	stw 0xabce,[r1, -0x2]
L_8e7492:
	stw r0,[r1, -0x4]
L_8e7496:
	st r2,[r1, -0x8]
	.global L_8e749a
L_8e749a:
	j_s.d [blink]
L_8e749c:
	mov_s r0,r1
L_8e749e:
	nop_s
