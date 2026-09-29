/* mailbox__free_space @ 0x929004, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_if__post_to_fw_mailbox
 */
	.section .text.mailbox__free_space,"ax",@progbits
	.global mailbox__free_space
mailbox__free_space:
	.global L_929004
L_929004:
	ld_s r1,[r0]
L_929006:
	ld_s r3,[r0,0x8]
L_929008:
	add_s r1,r1,0x8
L_92900a:
	brne r1,r3,L_929010
L_92900e:
	ld_s r1,[r0,0x4]
	.global L_929010
L_929010:
	ld_s r2,[r0,0xc]
L_929012:
	ld_s r0,[r2,0x8]
L_929014:
	rsub.f r0,r0,r1
L_929018:
	j.d [blink]
L_92901c:
	mov.ne r0,0x1
