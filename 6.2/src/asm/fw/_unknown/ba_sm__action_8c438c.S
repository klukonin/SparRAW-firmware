/* ba_sm__action_8c438c @ 0x8c438c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8c438c
ba_sm__action_8c438c:
	.global L_8c438c
L_8c438c:
	ld_s r0,[r0,0x40]
L_8c438e:
	ld_s r1,[r0,0x68]
L_8c4390:
	ld_s r1,[r1,0x8]
L_8c4392:
	j_s [r1]
