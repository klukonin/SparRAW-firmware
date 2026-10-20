/* mac_parser__rule_a @ 0x8dfb3c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_parser__uses_rgf_886280, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__rule_a
mac_parser__rule_a:
	.global L_8dfb3c
L_8dfb3c:
	push_s blink
L_8dfb3e:
	bl.d L_8c01e4
L_8dfb42:
	mov_s r1,0x8
L_8dfb44:
	sub_s sp,sp,0x8
L_8dfb46:
	bl.d L_8c1cd8
L_8dfb4a:
	mov_s r0,sp
L_8dfb4c:
	mov_s r14,0x0
L_8dfb4e:
	mov_s r13,0x40
	.global L_8dfb50
L_8dfb50:
	mov_s r0,sp
L_8dfb52:
	mov_s r1,r14
L_8dfb54:
	bl.d L_8dfbd8
L_8dfb58:
	mov_s r2,0x3
L_8dfb5a:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dfb5c:
	/* brhs.d r13,0x1,0x008dfb50 */
	.byte 0xf5,0x0d,0x75,0x90
L_8dfb60:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dfb62:
	b.d L_8c0254
L_8dfb66:
	add_s sp,sp,0x8
