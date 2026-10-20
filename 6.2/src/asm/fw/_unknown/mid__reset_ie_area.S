/* mid__reset_ie_area @ 0x8c4e20, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__reset_bss_defaults
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set16h_s0_w2, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__reset_ie_area
mid__reset_ie_area:
	.global L_8c4e20
L_8c4e20:
	push_s blink
L_8c4e22:
	bl L_8c01e4
L_8c4e26:
	mov_s r13,r0
L_8c4e28:
	mov_s r14,r1
L_8c4e2a:
	add r0,r0,0x102
L_8c4e2e:
	bl.d L_8c1cd8
L_8c4e32:
	mov_s r1,0x1
L_8c4e34:
	bmsk r1,r14,0x1
L_8c4e38:
	add r13,r13,0x100
L_8c4e3c:
	add_s r0,r13,0x2
L_8c4e3e:
	bl L_8ed2d4
L_8c4e42:
	ldw_s r0,[r13,0x2]
L_8c4e44:
	bset_s r0,r0,0x2
L_8c4e46:
	b.d L_8c0254
L_8c4e4a:
	stw_s r0,[r13,0x2]
