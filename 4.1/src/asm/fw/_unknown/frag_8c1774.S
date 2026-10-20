/* frag_8c1774 @ 0x8c1774, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_mem_84ee20
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, obj__set_vtable_80058c
 */
	.section .text.frag_8c1774,"ax",@progbits
	.global frag_8c1774
frag_8c1774:
L_8c1774:
	mov_s r3,r4
	.global sub_8c1776
sub_8c1776:
L_8c1776:
	nop_s
	.global L_8c1778
L_8c1778:
	push_s blink
L_8c177a:
	bl L_8c02c4
L_8c177e:
	mov_s r13,r0
L_8c1780:
	add_s r0,r0,0x8
L_8c1782:
	mov_s r14,0x0
L_8c1784:
	bl.d L_8c1798
L_8c1788:
	mov_s r1,r14
L_8c178a:
	st_s r14,[r13,0x20]
L_8c178c:
	mov_s r0,0x1
L_8c178e:
	add r13,r13,0x424
L_8c1792:
	b.d L_8c0334
L_8c1796:
	st_s r0,[r13]
