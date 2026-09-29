/* frag_8c0728 @ 0x8c0728, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.frag_8c0728,"ax",@progbits
	.global frag_8c0728
frag_8c0728:
L_8c0728:
	add_s r1,r1,mlo
	.global sub_8c072a
sub_8c072a:
L_8c072a:
	nop_s
L_8c072c:
	mov.f 0x0,r0
L_8c0730:
	mov r0,-0x2
L_8c0734:
	mov.mi r0,0x1
L_8c0738:
	j_s.d [blink]
L_8c073a:
	ror r0,r0
L_8c073e:
	j_s.d [blink]
L_8c0740:
	mov r0,-0x1
