/* mid__reset_10b_at_248 @ 0x8c4e04, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__reset_bss_defaults
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__reset_10b_at_248
mid__reset_10b_at_248:
	.global L_8c4e04
L_8c4e04:
	push_s blink
L_8c4e06:
	push_s r13
L_8c4e08:
	mov_s r13,r0
L_8c4e0a:
	add r0,r0,0xf8
L_8c4e0e:
	bl.d L_8c1cd8
L_8c4e12:
	mov_s r1,0xa
L_8c4e14:
	mov_s r0,0x14
L_8c4e16:
	add r13,r13,0x101
L_8c4e1a:
	b.d L_8c025c
L_8c4e1e:
	stb_s r0,[r13]
