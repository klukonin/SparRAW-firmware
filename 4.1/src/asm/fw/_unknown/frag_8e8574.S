/* frag_8e8574 @ 0x8e8574, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.frag_8e8574,"ax",@progbits
	.global frag_8e8574
frag_8e8574:
L_8e8574:
	/* _sub_s r0,r0,0x4 */
	.byte 0x64,0xb8
	.global sub_8e8576
sub_8e8576:
L_8e8576:
	nop_s
L_8e8578:
	ld_s r2,[r0]
L_8e857a:
	ld_s r0,[r0,0x4]
L_8e857c:
	st_s r2,[r1]
L_8e857e:
	j_s.d [blink]
