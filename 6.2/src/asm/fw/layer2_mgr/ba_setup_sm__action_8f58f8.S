/* ba_setup_sm__action_8f58f8 @ 0x8f58f8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__action_8f58f8
ba_setup_sm__action_8f58f8:
	.global L_8f58f8
L_8f58f8:
	stb_s r1,[r0,0x19]
L_8f58fa:
	stb_s r1,[r0,0x18]
L_8f58fc:
	stw_s r2,[r0,0x1e]
L_8f58fe:
	stw_s r2,[r0,0x1c]
L_8f5900:
	stb_s r3,[r0,0x1b]
L_8f5902:
	stb_s r3,[r0,0x1a]
L_8f5904:
	mov_s r1,0x0
L_8f5906:
	j_s.d [blink]
L_8f5908:
	stb_s r1,[r0,0x8]
L_8f590a:
	nop_s
