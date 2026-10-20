/* bf_unaligned32 @ 0x8e88b8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_u32_s4_w24
 * Зовёт сам: bf_insert
 */
	.section .text.bf_unaligned32,"ax",@progbits
	.global bf_unaligned32
bf_unaligned32:
	.global L_8e88b8
L_8e88b8:
	push_s r12
L_8e88ba:
	push_s r2
L_8e88bc:
	push_s blink
L_8e88be:
	ldb r2,[r0, 0x3]
L_8e88c2:
	ldb r12,[r0, 0x2]
L_8e88c6:
	asl r2,r2,0x18
L_8e88ca:
	asl r12,r12,0x10
L_8e88ce:
	or blink,r12,r2
L_8e88d2:
	ldb r2,[r0, 0x1]
L_8e88d6:
	ldb r12,[r0]
L_8e88da:
	asl r2,r2,0x8
L_8e88de:
	or r12,r12,r2
L_8e88e2:
	or r12,r12,blink
L_8e88e6:
	bl L_8e8868
L_8e88ea:
	stb r12,[r0]
L_8e88ee:
	lsr r12,r12,0x8
L_8e88f2:
	stb r12,[r0, 0x1]
L_8e88f6:
	lsr r12,r12,0x8
L_8e88fa:
	stb r12,[r0, 0x2]
L_8e88fe:
	lsr r12,r12,0x8
L_8e8902:
	stb r12,[r0, 0x3]
L_8e8906:
	pop_s blink
L_8e8908:
	pop_s r2
L_8e890a:
	j_s.d [blink]
L_8e890c:
	pop_s r12
L_8e890e:
	nop_s
