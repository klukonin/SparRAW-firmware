/* mem_pool__link_free_list @ 0x8c487c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__init
 */
	.section .text.mem_pool__link_free_list,"ax",@progbits
	.global mem_pool__link_free_list
mem_pool__link_free_list:
	.global L_8c487c
L_8c487c:
	cmp_s r2,0x0
L_8c487e:
	mov.hi lp_count,r2
L_8c4882:
	lphi L_8c4890
L_8c4886:
	ld_s r2,[r0]
L_8c4888:
	st_s r2,[r1]
L_8c488a:
	ld_s r2,[r0,0x8]
L_8c488c:
	st_s r1,[r0]
L_8c488e:
	add_s r1,r1,r2
	.global L_8c4890
L_8c4890:
	j_s [blink]
L_8c4892:
	nop_s
