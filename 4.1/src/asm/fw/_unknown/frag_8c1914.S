/* frag_8c1914 @ 0x8c1914, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.frag_8c1914,"ax",@progbits
	.global frag_8c1914
frag_8c1914:
	.byte 0x4f
	.byte 0xff
	.global sub_8c1916
sub_8c1916:
L_8c1916:
	nop_s
L_8c1918:
	mov_s r1,0x8063f4
L_8c191e:
	mov_s r0,0x8007e8
L_8c1924:
	j_s.d [blink]
L_8c1926:
	st_s r0,[r1]
