/* mid__reset_10b_at_248 @ 0x8c44a4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step
 * Зовёт сам: __ld_r13_ret, memset0_words
 */
	.section .text.mid__reset_10b_at_248,"ax",@progbits
	.global mid__reset_10b_at_248
mid__reset_10b_at_248:
	.global L_8c44a4
L_8c44a4:
	push_s blink
L_8c44a6:
	push_s r13
L_8c44a8:
	mov_s r13,r0
L_8c44aa:
	add r0,r0,0xf8
L_8c44ae:
	bl.d L_8c1a78
L_8c44b2:
	mov_s r1,0xa
L_8c44b4:
	mov_s r0,0x14
L_8c44b6:
	add r13,r13,0x101
L_8c44ba:
	b.d L_8c033c
L_8c44be:
	stb_s r0,[r13]
