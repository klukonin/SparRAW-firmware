/* mailbox__free_space @ 0x92be30, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_evt__queue_put
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mailbox__free_space
mailbox__free_space:
	.global L_92be30
L_92be30:
	ld_s r1,[r0]
L_92be32:
	ld_s r3,[r0,0x8]
L_92be34:
	add_s r1,r1,0x8
L_92be36:
	brne r1,r3,L_92be3c
L_92be3a:
	ld_s r1,[r0,0x4]
	.global L_92be3c
L_92be3c:
	ld_s r2,[r0,0xc]
L_92be3e:
	ld_s r0,[r2,0x8]
L_92be40:
	rsub.f r0,r0,r1
L_92be44:
	j.d [blink]
L_92be48:
	mov.ne r0,0x1
