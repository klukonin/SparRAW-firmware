/* frag_8e4740 @ 0x8e4740, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lmac_if_send_cmd_0x08
 */
	.section .text.frag_8e4740,"ax",@progbits
	.global frag_8e4740
frag_8e4740:
L_8e4740:
	j_s [r1]
	.global sub_8e4742
sub_8e4742:
L_8e4742:
	nop_s
L_8e4744:
	ldb_s r3,[r0,0x14]
L_8e4746:
	mov_s r0,0x0
L_8e4748:
	mov_s r1,0x3
L_8e474a:
	mov_s r2,r0
L_8e474c:
	mov_s r4,r0
L_8e474e:
	mov r5,0x1
L_8e4752:
	b.d L_8d8864
L_8e4756:
	mov_s r6,r0
