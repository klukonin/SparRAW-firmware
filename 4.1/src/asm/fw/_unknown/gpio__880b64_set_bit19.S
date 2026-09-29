/* gpio__880b64_set_bit19 @ 0x8e5524, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.gpio__880b64_set_bit19,"ax",@progbits
	.global gpio__880b64_set_bit19
gpio__880b64_set_bit19:
L_8e5524:
	j_s [blink]
	.global sub_8e5526
sub_8e5526:
L_8e5526:
	nop_s
L_8e5528:
	lr r0,[0xa]
L_8e552c:
	bclr r1,r0,0x1
L_8e5530:
	flag r1
L_8e5534:
	mov_s r1,0x880b00
L_8e553a:
	st 0x80000,[r1, 0x64]
L_8e5542:
	lr r1,[0xa]
L_8e5546:
	bic r0,r0,-0x3
L_8e554a:
	or_s r0,r0,r1
L_8e554c:
	flag r0
