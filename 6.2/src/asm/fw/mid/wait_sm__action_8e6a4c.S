/* wait_sm__action_8e6a4c @ 0x8e6a4c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wait_sm__action_8e6a4c
wait_sm__action_8e6a4c:
	.global L_8e6a4c
L_8e6a4c:
	stw_s r1,[r0,0xa]
L_8e6a4e:
	j_s.d [blink]
L_8e6a50:
	stb_s r2,[r0,0xc]
L_8e6a52:
	nop_s
