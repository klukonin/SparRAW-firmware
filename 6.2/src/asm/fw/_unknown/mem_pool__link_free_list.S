/* mem_pool__link_free_list @ 0x8c53f8, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__link_free_list
mem_pool__link_free_list:
	.global L_8c53f8
L_8c53f8:
	cmp_s r2,0x0
L_8c53fa:
	mov.hi lp_count,r2
L_8c53fe:
	lphi L_8c540c
L_8c5402:
	ld_s r2,[r0]
L_8c5404:
	st_s r2,[r1]
L_8c5406:
	ld_s r2,[r0,0x8]
L_8c5408:
	st_s r1,[r0]
L_8c540a:
	add_s r1,r1,r2
	.global L_8c540c
L_8c540c:
	j_s [blink]
L_8c540e:
	nop_s
