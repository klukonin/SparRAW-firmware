/* mbox_ring__advance @ 0x8da460, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_evt__build_and_post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mbox_ring__advance
mbox_ring__advance:
	.global L_8da460
L_8da460:
	ld_s r1,[r0]
L_8da462:
	ld_s r2,[r0,0x8]
L_8da464:
	add_s r1,r1,0x8
L_8da466:
	brne r1,r2,L_8da46c
L_8da46a:
	ld_s r1,[r0,0x4]
	.global L_8da46c
L_8da46c:
	ld_s r0,[r0,0xc]
L_8da46e:
	ld_s r0,[r0,0x8]
L_8da470:
	rsub.f r0,r0,r1
L_8da474:
	j_s.d [blink]
L_8da476:
	mov.ne r0,0x1
L_8da47a:
	nop_s
